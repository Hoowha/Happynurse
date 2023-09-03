import AppDevUtils
import ComposableArchitecture
import Inject
import Popovers
import Setting
import SwiftUI
import SwiftUIIntrospect

// MARK: - SettingsScreen

struct SettingsScreen: ReducerProtocol {
  struct State: Equatable {
    var modelSelector = ModelSelector.State()
    var availableLanguages: IdentifiedArrayOf<VoiceLanguage> = []
    var appVersion: String = ""
    var buildNumber: String = ""
    var freeSpace: String = ""
    var takenSpace: String = ""
    var takenSpacePercentage: Double = 0
  
    @BindingState var settings: Settings = .init()
    @PresentationState var alert: AlertState<Action.Alert>?
    @BindingState var isICloudSyncInProgress = false
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case modelSelector(ModelSelector.Action)
    case task
    case updateInfo
    case openGitHub
    case openPersonalWebsite
    case deleteStorageTapped
    case rateAppTapped
    case reportBugTapped
    case suggestFeatureTapped

    case showError(EquatableErrorWrapper)
    case alert(PresentationAction<Alert>)

    enum Alert: Equatable {
      case deleteDialogConfirmed
    }
  }

  
  @Dependency(\.transcriptionWorker) var transcriptionWorker: TranscriptionWorkerClient
  @Dependency(\.settings) var settingsClient: SettingsClient
  @Dependency(\.openURL) var openURL: OpenURLEffect
  @Dependency(\.build) var build: BuildClient
  @Dependency(\.storage) var storage: StorageClient

  var body: some ReducerProtocol<State, Action> {
    BindingReducer()
      .onChange(of: \.settings.isICloudSyncEnabled) { oldValue, newValue in
        Reduce<State, Action> { _, _ in
          if oldValue != newValue, newValue {
            return .run { send in
              if settingsClient.getSettings().isICloudSyncEnabled != newValue {
                await send(.set(\.$isICloudSyncInProgress, true))
                try await storage.uploadRecordingsToICloud()
                await send(.set(\.$isICloudSyncInProgress, false))
              }
              try await settingsClient.updateSettings(settingsClient.getSettings().with(\.isICloudSyncEnabled, setTo: newValue))
            } catch: { error, send in
              await send(.set(\.$isICloudSyncInProgress, false))
              await send(.set(\.$settings, settingsClient.getSettings()))
              await send(.showError(error.equatable))
            }
          } else {
            return .none
          }
        }
      }

    Scope(state: \.modelSelector, action: /Action.modelSelector) {
      ModelSelector()
    }

    Reduce<State, Action> { state, action in
      switch action {
      case .binding:
        return .run { [settings = state.settings] _ in
          try await settingsClient.updateSettings(settings)
        } catch: { error, send in
          await send(.set(\.$settings, settingsClient.getSettings()))
          await send(.showError(error.equatable))
        }

      case .modelSelector:
        return .none

      case .task:
        updateInfo(state: &state)
        return .run { send in
          for try await settings in settingsClient.settingsPublisher().values {
            await send(.set(\.$settings, settings))
          }
        } catch: { error, send in
          await send(.showError(error.equatable))
        }

      case .updateInfo:
        updateInfo(state: &state)
        state.modelSelector = .init()
        return .send(.modelSelector(.onAppear))

      case .openGitHub:
        return .run { _ in
          await openURL(build.githubURL())
        }

      case .openPersonalWebsite:
        return .run { _ in
          await openURL(build.personalWebsiteURL())
        }

      case .deleteStorageTapped:
        createDeleteConfirmationDialog(state: &state)
        return .none

      case .alert(.presented(.deleteDialogConfirmed)):
        return .run { send in
          try await storage.deleteStorage()
          try await settingsClient.setValue(.default, forKey: \.selectedModel)
          await send(.updateInfo)
        } catch: { error, send in
          await send(.showError(error.equatable))
        }

      case let .showError(error):
        state.alert = .error(error)
        return .none

      case .rateAppTapped:
        return .run { _ in
          await openURL(build.appStoreReviewURL())
        }

      case .reportBugTapped:
        return .run { _ in
          await openURL(build.bugReportURL())
        }

      case .suggestFeatureTapped:
        return .run { _ in
          await openURL(build.featureRequestURL())
        }

      case .alert:
        return .none
      }
    }.ifLet(\.$alert, action: /Action.alert)
  }

  private func updateInfo(state: inout State) {
    state.appVersion = build.version()
    state.buildNumber = build.buildNumber()
    state.freeSpace = storage.freeSpace().readableString
    state.takenSpace = storage.takenSpace().readableString
    state.takenSpacePercentage = min(1, max(0, 1 - Double(storage.freeSpace()) / Double(storage.freeSpace() + storage.takenSpace())))
    state.availableLanguages = transcriptionWorker.getAvailableLanguages().identifiedArray
  }

  private func setSettings<Value: Codable>(_ value: Value, forKey keyPath: WritableKeyPath<Settings, Value>) -> EffectPublisher<Action, Never> {
    .run { _ in
      try await settingsClient.setValue(value, forKey: keyPath)
    } catch: { error, send in
      await send(.showError(error.equatable))
    }
  }

  private func createDeleteConfirmationDialog(state: inout State) {
    state.alert = AlertState {
      TextState("Confirmation")
    } actions: {
      ButtonState(role: .cancel) {
        TextState("Cancel")
      }
      ButtonState(role: .destructive, action: .deleteDialogConfirmed) {
        TextState("Delete")
      }
    } message: {
      TextState("Are you sure you want to delete all recordings and all downloaded models?")
    }
  }
}

// MARK: - RemoteTranscriptionImage

