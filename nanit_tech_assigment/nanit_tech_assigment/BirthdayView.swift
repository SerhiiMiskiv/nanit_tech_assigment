//
//  BirthdayScreen.swift
//  nanit_tech_assigment
//
//  Created by Serj Miskiv on 14.06.2022.
//

import SwiftUI

struct BirthdayViewLayout {
    let photoPlaceholder: UIImage
    let cameraIcon: UIImage
    let backGround: UIImage
    let backgroundColor: UIColor
    let borderColor: UIColor
    let shareButtonColor: UIColor
    
    static var randomConfig: BirthdayViewLayout {
        let photoPlaceholders = [Icons.defaultPlaceHolderBlue, Icons.defaultPlaceHolderGreen, Icons.defaultPlaceHolderYellow];
        let cameraIcons = [Icons.cameraIconBlue, Icons.cameraIconGreen, Icons.cameraIconYellow];
        let themeColors = [ThemeColors.blue, ThemeColors.green, ThemeColors.yellow];
        let backGrounds = [Icons.iOsBgPelican2, Icons.iOsBgFox, Icons.iOsBgElephant];
        
        let index = Int.random(in: 0...2)
        
        return BirthdayViewLayout(
            photoPlaceholder: photoPlaceholders[index].uiImage,
            cameraIcon: cameraIcons[index].uiImage,
            backGround: backGrounds[index].uiImage,
            backgroundColor:themeColors[index].backgroundColor,
            borderColor: themeColors[index].borderColor,
            shareButtonColor: ThemeColors.shareButtonColor
        )
    }
    
    static func ageIcon(from years: Int) -> UIImage {
        if years > 12 { return Icons.ageNumber12.uiImage }
        
        return [
            Icons.ageNumber0,
            Icons.ageNumber1,
            Icons.ageNumber2,
            Icons.ageNumber3,
            Icons.ageNumber4,
            Icons.ageNumber5,
            Icons.ageNumber6,
            Icons.ageNumber7,
            Icons.ageNumber8,
            Icons.ageNumber9,
            Icons.ageNumber10,
            Icons.ageNumber11,
            Icons.ageNumber12,
        ][years].uiImage;
    }
}

struct BirthdayView: View {
    @State var birthdayViewLayout: BirthdayViewLayout
    
    let name: String
    let dateOfBirth: Date
    
    @Binding var choosenImage: UIImage?
    @State var showSheet = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Image(uiImage: birthdayViewLayout.backGround)
                .resizable()
                .scaledToFill()
                .background(Color(birthdayViewLayout.backgroundColor))
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(uiImage: Icons.arrowBackBlue.uiImage)
                    }
                    Spacer()
                }
                
                
                VStack {
                    Text("TODAY " + name.uppercased() + " IS")
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        
                        Image(uiImage: Icons.leftSwirls.uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 44)
                        
                        Image(uiImage: BirthdayViewLayout.ageIcon(from: calculateAge.amount))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 50, maxWidth: 80, minHeight: 90, maxHeight: 90)
                            .padding(EdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 22))
                        
                        Image(uiImage: Icons.rightSwirls.uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 44)
                    }

                    properAgeText
                }
                
                ZStack {
                    Image(uiImage: self.choosenImage ?? birthdayViewLayout.photoPlaceholder)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 220, height: 220)
                        .clipShape(Circle())
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .background(Color(birthdayViewLayout.borderColor))
                        .clipShape(Circle())
                    
                    
                    Button {
                        showSheet = true
                    } label: {
                        Image(uiImage: birthdayViewLayout.cameraIcon)
                    }
                    .offset(x: 82.5, y: -82.5)
                    
                }
                .padding(EdgeInsets(top: 13, leading: 0, bottom: 0, trailing: 14))
                
                Image(uiImage: Icons.nanitLogo.uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 20)
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 20, trailing: 0))
                
                
                Button {
                    actionSheet()
                } label: {
                    HStack {
                        Text("Share the news").foregroundColor(.white)
                        Image(uiImage: Icons.shareWhiteSmall.uiImage)
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                .background(Color(uiColor: birthdayViewLayout.shareButtonColor))
                .cornerRadius(21)
                
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 88, trailing: 50))
        }
        .onAppear(perform: {
            self.birthdayViewLayout = BirthdayViewLayout.randomConfig
        })
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $choosenImage)
        }
    }
    
    func actionSheet() {
        let activityVC = UIActivityViewController(activityItems: [choosenImage as Any], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    var calculateAge: (amount: Int, component: Calendar.Component) {
        let calendar = Calendar.current
        let years = calendar.dateComponents([.year], from: dateOfBirth, to: .now).year
        
        if let checked = years,  checked > 0 {
            return (checked, .year)
        }
        
        
        let month = calendar.dateComponents([.month], from: dateOfBirth, to: .now).month
        if let checked = month,  checked > 0 {
            return (checked, .month)
        }
        
        return (0, .month)
    }
    
    var properAgeText: Text {
        let age = calculateAge
        var str = age.component == .year ? "YEAR" : "MONTH"
        if age.amount > 1 { str += "S" }
        return Text(str + " OLD!")
    }
}

struct RoundedEdge: ViewModifier {
    let width: CGFloat
    let color: Color
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content.cornerRadius(cornerRadius - width)
            .padding(width)
            .background(color)
            .cornerRadius(cornerRadius)
    }
}
