//
//  ReportItWidgetExtension.swift
//  ReportItWidgetExtension
//
//  Created by Dania Alogla on 15/10/1445 AH.
//

import WidgetKit
import SwiftUI
import bug_api

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> BugsNumberEntry {
        BugsNumberEntry(date: Date(), bugsNumber: 8)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (BugsNumberEntry) -> ()) {
        let entry = BugsNumberEntry(date: Date(), bugsNumber: 8)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        fetchNumberOfBugs { retrievedNumberOfBugs in
            guard let retrievedNumberOfBugs = retrievedNumberOfBugs else { return }
            
            let data = BugsNumberEntry(date: Date(), bugsNumber: retrievedNumberOfBugs.bugsNumber)
            let timeline = Timeline(entries: [data], policy: .atEnd)
            completion(timeline)
        }
    }
    
    private func fetchNumberOfBugs(completion: @escaping (BugsNumberEntry?) -> Void) {
        RemoteBugsManager.shared.getNumberOfBugs { retrievedNumberOfBugs, error in
            if error == nil {
                if let retrievedNumberOfBugs {
                    completion(BugsNumberEntry(date: Date(), bugsNumber: retrievedNumberOfBugs))
                }
            }
        }
    }
}

struct BugsNumberEntry: TimelineEntry {
    let date: Date
    let bugsNumber: Int
}

struct ReportItWidgetExtensionEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("Bugs")
                
                Text("\(entry.bugsNumber)")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                Image(systemName: "ladybug.fill")
                    .font(.headline)
            }
            Spacer()
        }
    }
}

struct ReportItWidgetExtension: Widget {
    let kind: String = "ReportItWidgetExtension"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                ReportItWidgetExtensionEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ReportItWidgetExtensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    ReportItWidgetExtension()
} timeline: {
    BugsNumberEntry(date: .now, bugsNumber: 8)
    BugsNumberEntry(date: .now, bugsNumber: 8)
}
