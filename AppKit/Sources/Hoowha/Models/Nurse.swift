//
//  Nurse.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct Nurse: Identifiable {
  let id = UUID()
  let employeeNumber: String  // 사번
  
  var watingList: [Requirement]
  var doneList: [Requirement]
  var endList: [Requirement]
  
}
