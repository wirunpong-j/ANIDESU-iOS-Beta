//
//  ReviewCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 1/2/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Cosmos

class ReviewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: CircleImage!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(review: Review) {
        let animeUrl = review.anime.image_url_banner != "" ? review.anime.image_url_banner : review.anime.image_url_lge
        animeImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: animeUrl))
        animeTitleLabel.text = (review.anime.title_romaji)
        userNameLabel.text = "Review by \((review.user?.displayName)!)"
        userImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: (review.user?.imageUrlProfile)!))
        ratingView.rating = review.rating
    }
    
}
