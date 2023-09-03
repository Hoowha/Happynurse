//
//  StartView.swift
//  WhisperBoardKit
//
//  Created by jose Yun on 2023/09/03.
//

import SwiftUI

struct StartView: View {
  var body: some View {
    ZStack {
      Color.background
      VStack {
        ZStack {
          Rectangle()
            .foregroundColor(.clear)
            .background(.white)
            .cornerRadius(20)
            .frame(height: UIScreen.main.bounds.height * 0.2 )
          HStack {
            Image(systemName: "stethoscope")
            Text("간호사")
          }.bold().font(.system(size: 20)).foregroundColor(.bck)
        }
        
        ZStack {
          Rectangle()
            .foregroundColor(.clear)
            .background(.white)
            .cornerRadius(20)
            .frame(height: UIScreen.main.bounds.height * 0.2 )
          
          HStack {
            Image(systemName: "bed.double.fill")
            Text("환자")
          }.bold().font(.system(size: 20)).foregroundColor(.bck)
        }
      }.padding()
    }
  }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
