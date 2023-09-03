//
//  CompletedList.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct CompletedList: View {
    let categoryString = "호출"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.wte)
                .frame(maxWidth: .infinity, idealHeight: 100)
            
            HStack {
                VStack {
                    HStack(spacing: 6) {
                        // 호실
                        Text("205")
                            .fontWeight(.medium)
                        
                        // 침대 번호
                        Text("5")
                            .fontWeight(.light)
                        
                        // 환자 이름
                        Text("홍길동")
                            .fontWeight(.medium)
                        
                        // 요청 시간
                        Text("13:52")
                            .fontWeight(.light)
                        
                        Spacer()
                    }
                    .font(.system(size: 16))
                    
                    HStack(spacing: 10) {
                        // 요청 카테고리
                        category
                                        
                        // 요청 요약
                        Text("검사 결과 언제 나오나요?")
                            .font(.system(size: 20, weight: .semibold))
                        
                        Spacer()
                    }
                }
                .foregroundColor(.gray)
                
                Spacer()
                
                Button {
                    // VM 에서 왔다갔다 하는고~~~
//                    isCompleted.toggle()
                } label: {
                    Image(systemName: "checkmark.square.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                }
            }
            .padding(.leading, 15)
            .padding(.trailing, 20)
        }
    }
    
    private var category: some View {
        // 요청 카테고리
        Text(categoryString)
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(categoryString == "질문" ? Color.bl: Color.wte)
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(.gray)
            }
    }
}
