//
//  AnimeCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

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
//        animeImage =
        animeTypeLabel.text = anime.type
        animeAiringLabel.text = anime.airing_status
        animeRatingLabel.text = "\(anime.average_score)"
        animeTitleLabel.text = anime.title_romaji
    }
    
}
