import UIKit
import Hero
import Kingfisher
import Cosmos
import SkeletonView

protocol ReviewDetailDelegate {
    func onReviewUpdated()
}

class ReviewDetailVC: UIViewController, UIGestureRecognizerDelegate {
    
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
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var customNavBar: UINavigationBar!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    
    // Constraints
    @IBOutlet weak var bannerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var panGestureReconizer: UIPanGestureRecognizer!
    
    // Variables
    var review: Review?
    var delegate: ReviewDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHeroEnabled = true
        panGestureReconizer.delegate = self
        self.view.showAnimatedGradientSkeleton()
        setUpView()
    }
    
    func setUpView() {
        animeTitleLabel.text = review?.anime.title_romaji
        bgScrollView.heroModifiers = [.fade, .scale(0.5)]
        
        let animeBannerUrl = review?.anime.image_url_banner != "" ? review?.anime.image_url_banner : review?.anime.image_url_lge
        animeBannerImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: animeBannerUrl!))
        userNameLabel.text = "Review By \((review?.user?.displayName)!)"
        userImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: (review?.user?.imageUrlProfile)!))
        animeImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: (review?.anime.image_url_lge)!))
        ratingView.rating = (review?.rating)!
        messageLabel.text = "\" \((review?.text)!) \""
        reviewDateLabel.text = "Review Date: \(AllFormat.instance.formatDatetime(timeStr: (review?.reviewDate)!))"
        
        // set nav bar
        customNavBar.setBackgroundImage(UIImage(), for: .default)
        customNavBar.shadowImage = UIImage()
        customNavBar.isTranslucent = true
        customNavBar.backgroundColor = .clear
        
        if (review?.isReview)! {
            editBtn.isEnabled = true
        } else {
            editBtn.isEnabled = false
        }
        
        self.view.hideSkeleton()
    }
    
    @IBAction func editReviewBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SEGUE_DETAIL_REVIEW_ANIME, sender: self.review)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        
        let currentHeight = self.bannerHeightConstraint.constant
        var newHeight = currentHeight + (sender.translation(in: self.view).y)
        
        if newHeight > 200 {
            newHeight = 200
        } else if newHeight < 50 {
            newHeight = 50
        }
        
        self.bannerHeightConstraint.constant = newHeight
        self.view.layoutIfNeeded()
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_DETAIL_REVIEW_ANIME {
            let navVC = segue.destination as? UINavigationController
            if let reviewAnimeVC = navVC?.viewControllers.first as? ReviewAnimeVC {
                reviewAnimeVC.delegate = self
                reviewAnimeVC.review = sender as? Review
            }
        }
    }
    
}

extension ReviewDetailVC: ReviewAnimeDelegate {
    func onReviewDeleted() {
        self.delegate?.onReviewUpdated()
        self.dismiss(animated: true, completion: nil)
    }
    
    func onCompleted() {
        self.delegate?.onReviewUpdated()
        self.dismiss(animated: true, completion: nil)
    }
}
