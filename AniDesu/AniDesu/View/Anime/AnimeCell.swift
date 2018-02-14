//
//  AnimeCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Kingfisher

class AnimeCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var animeTypeLabel: UILabel!
    @IBOutlet weak var animeAiringLabel: UILabel!
    @IBOutlet weak var animeRatingLabel: UILabel!
    @IBOutlet weak var animeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(anime: Anime) {
        animeTypeLabel.text = anime.type.uppercased()
        animeAiringLabel.text = anime.airing_status.uppercased()
        animeRatingLabel.text = "\(anime.average_score)"
        animeTitleLabel.text = anime.title_romaji
        
        let url = URL(string: anime.image_url_lge)
        animeImage.kf.setImage(with: url)
    }
    
}
