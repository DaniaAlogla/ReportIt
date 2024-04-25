//
//  WelcomingView.swift
//  ReportIt
//
//  Created by Dania Alogla on 25/09/1445 AH.
//

import SwiftUI

struct WelcomingView: View {
    
    @State var showBugSubmissionView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "ladybug.fill")
                    .font(.title)
                
                Text("Welcome to ReportIt")
                    .font(.title)
                    .padding()
                
                Button {
                    showBugSubmissionView.toggle()
                } label: {
                    Text("Report a bug")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    showHistoryView.toggle()
                } label: {
                    Text("View history")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
            }.padding()
            .navigationDestination(isPresented: $showBugSubmissionView) {
                BugSubmissionView()
            }
            .navigationDestination(isPresented: $showHistoryView) {
                HistoryView()
            }
        }
    }
}

#Preview {
    WelcomingView()
}
