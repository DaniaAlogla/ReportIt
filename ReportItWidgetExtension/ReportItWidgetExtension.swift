//
//  ReportItWidgetExtension.swift
//  ReportItWidgetExtension
//
//  Created by Dania Alogla on 15/10/1445 AH.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> BugsNumberEntry {
        BugsNumberEntry(date: Date(), bugsNumber: 8)
    }

    func getSnapshot(in context: Context, completion: @escaping (BugsNumberEntry) -> ()) {
        let entry = BugsNumberEntry(date: Date(), bugsNumber: 8)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [BugsNumberEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = BugsNumberEntry(date: entryDate, bugsNumber: 8)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
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
