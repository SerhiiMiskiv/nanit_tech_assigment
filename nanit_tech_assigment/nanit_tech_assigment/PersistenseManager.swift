//
//  PersistenseManager.swift
//  nanit_tech_assigment
//
//  Created by Serj Miskiv on 15.06.2022.
//

import UIKit

private enum Keys: String {
    case name
    case dateOfBirth
    case image
}

class PersistanseManager {
    static let shared = PersistanseManager()
    private let standardDefaults = UserDefaults.standard
    
    private init(){}
    
    var name: String? {
        set {
            guard let name = newValue else { return }
            standardDefaults.set(name, forKey: Keys.name.rawValue)
            standardDefaults.synchronize()
        }
        get {
            return standardDefaults.string(forKey: Keys.name.rawValue)
        }
    }
    
    var dateOfBirth: Date? {
        set {
            guard let date = newValue else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YY/MM/dd"
            standardDefaults.set(dateFormatter.string(from: date), forKey: "dateOfBirth")
            standardDefaults.synchronize()
        }
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YY/MM/dd"
            
            guard let dateStr = standardDefaults.string(forKey: Keys.dateOfBirth.rawValue) else { return nil }
            return dateFormatter.date(from: dateStr)
        }
    }
    
    var image: UIImage? {
        set {
            guard let image = newValue, let data = image.jpegData(compressionQuality: 1.0) else { return }
            let encoded = try! PropertyListEncoder().encode(data)
            standardDefaults.set(encoded, forKey: Keys.image.rawValue)
            standardDefaults.synchronize()
        }
        get {
            guard let data = standardDefaults.data(forKey: Keys.image.rawValue) else { return nil }
            let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
            return UIImage(data: decoded)
        }
    }
}
