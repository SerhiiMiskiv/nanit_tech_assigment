//
//  ContentView.swift
//  nanit_tech_assigment
//
//  Created by Serj Miskiv on 14.06.2022.
//

import SwiftUI

struct WelcomeView: View {
    @State private var name = ""
    @State private var dateOfBirth = Date.now
    @State private var choosenImage = UIImage()
    @State private var showSheet = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Name:", text: $name)
                
                DatePicker(
                    selection: $dateOfBirth,
                    in: ...Date(),
                    displayedComponents: .date) {
                        Text("Select a date")
                    }
                
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
                
                
                NavigationLink("Show birthday screen") {
                    BirthdayView(
                        name: self.name,
                        dateOfBirth: self.dateOfBirth,
                        choosenImage: self.choosenImage
                    )
                }
            }
            .navigationTitle("Happy Birthday app!")
        }
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$choosenImage)
        }
    }
}

private struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
