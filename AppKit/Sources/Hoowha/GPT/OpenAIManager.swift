//
//  OpenAIManager.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import Foundation
import Alamofire

class OpenAIManager {
    private let endpointURL = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
        let openAIMessages = messages.map{ OpenAIChatMessage(role: $0.role, content: $0.content) }
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAIMessages, temperature: 0.8)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Key.openAIApiKey)"
        ]
        
        return try? await AF.request(endpointURL, method: .post, parameters: body, encoder: .json, headers: headers).serializingDecodable(OpenAIChatResponse.self).value
    }
}


// 공식 문서 읽어보며 필요한 struct 구성하기
struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
    let temperature: Float
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
}

struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
}

struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}
