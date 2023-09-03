//
//  FinishView.swift
//  WhisperBoardKit
//
//  Created by jose Yun on 2023/09/03.
//

import SwiftUI

struct FinishView: View {
  
  @EnvironmentObject var stateSettings: StateSettings
  
    var body: some View {
      VStack {
        Spacer()
        
        Image(systemName: "checkmark.circle.fill").foregroundColor(.skyBl).font(.system(size: 95))
        Text("요청이 성공적으로 전달되었습니다!").foregroundColor(.bck).font(.system(size: 20))
        
        Spacer()
        
        Button(action: {
          stateSettings.requests.append(stateSettings.whisperChat)
          stateSettings.isRecording.toggle() }){
          ZStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.06)
              .background(Color.skyBl)
              .cornerRadius(15)
              .padding()
            
            Text("처음으로 돌아가기").foregroundColor(.white).bold().font(.system(size: 18))
          }.padding()
          
        }
        
      }.ignoresSafeArea(.all)
    }
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView()
    }
}
