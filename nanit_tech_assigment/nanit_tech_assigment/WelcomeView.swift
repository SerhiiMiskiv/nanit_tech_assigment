//
//  ContentView.swift
//  nanit_tech_assigment
//
//  Created by Serj Miskiv on 14.06.2022.
//

import SwiftUI

struct WelcomeView: View {
    @State private var name: String = ""
    @State private var isDateChanged = false;
    @State private var dateOfBirth: Date = Date()
    @State private var choosenImage: UIImage?
    @State private var showSheet = false
    
    
    var body: some View {
        let nameBinding = Binding<String>(
            get: { self.name },
            set: {
                self.name = $0
                PersistanseManager.shared.name = $0
            }
        )
        
        let dateOfBirthBinding = Binding<Date>(
            get: { self.dateOfBirth },
            set: {
                if !isDateChanged {
                    self.isDateChanged = true
                }
                
                self.dateOfBirth = $0
                PersistanseManager.shared.dateOfBirth = $0
            }
        )
        
        let imageBinding = Binding<UIImage?>(
            get: { self.choosenImage },
            set: {
                self.choosenImage = $0
                PersistanseManager.shared.image = $0
            }
        )
        
        NavigationView {
            Form {
                TextField("Name:", text: nameBinding)
                    .disableAutocorrection(true)
                
                
                DatePicker(
                    selection: dateOfBirthBinding,
                    in: ...Date(),
                    displayedComponents: .date) {
                        Text("Select a date")
                    }
                
                HStack {
                    Image(uiImage: self.choosenImage ?? UIImage())
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
                        birthdayViewLayout: BirthdayViewLayout.randomConfig,
                        name: self.name,
                        dateOfBirth: self.dateOfBirth,
                        choosenImage: imageBinding
                    )
                }
                .disabled(name.isEmpty && !isDateChanged)
                
            }
            .navigationTitle("Happy Birthday app!")
        }
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: imageBinding)
        }.onAppear {
            let manager = PersistanseManager.shared
            
            let name = manager.name ?? ""
            let dateOfBirth = manager.dateOfBirth ?? Date.now
            let image = manager.image
            
            self.name = name
            self.dateOfBirth = dateOfBirth
            self.choosenImage = image
        }
    }
}

private struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