struct RemoteTranscriptionImage: View {
  @ObserveInjection var inject

  @State private var animating = false

  private let featureDescription = "Transcribe your recordings in the cloud super fast using the most capable"
  private let modelName = "Large-v2 Whisper model"

  var body: some View {
    VStack(spacing: 0) {
      WhisperBoardKitAsset.remoteTranscription.swiftUIImage
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 70)
        .padding(.grid(2))
        .background(
          WhisperBoardKitAsset.remoteTranscription.swiftUIImage
            .resizable()
            .blur(radius: animating ? 30 : 20)
            .padding(.grid(2))
            .opacity(animating ? 1.0 : 0.3)
            .animation(Animation.interpolatingSpring(stiffness: 3, damping: 0.3).repeatForever(autoreverses: false), value: animating)
        )
        .onAppear { animating = true }

      VStack(spacing: 0) {
        Text(featureDescription)
          .font(.DS.headlineS)
          .foregroundColor(.DS.Text.base)
        Text(modelName).shadow(color: .black, radius: 1, y: 1)
          .background(Text(modelName).blur(radius: 7))
          .font(.DS.headlineL)
          .foregroundStyle(
            LinearGradient(
              colors: [.DS.Text.accent, .DS.Background.accentAlt],
              startPoint: .leading,
              endPoint: .trailing
            )
          )
      }
      .multilineTextAlignment(.center)
      .padding([.leading, .bottom, .trailing], .grid(2))
    }
    .enableInjection()
  }
}

// MARK: - SettingsScreenView

struct SettingsScreenView: View {
  
  @EnvironmentObject var stateSettings: StateSettings
  
  struct ViewState: Equatable {
    var selectedModelReadableName: String
    var availableLanguages: IdentifiedArrayOf<VoiceLanguage>
    var appVersion: String
    var buildNumber: String
    var freeSpace: String
    var takenSpace: String
    var takenSpacePercentage: Double
    @BindingViewState var settings: Settings
    @BindingViewState var isICloudSyncInProgress: Bool
  }

  @ObserveInjection var inject

  let store: StoreOf<SettingsScreen>

  @ObservedObject var viewStore: ViewStore<ViewState, SettingsScreen.Action>

  @State var debugPresent = false

  var modelSelectorStore: StoreOf<ModelSelector> {
    store.scope(state: \.modelSelector, action: SettingsScreen.Action.modelSelector)
  }

  init(store: StoreOf<SettingsScreen>) {
    self.store = store
    viewStore = ViewStore(store) { state in
      ViewState(
        selectedModelReadableName: state.modelSelector.selectedModel.readableName,
        availableLanguages: state.availableLanguages,
        appVersion: state.appVersion,
        buildNumber: state.buildNumber,
        freeSpace: state.freeSpace,
        takenSpace: state.takenSpace,
        takenSpacePercentage: state.takenSpacePercentage,
        settings: state.$settings,
        isICloudSyncInProgress: state.$isICloudSyncInProgress
      )
    }
  }

  var body: some View {
    
    ZStack {
      
      Color.bl.ignoresSafeArea()
      
      VStack {
            
        SettingStack {
          SettingPage(title: "", backgroundColor: Color.bl) {
            SettingCustomView(id: "models") {
              ForEachStore(modelSelectorStore.scope(state: \.modelRows, action: ModelSelector.Action.modelRow)) { modelRowStore in
                ModelRowView(store: modelRowStore)
              }
              .removeClipToBounds()
            }
          }
        }.ignoresSafeArea()
        .onAppear {
          viewStore.send(.modelSelector(.onAppear))
          viewStore.send(.updateInfo)
        }.frame(height: UIScreen.main.bounds.height * 0.1)
        .environment(\.settingBackgroundColor, .DS.Background.primary)
        .environment(\.settingSecondaryBackgroundColor, .DS.Background.secondary)
        .alert(store: modelSelectorStore.scope(state: \.$alert, action: { .alert($0) }))
        .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
        .task { viewStore.send(.task) }
        .enableInjection()
        
        Spacer()

        Image("Logo").resizable().scaledToFit().padding()

        Spacer()

        VStack(spacing: 15) {

          Text("본 화면은 MVP 제출을 위해 제작되었습니다.").bold()
            .font(.system(size: 20))

          Text("이 어플은 별도의 서비스로 제공될\n환자용과 간호사용을 모두 통합하여 개발한\n테스트용 어플리케이션입니다")
            .multilineTextAlignment(.center)
            .font(.system(size: 16))

        }.padding()

        Spacer()
        
      }
    }
    .ignoresSafeArea()
    .background(Color.bl)
  }
}

// MARK: - SmallButtonStyle

struct SmallButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.DS.bodyM)
      .foregroundColor(.DS.Text.accentAlt)
      .padding(.horizontal, .grid(2))
      .padding(.vertical, .grid(1))
      .background(
        RoundedRectangle(cornerRadius: .grid(1))
          .fill(Color.DS.Background.accentAlt.opacity(0.2))
      )
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

private extension String {
  static let modelSelectorFooter = """
  Whisper ASR, by OpenAI, is an advanced system that converts spoken words into written text. It's perfect for transcribing conversations or speeches.

  The model is a neural network that takes an audio file as input and outputs a sequence of characters.
  """
}

// MARK: - SettingsScreen_Previews

struct SettingsScreen_Previews: PreviewProvider {
  struct ContentView: View {
    var body: some View {
      SettingsScreenView(
        store: Store(
          initialState: SettingsScreen.State(),
          reducer: { SettingsScreen() }
        )
      )
    }
  }

  static var previews: some View {
    ContentView()
  }
}
