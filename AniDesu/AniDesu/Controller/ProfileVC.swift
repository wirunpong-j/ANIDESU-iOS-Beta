//
//  ProfileVC.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import Firebase

class ProfileVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = UserDataService.instance.displayName
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        if FBSDKAccessToken.current() == nil {
            UserDataService.instance.logoutUser()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

