//
//  UserPreferences.swift
//  CallAPIExample
//
//  Created by imac-2437 on 2023/2/6.
//

import Foundation

class UserPreferences: NSObject {
    
    static let shared = UserPreferences()
    
    enum  Keys: String {
        case lastSearchNum
        case city
        case status
        case aqi
    }
    
    var lastSearchNum: String {
        get { return UserDefaults.standard.string(forKey: Keys.lastSearchNum.rawValue) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: Keys.lastSearchNum.rawValue)}
    }
    
    var city: String {
        get { return UserDefaults.standard.string(forKey: Keys.city.rawValue) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: Keys.city.rawValue) }
    }
    
    var status: String {
        get { return UserDefaults.standard.string(forKey: Keys.status.rawValue) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: Keys.status.rawValue) }
    }
    
    var aqi: Int {
        get { return UserDefaults.standard.integer(forKey: Keys.aqi.rawValue) ?? 0 }
        set { UserDefaults.standard.set(newValue, forKey: Keys.aqi.rawValue) }
    }

}
