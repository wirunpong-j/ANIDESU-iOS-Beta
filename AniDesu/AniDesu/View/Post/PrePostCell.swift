import UIKit
import Kingfisher
import SkeletonView

class PrePostCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func configureCell() {
        tipLabel.text = "What's on your mind?"
        profileImage.kf.setImage(with: AllFormat.instance.getURL(stringURL: UserDataService.instance.imageUrlProfile))
        nameLabel.text = UserDataService.instance.displayName
        aboutLabel.text = UserDataService.instance.about
    }
    
    func setUpView() {
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 5)
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 5
        
    }

}
