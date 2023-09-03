//
//  GPTViewModel.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import Foundation

class GPTViewModel: ObservableObject {
    @Published var messages: [Message] = [
            Message(id: UUID(),
                    role: .system,
                    content: """
                             병원에서 환자가 여러 가지 요청을 하는 상황이야.
                             나는 환자고 너는 환자의 말을 요약해서 간호사에게 전달해야해.
                             [내용]에서 핵심 요청사항 하나를 뽑아 요약해줘.
                             기준에 맞춰 [카테고리]에 해당되는 것을 하나 뽑아줘.
                             답변 형식은 (카테고리: / 요약: )으로 부탁해.
                             요약은 15자 이내로 작성해줘.
                             [카테고리]
                             간호사 호출 - 간호사에게 의료 행위를 요청. 단순 답변을 요구하는 질문을 제외한다. ,
                             단순 심부름 - 간호사의 의료 행위를 제외한 요청사항. 간호사 외 다른 인물이 수행 가능한 요청사항을 포함한다.,
                             간단한 질문 - 답변을 요구하는 구체적인 질문. 수술, 퇴원, 입원 등 그 외 의료 관련 키워드를 포함해도 질문의 형태라면 이 카테고리로 분류한다.
                             """,
                    createAt: Date())
    ]
    
    @Published var currentInput: String = ""
    @Published var answer: Message?
    
    private let openAIManager = OpenAIManager()
    
    func sendMessage() {
        let newMessage = Message(id: UUID(), role: .user, content: "[내용] " + currentInput, createAt: Date())
        messages.append(newMessage)
        currentInput = ""
        
        Task {
            let response = await openAIManager.sendMessage(messages: messages)
            guard let receivedOpenAIMessage = response?.choices.first?.message else {
                print("Had no recevied message")
                return
            }
            let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
            await MainActor.run {
                messages.append(receivedMessage)
                answer = receivedMessage
            }
        }
    }
  
//    func splitString(inputStr: String) {
//        let arr = inputStr.split(separator: " / ")
//
//        category = String(arr[0].dropFirst(7))
//        summary = String(arr[1].dropFirst(4).dropLast(1))
//
//    }
}
