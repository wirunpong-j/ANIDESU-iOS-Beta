import UIKit
import Hero
import Kingfisher
import Cosmos

class ReviewDetailVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var animeBannerImageView: UIImageView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIView!
    @IBOutlet weak var bgScrollView: UIScrollView!
    @IBOutlet weak var userImageView: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var messageLabel: UILabel!
    
    // Variables
    var review: Review?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHeroEnabled = true
        setUpView()
    }
    
    
    func setUpView() {
        animeTitleLabel.text = review?.anime.title_romaji
        bgScrollView.heroModifiers = [.fade, .scale(0.5)]
        
        let animeBannerUrl = review?.anime.image_url_banner != "" ? review?.anime.image_url_banner : review?.anime.image_url_lge
        animeBannerImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: animeBannerUrl!))
        userNameLabel.text = "Review By \((review?.user.displayName)!)"
        userImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: (review?.user.imageUrlProfile)!))
        animeImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: (review?.anime.image_url_lge)!))
        ratingView.rating = (review?.rating)!
        messageLabel.text = "\" \((review?.text)!) \""
        

    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
