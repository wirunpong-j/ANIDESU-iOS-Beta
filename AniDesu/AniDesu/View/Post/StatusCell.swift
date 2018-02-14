import UIKit

class StatusCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(status: String) {
        statusLabel.text = status
    }

}
