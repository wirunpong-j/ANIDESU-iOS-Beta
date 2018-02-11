import UIKit
import Cosmos

class ReviewAnimeVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var reviewTextView: UITextView!
    
    // Variables
    var anime: Anime?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewTextView.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ReviewAnimeVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setUpView()
    }
    
    private func setUpView() {
        ratingView.didTouchCosmos = { rating in
            self.ratingLabel.text = "Rating: \(rating)"
        }
        reviewTextView.textColor = UIColor.lightGray
        reviewTextView.text = "Write review."
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        let rating = ratingView.rating
        let text = reviewTextView.text
        let currentTime = AllFormat.instance.getCurrentTime()
        let review = Review(rating: rating, reviewDate: currentTime, text: text!, anime: anime!)
        
        ReviewService.instance.saveReview(review: review) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
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
