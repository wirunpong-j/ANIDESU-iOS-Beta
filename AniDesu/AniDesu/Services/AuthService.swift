//
//  AuthService.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON
import Alamofire

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        } set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var uid : String {
        get {
            return defaults.string(forKey: USER_ID_KEY)!
        } set {
            defaults.set(newValue, forKey: USER_ID_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.string(forKey: TOKEN_KEY)!
        } set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var anilistToken : String {
        get {
            return defaults.string(forKey: ANILIST_TOKEN_KEY)!
        } set {
            defaults.set(newValue, forKey: ANILIST_TOKEN_KEY)
        }
    }
    
    func loginUser(uid: String, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        ref.child("users").child(uid).child("profile").observeSingleEvent(of: .value, with: { (snapshot) in
            // get user data
            let value = snapshot.value as? NSDictionary
            
            if value?.allValues != nil {
                let about = value?["about"] as? String ?? ""
                let displayName = value?["display_name"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                let imageURL = value?["image_url_profile"] as? String ?? ""
                
                UserDataService.instance.setUserData(uid: uid, displayName: displayName, email: email, about: about, imageUrlProfile: imageURL)
                
                completion(true)
            } else {
                completion(false)
            }

        }) { (error) in
            print(error.localizedDescription)
            print("User not register")
            
            completion(false)
        }
    }
    
    func createUser(uid: String, displayName: String, email: String, about: String, imageUrl: String, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        let info = [
            "uid": uid,
            "display_name": displayName,
            "email": email,
            "image_url_profile": imageUrl,
            "about": "Welcome To AniDesu."
        ]
        ref.child("users").child(uid).child("profile").setValue(info)
        UserDataService.instance.setUserData(uid: uid, displayName: displayName, email: email, about: about, imageUrlProfile: imageUrl)
        
        completion(true)
    }
    
    func authAniList(completion: @escaping CompletionHandler) {
        Alamofire.request(AUTHORIZE_URL, method: .post, parameters: AUTHORIZE_BODY, encoding: JSONEncoding.default, headers: API_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                var json: JSON
                do { try json = JSON(data: data) } catch { return }
                
                AuthService.instance.anilistToken = json["access_token"].stringValue
                completion(true)
            } else {
                print("ERROR")
                completion(false)
            }
        }
    }
    
}
