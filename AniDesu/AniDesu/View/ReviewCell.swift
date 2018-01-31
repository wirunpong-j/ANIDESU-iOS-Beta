//
//  ReviewCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 31/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(review: Review) {
        animeImageView.image = UIImage(named: "banner")
        animeTitleLabel.text = review.message
    }


}
