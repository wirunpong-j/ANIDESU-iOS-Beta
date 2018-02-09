import UIKit
import Kingfisher

class CommentCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var userCommentImageView: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCommentLabel: UILabel!
    @IBOutlet weak var userCommentDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(comment: Comment) {
        userCommentImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: (comment.user?.imageUrlProfile)!))
        userNameLabel.text = (comment.user?.displayName)!
        userCommentLabel.text = comment.commentStatus
        userCommentDateLabel.text = AllFormat.instance.formatDatetime(timeStr: comment.commentDate)
    }

}
