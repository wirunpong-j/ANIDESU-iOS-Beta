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
    var allAnime = [Anime]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeCollection.delegate = self
        animeCollection.dataSource = self
        
        updateUI(season: 0)
        
    }
    
    @IBAction func seasonBtnPressed(_ sender: UIButton) {
        updateUI(season: sender.tag)
    }
    
    private func updateUI(season: Int) {
        var seasonType: SeasonType = .WINTER
        switch season {
            case 0: seasonType = .WINTER
            case 1: seasonType = .SPRING
            case 2: seasonType = .FALL
            case 3: seasonType = .SUMMER
            default: break
        }
        
        AniListService.instance.fetchAnimeDataBySeason(season: seasonType) { (animeList) in
            if animeList != nil {
                self.allAnime = animeList!
                self.animeCollection.reloadData()
            }
        }
    }
    
}

extension DiscoverAnimeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ANIME_CELL, for: indexPath) as? AnimeCell {
            let anime = allAnime[indexPath.row]
            cell.configureCell(anime: anime)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAnime.count
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
