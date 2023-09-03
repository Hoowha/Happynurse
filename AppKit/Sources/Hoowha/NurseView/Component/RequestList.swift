//
//  RequestList.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct RequestList: View {
    let categoryString = "호출"
    @State private var isCompleted = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(categoryString == "질문" ? Color.wte : (categoryString == "요청" ? Color.ppl : Color.bl))
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
                .foregroundColor(categoryString == "호출" ? Color.wte : Color.bck)
                
                Spacer()
                
                Button {
                    isCompleted.toggle()
                } label: {
                    Image(systemName: "checkmark.square")
                        .font(.system(size: 25))
                        .foregroundColor(categoryString == "호출" ? Color.org : Color.bl)
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
            .foregroundColor(Color.wte)
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(categoryString == "질문" ? Color.ppl : (categoryString == "요청" ? Color.bl : Color.org))
            }
    }
}
