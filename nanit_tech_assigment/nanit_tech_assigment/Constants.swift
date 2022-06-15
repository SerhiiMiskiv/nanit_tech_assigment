    //
    //  Constants.swift
    //  nanit_tech_assigment
    //
    //  Created by Serj Miskiv on 15.06.2022.
    //

import UIKit

enum ThemeColors {
    case blue
    case green
    case yellow
    
    var backgroundColor: UIColor {
        switch self {
            case .blue:
                return UIColor(red: 218 / 255.0, green: 241 / 255.0, blue: 246 / 255.0, alpha: 1.0)
            case .green:
                return UIColor(red: 197 / 255.0, green: 232 / 255.0, blue: 223 / 255.0, alpha: 1.0)
            case .yellow:
                return UIColor(red: 254 / 255.0, green: 239 / 255.0, blue: 203 / 255.0, alpha: 1.0)
        }
    }
    
    var borderColor: UIColor {
        switch self {
            case .blue:
                return UIColor(red: 139.0 / 255.0, green: 211.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0)
            case .green:
                return UIColor(red: 111.0 / 255.0, green: 197.0 / 255.0, blue: 175.0 / 255.0, alpha: 1.0)
            case .yellow:
                return UIColor(red: 254.0 / 255.0, green: 190.0 / 255.0, blue: 32.0 / 255.0, alpha: 1.0)
        }
    }
    
    static var shareButtonColor: UIColor {
        UIColor(red: 239 / 255.0, green: 123 / 255.0, blue: 123 / 255.0, alpha: 1.0)
    }
}

enum Icons: String {
    case ageNumber0
    case ageNumber1
    case ageNumber2
    case ageNumber3
    case ageNumber4
    case ageNumber5
    case ageNumber6
    case ageNumber7
    case ageNumber8
    case ageNumber9
    case ageNumber10
    case ageNumber11
    case ageNumber12
    
    case cameraIconBlue
    case cameraIconGreen
    case cameraIconYellow
    
    case defaultPlaceHolderBlue
    case defaultPlaceHolderGreen
    case defaultPlaceHolderYellow
    
    case iOsBgElephant
    case iOsBgFox
    case iOsBgPelican2
    
    case leftSwirls
    case rightSwirls
    case nanitLogo
    case shareWhiteSmall
    
    case arrowBackBlue
    
    var uiImage: UIImage {
        return UIImage(named: self.rawValue)!
    }
}
