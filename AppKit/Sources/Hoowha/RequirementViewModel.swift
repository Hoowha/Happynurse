//
//  RequirementViewModel.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

class RequirementViewModel: ObservableObject {
  @Published var watingList: [Requirement] = []
  @Published var doneList: [Requirement] = []
  @Published var endList: [Requirement] = []
  
  @Published var patient = Patient(patientNumber: "patientA", name: "홍길동", roomNumber: 2113, bedNumber: 3, requirements: [])
  
  init() {
    makeValue()
  }
}

extension RequirementViewModel {
  func makeValue() {
    let tempPatient = Patient(patientNumber: "patientB", name: "강백호", roomNumber: 2105, bedNumber: 6, requirements: [])
    
    let tempWaitingRequest1 = Requirement(patient: tempPatient, category: "호출", summary: "링거 바늘이 빠져 출혈", requestTime: Calendar.current.date(byAdding: .minute, value: -5, to: Date())!, isDone: false)
    let tempWaitingRequest2 = Requirement(patient: tempPatient, category: "질문", summary: "검사 결과 예정 시간", requestTime: Calendar.current.date(byAdding: .minute, value: -2, to: Date())!, isDone: false)
    
    self.watingList.append(tempWaitingRequest1)
    self.watingList.append(tempWaitingRequest2)
    
    let tempEndRequest1 = Requirement(patient: tempPatient, category: "호출", summary: "수술 부위 통증", requestTime: Calendar.current.date(byAdding: .hour, value: -1, to: Date())!, isDone: false)
    let tempEndRequest2 = Requirement(patient: tempPatient, category: "요청", summary: "물 가져다주세요", requestTime: Calendar.current.date(byAdding: .hour, value: -2, to: Date())!, isDone: false)
    
    self.endList.append(tempEndRequest1)
    self.endList.append(tempEndRequest2)
  }
}
