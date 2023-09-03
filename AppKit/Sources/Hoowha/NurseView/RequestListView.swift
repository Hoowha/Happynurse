//
//  RequestListView.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct RequestListView: View {
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
                        RequestList()
                        
                        CompletedList()
                    }
                    .scrollIndicators(.never)
                }
                .padding(.horizontal)
            }
            
            .navigationBarItems(leading: endListButton)
            .navigationBarItems(trailing: loginInfoButton)
        }
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
    
    private var loginInfoButton: some View {
        NavigationLink {
            EmptyView()
        } label: {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 22))
                .foregroundColor(Color.gray)
        }
    }
}




//struct RequestListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestListView()
//    }
//}
