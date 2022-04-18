//
//  UserDefault.swift
//  14.3
//
//  Created by Satyavrata on 14.04.2022.
//

import Foundation


class UserDefault{
    static let shared = UserDefault()
    
    private let kUserNameKey = "UserDefault.kUserNameKey"
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserNameKey)}
    }
    
    private let kUserFamilyKey = "UserDefault.kUserFamilyKey"
    var userFamily: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserFamilyKey)}
        get { return UserDefaults.standard.string(forKey: kUserFamilyKey)}
    }
}
