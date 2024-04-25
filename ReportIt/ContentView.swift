//
//  ContentView.swift
//  ReportIt
//
//  Created by Dania Alogla on 25/09/1445 AH.
//

import SwiftUI

struct ContentView: View {
    @Binding var opendURL : Bool

    var body: some View {
            WelcomingView(showHistoryView: $opendURL)
        
    }
}

#Preview {
    ContentView(opendURL: .constant(false))
}
