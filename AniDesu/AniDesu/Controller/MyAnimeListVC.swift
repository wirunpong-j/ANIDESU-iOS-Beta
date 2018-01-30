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
//    @IBOutlet weak var menuCollection: UICollectionView!
    
    // Variables
    var allMyAnimeList = [MyAnimeList]()
//    let menu = ["PLAN TO WATCH", "WATCHING", "COMPLETED", "DROPPED"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myAnimeListCollection.delegate = self
        myAnimeListCollection.dataSource = self
//        menuCollection.delegate = self
//        menuCollection.dataSource = self
        
//        let begin = IndexPath(row: 0, section: 0)
//        menuCollection.selectItem(at: begin, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
//        updateUI(statusType: .PLAN_TO_WATCH)
//        setUpView()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        setUpView()
//    }
//
//    private func setUpView() {
//        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
//    }
    
//    func updateUI(statusType: StatusType) {
//        UserDataService.instance.fetchMyAnimeList(statusType: statusType) { (data) in
//            if data != nil {
//                self.allMyAnimeList = data!
//            } else {
//                self.allMyAnimeList.removeAll()
//            }
//            self.myAnimeListCollection.reloadData()
//        }
//    }
}

extension MyAnimeListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myAnimeListCollection {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MY_ANIME_LIST_CELL, for: indexPath) as? MyAnimeListCell {
                let myAnimeList = allMyAnimeList[indexPath.item]
                cell.configureCell(myAnimeList: myAnimeList)
                
                return cell
            }
        }
//        } else {
//            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MY_ANIME_LIST_MENU_CELL, for: indexPath) as? MenuCell {
//                let menuText = menu[indexPath.row]
//                cell.configureCell(menuText: menuText)
//
//                return cell
//            }
//        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == myAnimeListCollection {
            return allMyAnimeList.count
//        }
//        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == menuCollection {
//            switch indexPath.row {
//                case 0: updateUI(statusType: .PLAN_TO_WATCH)
//                case 1: updateUI(statusType: .WATCHING)
//                case 2: updateUI(statusType: .COMPLETED)
//                case 3: updateUI(statusType: .DROPPED)
//                default: break
//            }
//            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        } else {
//
//        }
    }
}

extension MyAnimeListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == myAnimeListCollection {
            return CGSize(width: (self.view.bounds.width / 2) - 5, height: 300)
//        }
//        return CGSize(width: 150, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if collectionView == myAnimeListCollection {
            return UIEdgeInsets(top: 5, left: 2.5, bottom: 5, right: 2.5)
//        }
//        return UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
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
