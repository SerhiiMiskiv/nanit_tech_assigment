//
//  BirthdayScreen.swift
//  nanit_tech_assigment
//
//  Created by Serj Miskiv on 14.06.2022.
//

import SwiftUI

struct BirthdayView: View {
    let name: String
    let dateOfBirth: Date
    @State var choosenImage: UIImage
    @State var showSheet = false

    var body: some View {
        NavigationView {
            Form {
                Text("TODAY " + name.uppercased() + " IS")
                Text("MONTH OLD!")

                HStack {
                    Image(uiImage: self.choosenImage)
                        .resizable()
                        .cornerRadius(50)
                        .frame(width: 100, height: 100)
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                    
                    Button("Choose photo") {
                        showSheet = true
                    }
                }
                
                
                Button("Share the news") {
                    print("Button tapped!")
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$choosenImage)
        }
    }
}

private struct BirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayView(
            name: "John Doe",
            dateOfBirth: Date.now,
            choosenImage: UIImage()
        )
    }
}
