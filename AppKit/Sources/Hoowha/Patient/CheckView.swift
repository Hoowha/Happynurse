//
//  CheckView.swift
//  WhisperBoardKit
//
//  Created by jose Yun on 2023/09/03.
//

import SwiftUI

struct CheckView: View {
  
  @EnvironmentObject var stateSettings: StateSettings

  var body: some View {
    
    ZStack {
      Color.background.ignoresSafeArea(.all)
      VStack {
        Spacer()
        
        HStack {
          Text("입력하신 내용을").foregroundColor(.lGry).bold().font(.system(size:15))
          Spacer()
        }.padding()
        
        ZStack {
          RoundedRectangle(cornerRadius: 20).foregroundColor(.white)
          Text("\(stateSettings.whisperChat)").foregroundColor(.bck).bold().font(.system(size: 25))
            .multilineTextAlignment(.leading)
            .lineLimit(nil).padding()
        }.padding()
        
        HStack {
          Spacer()
          Text("(으)로 전달하겠습니다.").foregroundColor(.bck).bold().font(.system(size: 20))
        }.padding()
        
        Spacer()
        
        HStack {
          
          Button(action: { stateSettings.convertStage = 0 }) {
            ZStack{
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 176, height: 50)
                .background(Color.whtBl)
                .cornerRadius(15)
              Text("다시 요청할래요").foregroundColor(.skyBl).bold().font(.system(size: 18))
            }
          }
          Button(action: { stateSettings.convertStage = 3 }) {
            ZStack{
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 176, height: 50)
                .background(Color.skyBl)
                .cornerRadius(15)
              Text("전달해주세요").foregroundColor(.white).bold().font(.system(size: 18))
            }
          }
        }.padding()
        
      }
      
    }
  }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
        CheckView()
    }
}
