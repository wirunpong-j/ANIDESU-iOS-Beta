import UIKit
import Kingfisher

class PostCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func configureCell(post: Post) {
        let url = URL(string: (post.user?.imageUrlProfile)!)
        profileImage.kf.setImage(with: url)
        displayNameLabel.text = post.user?.displayName
        postDateLabel.text = post.postDate
        statusLabel.text = post.status
        likeCountLabel.text = "\(post.likeCount) Likes"
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
    }
    
    @IBAction func commentBtnPressed(_ sender: Any) {
    }
    
    func setUpView() {
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 5)
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 5
    }
    
    
    
}
