//
//  RequestListView.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct RequestListView: View {
  @EnvironmentObject var requirementViewModel: RequirementViewModel
  @Environment(\.dismiss) var dismiss
  
    var body: some View {
        NavigationStack {
            ZStack {
                // 배경색
                Color.background
                    .ignoresSafeArea()
                
                VStack {
                  
                    HStack {
                        Text("요청리스트")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color.bck)
                        
                        Spacer()
                    }
                    .padding(.top, 11)
                    
                    ScrollView {
                      ForEach(requirementViewModel.watingList.sorted{ $0.requestTime < $1.requestTime }) { request in
                        RequestList(request: request)
                      }
                        
                        CompletedList()
                    }
                    .scrollIndicators(.never)
                }
                .padding(.horizontal)
            }
            .navigationBarItems(leading: endListButton)
            .navigationBarItems(trailing: homeButton)
        }.navigationBarBackButtonHidden(true)
    }
    
    private var endListButton: some View {
        NavigationLink {
            AccomplishedListView()
        } label: {
            Image(systemName: "archivebox.circle.fill")
                .font(.system(size: 22))
                .foregroundColor(Color.gray)
        }
    }
    
    private var homeButton: some View {      
      HStack {
        Spacer()
        Button(action: { dismiss() }) {
          Image(systemName: "house.fill").foregroundColor(Color.gray).font(.system(size: 22))
        }
      }
    }
}




//struct RequestListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestListView()
//    }
//}
