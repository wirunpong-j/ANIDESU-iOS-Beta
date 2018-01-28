//
//  ViewController.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 22/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import FBSDKLoginKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if AuthService.instance.isLoggedIn && FBSDKAccessToken.current() != nil {
            DispatchQueue.main.async {
                AuthService.instance.loginUser(uid: AuthService.instance.uid) { (success) in
                    if success {
                        AuthService.instance.authAniList { (success) in
                            if success {
                                self.performSegue(withIdentifier: SEGUE_HOME, sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self) { (result) in
            switch result {
                case .failed(let error):
                    print("facebook login failed : \(error)")
                case .cancelled:
                    print("User cancelled login.")
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    
                    Auth.auth().signIn(with: credential) { (user, error) in
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        AuthService.instance.loginUser(uid: (user?.uid)!) { (success) in
                            if !success {
                                let imageUrl = (user?.photoURL)?.absoluteString
                                AuthService.instance.createUser(uid: (user?.uid)!, displayName: (user?.displayName)!, email: (user?.email)!, about: "Welcome To AniDesu.", imageUrl: imageUrl!) { (success) in
                                    if success {
                                        AuthService.instance.authAniList { (success) in
                                            if success {
                                                AuthService.instance.isLoggedIn = true
                                                AuthService.instance.authToken = accessToken.authenticationToken
                                                print("facebook login success")
                                                self.performSegue(withIdentifier: SEGUE_HOME, sender: nil)
                                            }
                                        }
                                    }
                                }
                            } else {
                                AuthService.instance.authAniList { (success) in
                                    if success {
                                        AuthService.instance.uid = (user?.uid)!
                                        AuthService.instance.isLoggedIn = true
                                        AuthService.instance.authToken = accessToken.authenticationToken
                                        print("facebook login success")
                                        self.performSegue(withIdentifier: SEGUE_HOME, sender: nil)
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
}


