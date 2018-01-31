//
//  ReviewDetailVC.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 31/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Hero

class ReviewDetailVC: UIViewController {
    
    @IBOutlet weak var animeBannerImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var reviewNavigationBar: UINavigationBar!
    @IBOutlet weak var bgImageView: UIView!
    
    var review: Review?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHeroEnabled = true
        setUpView()
    }
    
    func setUpView() {
        animeBannerImageView.image = UIImage(named: "banner")
        animeTitleLabel.text = review?.message
        bgView.heroModifiers = [.fade, .scale(0.5)]

    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
