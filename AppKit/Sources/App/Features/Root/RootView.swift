import AppDevUtils
import Combine
import ComposableArchitecture
import Inject
import SwiftUI

// MARK: - RootView

struct RootView: View {
  @ObserveInjection var inject
  @ObservedObject var gptModel = GPTViewModel()
  @ObservedObject var requirementModel = RequirementViewModel()
  
  @ObservedObject var stateSettings = StateSettings()

  let store: StoreOf<Root>

  @ObservedObject var viewStore: ViewStore<Root.Tab, Root.Action>

  @Namespace var animation

  init(store: StoreOf<Root>) {
    self.store = store
    viewStore = ViewStore(store) { $0.selectedTab }
  }
  
  

  var body: some View {
    VStack{
      if stateSettings.isDownloading {
        ZStack {
          Color.bl.ignoresSafeArea()
          SettingsScreenView(store: store.scope(state: \.settingsScreen, action: Root.Action.settingsScreen)).environmentObject(stateSettings)
        }
      } else {
        
          StartView().environmentObject(stateSettings)
          .fullScreenCover(isPresented: $stateSettings.isRecording) {
            VStack {

              ZStack {
                // background whisper
                RecordingListScreenView(store: store.scope(state: \.recordingListScreen, action: Root.Action.recordingListScreen)).environmentObject(stateSettings).opacity(0)
                
                // if not converting -> recording
                if stateSettings.convertStage == 0 {
                  RecordScreenView(store: store.scope(state: \.recordScreen, action: Root.Action.recordScreen)).environmentObject(stateSettings)
                } else if stateSettings.convertStage == 1 { // after recording should converting
                  ZStack {
                    Color.background.ignoresSafeArea(.all)
                    ProgressView(label: { Text("요청 사항을 변환하고 있습니다.").font(.system(size: 18)).bold().foregroundColor(.gry) })
                  }.ignoresSafeArea(.all)
                } else if stateSettings.convertStage == 2 {
                  CheckView().environmentObject(stateSettings)
                    .environmentObject(gptModel)
                } else {
                  FinishView().environmentObject(stateSettings)
                }
              }
              .onChange(of: stateSettings.whisperProcessing) { processingStep in
                
//                print("stateSettings.whisperChat", stateSettings.whisperChat)
                if processingStep == 2 {
                  gptModel.currentInput = stateSettings.whisperChat
                  gptModel.sendMessage()
                  stateSettings.convertStage = 2
                }
                
              }

            }
          }
          
          .onChange(of: gptModel.answer?.content) { _ in
            print("stateSettings.whisperChat", stateSettings.whisperChat)
            print("stateSettings.chatGPTChat", stateSettings.chatGPTChat)

            stateSettings.chatGPTChat = gptModel.answer!.content
            stateSettings.convertStage = 2

          }
        

      }
      //    )
    }
    .accentColor(.white)
//    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: viewStore.rawValue)
    .task { viewStore.send(.task) }
    .enableInjection()
  }
}

// MARK: - TabBarItem

struct TabBarItem: View {
  let icon: String

  let tag: Int

  @Binding var selectedTab: Int

  var body: some View {
    Button(action: {
      withAnimation(.gentleBounce()) {
        selectedTab = tag
      }
    }) {
      Image(systemName: icon)
        .font(selectedTab == tag ? .DS.headlineM.weight(.bold) : .DS.headlineM.weight(.light))
        .frame(width: 50, height: 50)
        .foregroundColor(selectedTab == tag ? Color.DS.Text.accent : Color.DS.Text.base)
        .cornerRadius(10)
    }
  }
}

// MARK: - Root_Previews

struct Root_Previews: PreviewProvider {
  struct ContentView: View {
    var body: some View {
      RootView(
        store: Store(
          initialState: Root.State(),
          reducer: { Root() }
        )
      )
    }
  }

  static var previews: some View {
    ContentView()
  }
}
