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
    
    // Variables
    var allMyAnimeList = [MyAnimeList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myAnimeListCollection.delegate = self
        myAnimeListCollection.dataSource = self
        
        updateUI(status: 0)
        
    }
    
    @IBAction func statusBtnPressed(_ sender: UIButton) {
        updateUI(status: sender.tag)
    }
    
    
    func updateUI(status: Int) {
        var statusType: StatusType = .PLAN_TO_WATCH
        switch status {
            case 0: statusType = .PLAN_TO_WATCH
            case 1: statusType = .WATCHING
            case 2: statusType = .COMPLETED
            case 3: statusType = .DROPPED
            default: break
        }
        
        UserDataService.instance.fetchMyAnimeList(statusType: statusType) { (data) in
            if data != nil {
                self.allMyAnimeList = data!
            } else {
                self.allMyAnimeList.removeAll()
            }
            self.myAnimeListCollection.reloadData()
        }
        
    }
}

extension MyAnimeListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MY_ANIME_LIST_CELL, for: indexPath) as? MyAnimeListCell {
            let myAnimeList = allMyAnimeList[indexPath.item]
            cell.configureCell(myAnimeList: myAnimeList)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allMyAnimeList.count
    }
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

extension MyAnimeListVC: UICollectionViewDataSource {
    
}
