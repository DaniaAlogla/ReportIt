//
//  HistoryView.swift
//  ReportIt
//
//  Created by Dania Alogla on 16/10/1445 AH.
//

import Foundation

struct HistoryView: View {
    @ObservedObject var bugsHistoryViewModel = BugsHistoryViewModel()
    var body: some View {
        VStack {
            ScrollView {
                ForEach(bugsHistoryViewModel.bugs, id: \.self) { bug in
                    LocalBugView(bug: bug)
                }
            }

        }.navigationTitle("History")
    }
}
