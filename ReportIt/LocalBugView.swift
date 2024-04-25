//
//  BugView.swift
//  ReportIt
//
//  Created by Dania Alogla on 16/10/1445 AH.
//

import SwiftUI

struct LocalBugView: View {
    
    let bug : LocalBug
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("# \(getDateFormatter(date: bug.createdOn))")
                .bold()
            
            AsyncImage(url: bug.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                
                } placeholder: {
                    ProgressView()
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(bug.description)
                .lineLimit(6)
            
            
        }.frame(width: UIScreen.main.bounds.width * 0.8)
            .padding()
    }
}

public func getDateFormatter(date : Date , format : String = "yyyy-MM-dd HH:mm") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}
