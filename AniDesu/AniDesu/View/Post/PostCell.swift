import UIKit
import Kingfisher
import WCLShineButton

protocol PostCellDelegate {
    func onCommentBtnPressed(postKey: String)
    func onLikeBtnPressed(postKey: String)
}

class PostCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var likeBtn: WCLShineButton!
    
    // Variables
    var post: Post?
    var delegate: PostCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func configureCell(post: Post) {
        self.post = post
        profileImage.kf.setImage(with: AllFormat.instance.getURL(stringURL: (post.user?.imageUrlProfile)!))
        displayNameLabel.text = post.user?.displayName
        postDateLabel.text = AllFormat.instance.formatDatetime(timeStr: post.postDate)
        statusLabel.text = post.status
        likeCountLabel.text = "\(post.likeCount) Likes"
        likeBtn.fillColor = #colorLiteral(red: 0.2496733367, green: 0.5013930798, blue: 1, alpha: 1)
        likeBtn.image = .like
        likeBtn.isSelected = (post.likes?.contains(UserDataService.instance.uid))!
        likeBtn.addTarget(self, action: #selector(likeBtnPressed), for: .valueChanged)
    }
    
    @objc func likeBtnPressed() {
        self.delegate?.onLikeBtnPressed(postKey: (post?.postKey)!)
    }
    
    
    @IBAction func commentBtnPressed(_ sender: Any) {
        self.delegate?.onCommentBtnPressed(postKey: (post?.postKey)!)
    }
    
    func setUpView() {
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 5)
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 5
    }
    
    
    
}
