import UIKit
import WCLShineButton

protocol PostNavBarCellDelegate {
    func onLikeBtnPressed(postKey: String)
}

class PostNavBarCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var likeBtn: WCLShineButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    // Variables
    var delegate: PostNavBarCellDelegate?
    var post: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(post: Post) {
        likeCountLabel.text = "\(post.likeCount) Likes"
        likeBtn.isEnabled = true
        likeBtn.fillColor = #colorLiteral(red: 0.2496733367, green: 0.5013930798, blue: 1, alpha: 1)
        likeBtn.image = .like
        likeBtn.isSelected = (post.likes?.contains(UserDataService.instance.uid))!
        likeBtn.addTarget(self, action: #selector(likeBtnPressed), for: .valueChanged)
        print(likeBtn.actions(forTarget: self, forControlEvent: .valueChanged))
    }
    
    @objc func likeBtnPressed() {
        self.delegate?.onLikeBtnPressed(postKey: (post?.postKey)!)
    }

    @IBAction func commentBtnPressed(_ sender: UIButton) {
        
    }
    
}
