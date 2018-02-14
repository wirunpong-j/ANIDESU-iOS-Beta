import UIKit
import Cosmos

protocol ReviewAnimeDelegate {
    func onCompleted()
    func onReviewDeleted()
}

class ReviewAnimeVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    // Variables
    var review: Review?
    var delegate: ReviewAnimeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewTextView.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ReviewAnimeVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setUpView()
    }
    
    private func setUpView() {
        if (review?.isReview)! {
            reviewTextView.textColor = UIColor.black
            reviewTextView.text = (review?.text)!
            ratingView.rating = (review?.rating)!
            ratingLabel.text = "Rating: \((review?.rating)!)"
            deleteBtn.isHidden = false
        } else {
            reviewTextView.textColor = UIColor.lightGray
            reviewTextView.text = "Write review."
            deleteBtn.isHidden = true
        }
        
        self.navigationItem.title = "Review: \((review?.anime.title_romaji)!)"
        ratingView.didTouchCosmos = { rating in
            self.ratingLabel.text = "Rating: \(rating)"
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        let rating = ratingView.rating
        let text = reviewTextView.text
        let currentTime = AllFormat.instance.getCurrentTime()
        let anime = self.review?.anime
        let newReview = Review(rating: rating, reviewDate: currentTime, text: text!, anime: anime!)
        
        if (review?.isReview)! {
            ReviewService.instance.updateReview(review: newReview) { (success) in
                if success {
                    self.dismiss(animated: true, completion: {
                        self.delegate?.onCompleted()
                    })
                }
            }
            
        } else {
            ReviewService.instance.saveReview(review: newReview) { (success) in
                if success {
                    self.dismiss(animated: true, completion: {
                        self.delegate?.onCompleted()
                    })
                }
            }
        }
    }
    
    @IBAction func deleteReviewBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete this review ?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            ReviewService.instance.removeReview(animeID: (self.review?.anime.id)!) { (success) in
                if success {
                    self.dismiss(animated: true, completion: {
                        self.delegate?.onReviewDeleted()
                    })
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension ReviewAnimeVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            saveBtn.isEnabled = false
        } else {
            saveBtn.isEnabled = true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write review."
            textView.textColor = UIColor.lightGray
        }
    }
}
