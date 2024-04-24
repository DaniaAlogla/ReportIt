//
//  BugSubmissionView.swift
//  ReportIt
//
//  Created by Dania Alogla on 25/09/1445 AH.
//

import SwiftUI

struct BugSubmissionView: View {
    
    @ObservedObject var bugSubmissionViewModel = BugSubmissionViewModel()
    @State var image : UIImage?
    @State private var description = ""
    @State private var showImagePicker = false
    
    var body: some View {
        VStack(spacing: 20){
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(UIColor(red: 233/255,
                                          green: 233/255,
                                          blue: 233/255,
                                          alpha: 1))
                            , lineWidth: 1)
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(height: screenHeight * 0.3)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                } else {
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        Text("Select Image")
                            .frame(height: screenHeight * 0.3)
                    }
                }
            }
            .frame(height: screenHeight * 0.3)
            
            TextField("Please describe the bug",
                      text: $description,
                      axis: .vertical)
                .lineLimit(3...6)
                .textFieldStyle(.roundedBorder)
            
            Button {
                bugSubmissionViewModel.submitBug(Bug(description: description, image: image))
            } label: {
                Text("Submit")
                    .bold()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
        }.padding()
            .navigationTitle("Bug Submission")
            .navigationBarTitleDisplayMode(.automatic)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image)
            }
    }
}

#Preview {
    BugSubmissionView()
}
