//
//  MainView.swift
//  WhisperBoard
//
//  Created by jose Yun on 2023/09/03.
//

import SwiftUI

struct MainView: View {
    
  @EnvironmentObject var stateSettings: StateSettings
  @Environment(\.dismiss) var dismiss
    var body: some View {
      
      
        ZStack {
          Color.background.ignoresSafeArea(.all)
          VStack {
            
            HStack {
              Spacer()
              Button(action: { dismiss() }) {
                Image(systemName: "house.fill").foregroundColor(.lGry).font(.system(size: 28))
              }.padding()
            }.padding().padding(.top)
            
            HStack(spacing: 0) {
              Image(systemName: "cross.circle.fill").foregroundColor(Color.bck).bold().font(.system(size: 30))
              Text(" 서울SKT병원").foregroundColor(Color.bck).bold().font(.system(size: 30))
              Spacer()
              
              
            }.padding(.horizontal)
            
            Spacer()
            
            
            Button(action: {
              stateSettings.convertStage = 0
              stateSettings.isRecording = true
            }) {
              ZStack {
                Rectangle()
                  .foregroundColor(.clear)
                  .background(Color.skyBl)
                  .cornerRadius(20)
                  .frame(height: UIScreen.main.bounds.height * 0.33)
                VStack(alignment: .leading) {
                  HStack {
                    Spacer()
                    Image(systemName: "mic").foregroundColor(.white).font(.system(size: 70))
                  }
                  
                  
                  Spacer()
                  Text("문의사항 요청하기").foregroundColor(.white).bold().font(.title)
                  
                  Text("터치 시 음성인식이 시작됩니다").foregroundColor(.white).bold().font(.system(size: 12))
                    .padding(.bottom)
                  
                }.padding().padding(.horizontal)
              }.frame(height: UIScreen.main.bounds.height * 0.33)
            }.padding(.horizontal)
            
//            NavigationLink(destination: StartView()) {
//              ZStack {
//                Rectangle()
//                  .foregroundColor(.clear)
//                  .background(Color.whtBl)
//                  .cornerRadius(20)
//                HStack {
//                  Text("문의사항 목록").bold().font(.title).foregroundColor(.skyBl)
//                  Spacer()
//                  Image(systemName: "list.bullet.clipboard").foregroundColor(.skyBl).font(.system(size: 40))
//                }.padding().padding(.horizontal)
//              }.frame(height: UIScreen.main.bounds.height * 0.11)
//            }.padding(.horizontal)
            
            Spacer()
            Spacer()
            
          }
        }.ignoresSafeArea(.all)
        .navigationBarBackButtonHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
