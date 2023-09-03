//
//  DateFormat.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import Foundation

func dateString(date: Date) -> String {
    let myFormatter = DateFormatter()
    myFormatter.dateFormat = "HH:mm"
    
    let dateString = myFormatter.string(from: date)
    
    return dateString
}
