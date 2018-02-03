import UIKit
import Kingfisher

class DiscoverAnimeDetailVC: UIViewController {

    // Outlets
    @IBOutlet weak var animeBannerImageView: UIImageView!
    @IBOutlet weak var customNavigationBar: UINavigationBar!
    
    // Variables
    var anime: Anime?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    private func setUpView() {
        customNavigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        customNavigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        customNavigationBar.topItem?.title = anime?.title_romaji
        
        let animeImageURL = anime?.image_url_banner != "" ? anime?.image_url_banner: anime?.image_url_lge
        animeBannerImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: animeImageURL!))
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
