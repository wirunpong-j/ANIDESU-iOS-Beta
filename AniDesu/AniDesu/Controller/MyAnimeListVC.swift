//
//  MyAnimeListVC.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class MyAnimeListVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var myAnimeListCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myAnimeListCollection.delegate = self
        myAnimeListCollection.dataSource = self
        
    }
}

extension MyAnimeListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MY_ANIME_LIST_CELL, for: indexPath) as? MyAnimeListCell {
//            let myAnimeList = MyAnimeListService.instance.allMyAnimeList[indexPath.item]
////            let anime = AnimeService.instance.allAnime[indexPath.item]
//            cell.configureCell(myAnimeList: myAnimeList)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return MyAnimeListService.instance.allMyAnimeList.count
        return 1
    }
}

extension MyAnimeListVC: UICollectionViewDataSource {
    
}

extension MyAnimeListVC: UICollectionViewDelegateFlowLayout {
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
