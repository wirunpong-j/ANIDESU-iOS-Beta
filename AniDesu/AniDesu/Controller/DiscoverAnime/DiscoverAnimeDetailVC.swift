import UIKit
import Kingfisher

class DiscoverAnimeDetailVC: UIViewController {

    // Outlets
    @IBOutlet weak var animeBannerImageView: UIImageView!
    @IBOutlet weak var customNavigationBar: UINavigationBar!
    @IBOutlet weak var externalLinkTableView: UITableView!
    @IBOutlet weak var charactersCollection: UICollectionView!
    @IBOutlet weak var staffCollection: UICollectionView!
    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var animeAiringLabel: UILabel!
    @IBOutlet weak var nextEPLabel: UILabel!
    @IBOutlet weak var animeStartLabel: UILabel!
    @IBOutlet weak var animeEndLabel: UILabel!
    @IBOutlet weak var animeEnglishTitleLabel: UILabel!
    @IBOutlet weak var animeTypeLabel: UILabel!
    @IBOutlet weak var totalEPLabel: UILabel!
    @IBOutlet weak var animeTagLabel: UILabel!
    @IBOutlet weak var animeGenresLabel: UILabel!
    @IBOutlet weak var animeHashtagLabel: UILabel!
    @IBOutlet weak var animeOriginLabel: UILabel!
    @IBOutlet weak var mainStudioLabel: UILabel!
    @IBOutlet weak var animeDescLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var droppedLabel: UILabel!
    @IBOutlet weak var planToWatchLabel: UILabel!
    @IBOutlet weak var watchingLabel: UILabel!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    // Constraints
    @IBOutlet weak var bannerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var linkConstraints: NSLayoutConstraint!
    
    // Variables
    var anime: Anime?
    let linkHeight: CGFloat = 50
    let extraCellWidth = 120
    let extraCellHeight = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        externalLinkTableView.delegate = self
        externalLinkTableView.dataSource = self
        charactersCollection.delegate = self
        charactersCollection.dataSource = self
        staffCollection.delegate = self
        staffCollection.dataSource = self
        
        panGesture.delegate = self
        
        setUpView()
    }
    
    private func setUpView() {
        // set navbar view
        customNavigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        customNavigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        customNavigationBar.topItem?.title = anime?.title_romaji
        
        // set anime details view
        let animeImageURL = anime?.image_url_banner != "" ? anime?.image_url_banner: anime?.image_url_lge
        animeBannerImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: animeImageURL!))
        
        animeImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: (anime?.image_url_lge)!))
        animeTitleLabel.text = anime?.title_romaji
        animeAiringLabel.text = anime?.airing_status.uppercased()
        nextEPLabel.text = anime?.airing.getNextEPandTime()
        animeStartLabel.text = AllFormat.instance.getDateTime(date: (anime?.start_date_fuzzy)!)
        animeEndLabel.text = AllFormat.instance.getDateTime(date: (anime?.end_date_fuzzy)!)
        animeEnglishTitleLabel.text = anime?.title_english
        animeTypeLabel.text = anime?.type
        totalEPLabel.text = anime?.total_episodes != 0 ? "\((anime?.total_episodes)!)" : "N/A"
        animeTagLabel.text = anime?.tags
        animeGenresLabel.text = anime?.genres
        animeHashtagLabel.text = anime?.hashtag
        animeOriginLabel.text = anime?.source
        mainStudioLabel.text = anime?.studio
        animeDescLabel.text = anime?.description
        
        // set external links table view
        let newLinkHeight = linkHeight * CGFloat((anime?.external_links.count)!)
        linkConstraints.constant = newLinkHeight
        externalLinkTableView.reloadData()
        
//        // set border table view
        charactersCollection.layer.shadowColor = UIColor.black.cgColor
        charactersCollection.layer.shadowOffset = CGSize(width: 0, height: 5)
        charactersCollection.layer.shadowOpacity = 0.1
        charactersCollection.layer.shadowRadius = 5

        staffCollection.layer.shadowColor = UIColor.black.cgColor
        staffCollection.layer.shadowOffset = CGSize(width: 0, height: 5)
        staffCollection.layer.shadowOpacity = 0.1
        staffCollection.layer.shadowRadius = 5
        
//        completedLabel
//        droppedLabel
//        planToWatchLabel
//        watchingLabel
    }
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let currentHeight = self.bannerViewHeightConstraint.constant
        var newHeight = currentHeight + (sender.translation(in: self.view).y)
        
        if newHeight > 180 {
            newHeight = 180
        } else if newHeight < 0 {
            newHeight = 0
        }
        self.bannerViewHeightConstraint.constant = newHeight
        
        self.view.layoutIfNeeded()
        sender.setTranslation(CGPoint.zero, in: self.view)
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DiscoverAnimeDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == externalLinkTableView {
            return (anime?.external_links.count)!
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == externalLinkTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: EXTERNAL_LINK_CELL) as? ExternalLinkCell {
                cell.configureCell(linkTitle: (anime?.external_links[indexPath.row].site)!)

                return cell
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == externalLinkTableView {
            return CGFloat(50)
        }
        return CGFloat(0)
    }


}

extension DiscoverAnimeDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == charactersCollection {
            return (anime?.characters.count)!
        }
        return (anime?.staffs.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == charactersCollection {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CHARACTER_CELL, for: indexPath) as? ExtrasCell {
                cell.configureCell(character: (anime?.characters[indexPath.item])!)

                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STAFF_CELL, for: indexPath) as? ExtrasCell {
                cell.configureCell(character: (anime?.staffs[indexPath.item])!)

                return cell
            }

        }
        return UICollectionViewCell()
    }
}

extension DiscoverAnimeDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: extraCellWidth, height: extraCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 1, left: 2.5, bottom: 1, right: 2.5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension DiscoverAnimeDetailVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension DiscoverAnimeDetailVC: UICollectionViewDelegate {

}

extension DiscoverAnimeDetailVC: UITableViewDelegate {

}

