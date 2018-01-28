//
//  MyAnimeListCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class MyAnimeListCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var animeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(myAnimeList: MyAnimeList) {
        episodeLabel.text = "EP : \(myAnimeList.progress) / \(myAnimeList.anime.total_episodes)"
        scoreLabel.text = "Score : \(myAnimeList.score) / 10"
        animeTitleLabel.text = "\(myAnimeList.anime.title_romaji)"
        let url = URL(string: myAnimeList.anime.image_url_lge)
        animeImage.kf.setImage(with: url)
    }
}
