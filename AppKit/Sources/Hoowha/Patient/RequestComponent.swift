////
////  RequestComponent.swift
////  WhisperBoardKit
////
////  Created by jose Yun on 2023/09/03.
////
//
//import SwiftUI
//
//struct RequestComponent: View {
//
//    @State private var showNoteViewModal = false
//    @State private var resetSwipe: Bool = false
//    @State private var trashPresented: Bool = false
//    @Binding var yourCards: [ProfileCardModel]
//    @State var isDelete = false
//
//    var request: String
//
//    var body: some View {
//        RoundedRectangle(cornerRadius: 10)
//            .foregroundColor(.white)
//            .frame(height: UIScreen.height * 0.1)
//            .overlay() {
//                SwipeItemView(content: {
//                    HStack {
//                      Text("\(request)")
//                        .bold()
//                        .font(.system(size: 24))
//                        .foregroundColor(.skyBl)
//                    }
//                }, right: {
//                    HStack(spacing: 0) {
//                        Button {
//                            isDelete = true
//                        } label: {
//                            Rectangle()
//                                .fill(.red)
//                                .cornerRadius(10, corners: .topRight)
//                                .cornerRadius(10, corners: .bottomRight)
//                                .overlay(){
//                                    Image(systemName: "trash.fill")
//                                        .font(.system(size: 22))
//                                        .foregroundColor(.white)
//                                        .offset(x: -2)
//                                }
//                        }
//
//                        .confirmationDialog("요청을 취소하시겠습니까?", isPresented: $isDelete, titleVisibility: .visible
//                        ) {
//                            Button("삭제", role: .destructive) {
//                                yourCards.removeAll { $0.id == profileCard.id }
//                                PreferenceManager.collections = yourCards
//                                resetSwipe = true
//                                isDelete.toggle()
//
//                            }
//                            Button("취소", role: .cancel) {
//                                resetSwipe = true
//                                isDelete.toggle()
//                            }
//                            }
//
//                    }
//                }, itemHeight: UIScreen.height * 0.1, resetSwipe: $resetSwipe, trashPresented: $trashPresented)
//            }
//            .cornerRadius(10, corners: .allCorners)
//            .frame(height: UIScreen.height * 0.1)
//    }
//}
//
//
//
//struct SwipeItemView<Content: View, Right: View>: View {
//    var content: () -> Content
//    var right: () -> Right
//    var itemHeight: CGFloat
//    @Binding var resetSwipe: Bool
//    @Binding var trashPresented: Bool
//
//    init(content: @escaping () -> Content, right: @escaping () -> Right, itemHeight: CGFloat, resetSwipe: Binding<Bool>, trashPresented: Binding<Bool>) {
//        self.content = content
//        self.right = right
//        self.itemHeight = itemHeight
//        self._resetSwipe = resetSwipe
//        self._trashPresented = trashPresented
//    }
//
//    @State var hoffSet: CGFloat = 0
//    @State var anchor: CGFloat = 0
//
//    let screenWidth = UIScreen.main.bounds.width
//    var anchorWidth: CGFloat = 78
//    var swipeThreshold: CGFloat { screenWidth / 20 }
//
//    @State var rightPast = false
//
//    var drag: some Gesture {
//        DragGesture()
//            .onChanged { value in
//                withAnimation {
//                    hoffSet = anchor + value.translation.width
//
//                    if abs(hoffSet) > anchorWidth {
//                        if rightPast {
//                            hoffSet = -anchorWidth
//                        }
//                    }
//
//                    if anchor < 0 {
//                        rightPast = hoffSet < -anchorWidth + swipeThreshold
//                    } else {
//                        rightPast = hoffSet < -swipeThreshold
//                    }
//                }
//            }
//            .onEnded { value in
//                withAnimation {
//                    if rightPast {
//                        anchor = -anchorWidth
//                        trashPresented = true
//                    } else {
//                        anchor = 0
//                        trashPresented = false
//                    }
//                    hoffSet = anchor}
//            }
//    }
//
//    var body: some View {
//        GeometryReader { geo in
//            HStack() {
//                content()
//                    .frame(width: geo.size.width)
//                    .contentShape(Rectangle())
//                    .buttonStyle(.borderless)
//                    .highPriorityGesture(drag)
//                right()
//                    .frame(width: anchorWidth)
//                    .zIndex(1)
//                    .clipped()
//                    .buttonStyle(.borderless)
//            }
//            .offset(x: hoffSet)
//            .frame(maxHeight: itemHeight)
//            .contentShape(Rectangle())
//            .gesture(drag)
//            .onChange(of: resetSwipe) { newValue in
//                if newValue {
//                    withAnimation {
//                        anchor = 0
//                        hoffSet = 0
//                        resetSwipe = false
//                    }
//                }
//            }
//            .highPriorityGesture(drag)
//        }
//    }
//}
//
//
//struct RequestComponent_Previews: PreviewProvider {
//    static var previews: some View {
//      RequestComponent( saveAction: {})
//    }
//}
//
