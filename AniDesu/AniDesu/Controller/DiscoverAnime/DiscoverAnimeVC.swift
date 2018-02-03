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
    
    // Variables
    var allAnime = [Anime]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeCollection.delegate = self
        animeCollection.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_ANIME_DETAIL {
            print(segue.destination)
            if let animeDetailVC = segue.destination as? DiscoverAnimeDetailVC {
                animeDetailVC.anime = sender as? Anime
            }
        }
    }
    
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

extension DiscoverAnimeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ANIME_CELL, for: indexPath) as? AnimeCell {
            let anime = allAnime[indexPath.row]
            cell.configureCell(anime: anime)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: SEGUE_ANIME_DETAIL, sender: allAnime[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allAnime.count
    }
}

extension DiscoverAnimeVC: UICollectionViewDelegate {
}
