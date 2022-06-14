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
    @State private var image = UIImage()
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
                    Image(uiImage: self.image)
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
                
                
                Button("Show birthday screen") {
                    print("Button tapped!")
                }
            }
            .navigationTitle("Happy Birthday app!")
        }
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
}

private struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
}

private struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
