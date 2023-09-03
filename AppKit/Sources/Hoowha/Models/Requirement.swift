//
//  Requirement.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct Requirement: Identifiable {
  let id = UUID()
  let patient: Patient
  let category: String
  let summary: String
  let requestTime: Date
  let isDone: Bool
}
