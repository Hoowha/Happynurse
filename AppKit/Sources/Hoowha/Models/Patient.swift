//
//  Patient.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct Patient: Identifiable {
  let id = UUID()
  let patientNumber: String // 병원내 환자 번호
  let name: String
//  var nurse: Nurse
  let roomNumber: Int
  let bedNumber: Int
  var requirements: [Requirement]
}
