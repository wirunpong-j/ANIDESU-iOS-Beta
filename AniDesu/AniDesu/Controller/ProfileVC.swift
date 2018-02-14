import UIKit
import FacebookLogin
import FBSDKLoginKit
import Firebase
import Kingfisher

class ProfileVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var userImageView: CircleImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userProfileTableView: UITableView!
    
    // Variables
    let TOTAL_ROW = 3
    let HEIGHT_OF_ROW = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileTableView.delegate = self
        userProfileTableView.dataSource = self
        setUpView()
    }
    
    private func setUpView() {
        userProfileTableView.tableFooterView = UIView(frame: .zero)
        userImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: UserDataService.instance.imageUrlProfile))
        nameLabel.text = UserDataService.instance.displayName
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to Logout ?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            if UserDataService.instance.logoutUser() {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TOTAL_ROW
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(HEIGHT_OF_ROW)
    }
}

extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: USER_PROFILE_CELL) as? UserProfileCell {
            switch indexPath.row {
                case 0: cell.configureCell(title: "Display Name", value: UserDataService.instance.displayName)
                case 1: cell.configureCell(title: "Email", value: UserDataService.instance.email)
                case 2: cell.configureCell(title: "About", value: UserDataService.instance.about)
                default: break
            }
            return cell
        }
        
        return UITableViewCell()
    }
}

