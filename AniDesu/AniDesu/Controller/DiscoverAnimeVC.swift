//
//  DiscoverAnimeVC.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class DiscoverAnimeVC: UIViewController {

    // Outlets
    @IBOutlet weak var animeCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeCollection.delegate = self
        animeCollection.dataSource = self
        
        AnimeService.instance.fetchAnimeDataBySeason(season: "WINTER") { (success) in
            
        }

    }
    
}

extension DiscoverAnimeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ANIME_CELL, for: indexPath) as? AnimeCell {
            let anime = AnimeService.instance.allAnime[indexPath.item]
            cell.configureCell(anime: anime)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AnimeService.instance.allAnime.count
    }
}

extension DiscoverAnimeVC: UICollectionViewDataSource {
    
}

extension DiscoverAnimeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width / 2) - 5, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 2.5, bottom: 5, right: 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
