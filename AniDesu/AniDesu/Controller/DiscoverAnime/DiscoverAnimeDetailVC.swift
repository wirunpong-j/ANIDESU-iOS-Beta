import UIKit
import Kingfisher

class DiscoverAnimeDetailVC: UIViewController {

    // Outlets
    @IBOutlet weak var animeBannerImageView: UIImageView!
    @IBOutlet weak var animeMenuCollection: UICollectionView!
    
    // Variables
    var anime: Anime?
    let menu = ["INFO", "STATS", "EXTRAS", "REVIEWS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeMenuCollection.delegate = self
        animeMenuCollection.dataSource = self
        
        let begin = IndexPath(row: 0, section: 0)
        animeMenuCollection.selectItem(at: begin, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
        
        setUpView()

    }
    
    private func setUpView() {
        let animeImageURL = anime?.image_url_banner != "" ? anime?.image_url_banner: anime?.image_url_lge
        animeBannerImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: animeImageURL!))
    }

}

extension DiscoverAnimeDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ANIME_MENU_CELL, for: indexPath) as? AnimeMenuCell {
            cell.configureCell(menuText: menu[indexPath.item])
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

extension DiscoverAnimeDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}

extension DiscoverAnimeDetailVC: UICollectionViewDelegate {
    
}
