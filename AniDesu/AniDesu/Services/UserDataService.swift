//
//  UserDataService.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var uid = ""
    public private(set) var displayName = ""
    public private(set) var email = ""
    public private(set) var about = ""
    public private(set) var imageUrlProfile = ""
    public private(set) var myAnimeList = [MyAnimeList]()
    
    func setUserData(uid: String, displayName: String, email: String, about: String, imageUrlProfile: String) {
        self.uid = uid
        self.displayName = displayName
        self.email = email
        self.about = about
        self.imageUrlProfile = imageUrlProfile
    }
    
    func logoutUser() {
        uid = ""
        displayName = ""
        email = ""
        about = ""
        imageUrlProfile = ""
        
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToken = ""
    }
    
}
