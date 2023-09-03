//
//  RecordView.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct RecordView: View {
    @EnvironmentObject var viewModel: GPTViewModel
    @ObservedObject var stateSettings = StateSettings()
  
    var body: some View {
        NavigationStack {
            VStack {
                Text("대충 녹음하는 뷰.. 오디오? 비주얼라이저")
                
                //MARK: 음성 입력 대신 일단 텍스트로 받음
                TextField("여기에 입력하시오", text: $viewModel.currentInput)
                
//                Button {
//                    viewModel.sendMessage()
//                } label: {
//                    Text("요약")
//                }
                
                Spacer()
                

                NavigationLink {
                    ProcessingView()
                } label: {
                    Text("요청 완료하기")
                }
            }
        }
    }
}
