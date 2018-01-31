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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
