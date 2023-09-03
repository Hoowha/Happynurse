//
//  ResultView.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var viewModel: GPTViewModel
    @State private var category = ""
    @State private var summary = ""
    
    var body: some View {
        VStack {
            if let answer = viewModel.answer {
                Text(dateString(date:answer.createAt))
                
                Text(answer.content)
                
                Button {
                    splitString(inputStr: answer.content)
                } label: {
                    Text("문자열 나누기")
                }

                Text(category)
                Text(summary)
            }
        }
    }
    
    func splitString(inputStr: String) {
        let arr = inputStr.split(separator: " / ")
        
        category = String(arr[0].dropFirst(7))
        summary = String(arr[1].dropFirst(4).dropLast(1))
        
    }
    
}
