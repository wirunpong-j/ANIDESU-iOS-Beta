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
    @IBOutlet weak var menuCollection: UICollectionView!
    
    // Variables
    var allAnime = [Anime]()
    let menu = ["WINTER", "SPRING", "FALL", "SUMMER"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeCollection.delegate = self
        animeCollection.dataSource = self
        menuCollection.delegate = self
        menuCollection.dataSource = self
        
        let begin = IndexPath(row: 0, section: 0)
        menuCollection.selectItem(at: begin, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
        updateUI(seasonType: .WINTER)
        setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpView()
    }
    
    private func setUpView() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    private func updateUI(seasonType: SeasonType) {
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
        if collectionView == animeCollection {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ANIME_CELL, for: indexPath) as? AnimeCell {
                let anime = allAnime[indexPath.row]
                cell.configureCell(anime: anime)
                
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MENU_CELL, for: indexPath) as? MenuCell {
                let menuText = menu[indexPath.row]
                cell.configureCell(menuText: menuText)
                
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollection {
            switch indexPath.row {
                case 0: updateUI(seasonType: .WINTER)
                case 1: updateUI(seasonType: .SPRING)
                case 2: updateUI(seasonType: .FALL)
                case 3: updateUI(seasonType: .SUMMER)
                default: break
            }
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == animeCollection {
            return allAnime.count
        }
        return menu.count
    }
}

extension DiscoverAnimeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == animeCollection {
            return CGSize(width: (self.view.bounds.width / 2) - 5, height: 300)
        }
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == animeCollection {
            return UIEdgeInsets(top: 5, left: 2.5, bottom: 5, right: 2.5)
        }
        return UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension DiscoverAnimeVC: UICollectionViewDataSource {
    
}
