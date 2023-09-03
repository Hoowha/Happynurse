//
//  AccomplishedListView.swift
//  WhisperBoardKit
//
//  Created by Chaeeun Shin on 2023/09/03.
//

import SwiftUI

struct AccomplishedListView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var requirementViewModel: RequirementViewModel
  
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView {
                  ForEach(requirementViewModel.endList.sorted{ $0.requestTime < $1.requestTime }) { request in
                    RequestList(request: request)
                  }
                }
                .scrollIndicators(.never)
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: BackButton)
            .navigationBarItems(trailing: Image(systemName: "trash.fill").foregroundColor(Color.bl))
            .navigationTitle("이전 요청리스트")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var BackButton: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 3) {
                Image(systemName: "chevron.backward")
                Text("요청리스트")
            }
            .foregroundColor(Color.bl)
        }
    }
}

struct AccomplishedListView_Previews: PreviewProvider {
    static var previews: some View {
        AccomplishedListView()
    }
}

