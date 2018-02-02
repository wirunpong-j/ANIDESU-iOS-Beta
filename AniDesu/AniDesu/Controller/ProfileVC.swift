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
import Kingfisher

class ProfileVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var userImageView: CircleImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userProfileTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileTableView.delegate = self
        userProfileTableView.dataSource = self
        setUpView()
    }
    
    func setUpView() {
        userProfileTableView.tableFooterView = UIView(frame: .zero)
        userImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: UserDataService.instance.imageUrlProfile))
        nameLabel.text = UserDataService.instance.displayName
    }
    
    func logoutBtnPressed() {
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

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // doing
        } else {
            self.logoutBtnPressed()
        }
    }
}

extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: USER_PROFILE_CELL) as? UserProfileCell {
                switch indexPath.row {
                    case 0: cell.configureCell(title: "Display Name", value: UserDataService.instance.displayName)
                    case 1: cell.configureCell(title: "Email", value: UserDataService.instance.email)
                    case 2: cell.configureCell(title: "About", value: UserDataService.instance.about)
                    default: break
                }
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: USER_PROFILE_CELL) as? UserProfileCell {
                cell.configureCell(title: "Logout", value: "")
                cell.titleLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                
                return cell
            }
        }
        return UITableViewCell()
    }
}

