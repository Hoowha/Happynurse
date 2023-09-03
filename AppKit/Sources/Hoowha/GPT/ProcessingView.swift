//
//  ProcessingView.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct ProcessingView: View {
    @EnvironmentObject var viewModel: GPTViewModel
    var body: some View {
        VStack {
            Text("처리중입니다.....")
            NavigationLink {
                ResultView()
            } label: {
                Text("다음")
            }
            .disabled(viewModel.answer == nil)
        }
        .onAppear {
            viewModel.sendMessage()
        }
    }
}
