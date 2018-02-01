//
//  ReviewDetailVC.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 31/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Hero
import Kingfisher

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
        let imageUrl = review?.anime.image_url_banner != "" ? review?.anime.image_url_banner : review?.anime.image_url_lge
        let url = URL(string: imageUrl!)
        
        animeBannerImageView.kf.setImage(with: url)
        animeTitleLabel.text = review?.anime.title_romaji
        bgView.heroModifiers = [.fade, .scale(0.5)]

    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
