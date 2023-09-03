//
//  StartView.swift
//  WhisperBoardKit
//
//  Created by jose Yun on 2023/09/03.
//

import SwiftUI

struct StartView: View {
  
  var body: some View {
    
    NavigationView {
      ZStack {
        Color.background.ignoresSafeArea(.all)
        VStack {
          
          NavigationLink(destination: RequestListView()) {
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
          }
          
          
          NavigationLink(destination: MainView()) {
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
          }.navigationBarBackButtonHidden(true)
          
        }.padding()
      }
    }
    
    .ignoresSafeArea()
  }
  
  
}



struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
