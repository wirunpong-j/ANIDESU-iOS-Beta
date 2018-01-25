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
        print(AuthService.instance.isLoggedIn)
        print(AuthService.instance.authToken)
        
        if AuthService.instance.isLoggedIn && FBSDKAccessToken.current() != nil {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: TO_HOME, sender: nil)
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
                    print("facebook login success")
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    Auth.auth().signIn(with: credential) { (user, error) in
                        if let error = error {
                            print(error)
                            return
                        }
                        print("login success")
                        AuthService.instance.isLoggedIn = true
                        AuthService.instance.authToken = accessToken.authenticationToken
                        
                        self.performSegue(withIdentifier: TO_HOME, sender: nil)
                }
            }
        }
    }
}


