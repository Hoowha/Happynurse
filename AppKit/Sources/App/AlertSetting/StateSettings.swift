//
//  StateSettings.swift
//  WhisperBoardKit
//
//  Created by jose Yun on 2023/09/03.
//

import SwiftUI

class StateSettings: ObservableObject {
  @Published var isDownloading = true
  @Published var isRecording = false
  @Published var whisperChat = ""
  @Published var whisperProcessing: Int = 0
  @Published var chatGPTChat = ""
  // 0: recording
  // 1: progressive
  // 2: checking
  // 3: finishing
  @Published var convertStage: Int = 0
  @Published var requests: [String] = []
  
}
