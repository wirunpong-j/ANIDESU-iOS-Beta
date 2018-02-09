//
//  PrePostCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 29/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Kingfisher

class PrePostCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func configureCell() {
        let url = URL(string: UserDataService.instance.imageUrlProfile)
        profileImage.kf.setImage(with: url)
        nameLabel.text = UserDataService.instance.displayName
        aboutLabel.text = UserDataService.instance.about
    }
    
    func setUpView() {
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 5)
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 5
        
    }

}
