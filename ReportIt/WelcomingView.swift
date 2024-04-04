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
                    Text("report a bug")
                }
                
            }.navigationDestination(isPresented: $showBugSubmissionView) {
                BugSubmissionView()
            }
        }
    }
}

#Preview {
    WelcomingView()
}
