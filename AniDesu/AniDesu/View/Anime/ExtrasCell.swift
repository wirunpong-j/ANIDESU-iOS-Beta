//
//  ExtrasCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 4/2/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Kingfisher

class ExtrasCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(character: CharacterStaff) {
        characterImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: character.image_url_lge))
        nameLabel.text = character.getFullName()
        roleLabel.text = character.role
    }
}
