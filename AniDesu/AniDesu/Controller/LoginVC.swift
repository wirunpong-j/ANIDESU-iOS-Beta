//
//  ViewController.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 22/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_HOME, sender: nil)
    }
    

}

