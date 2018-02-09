import UIKit
import Kingfisher

class PostDetailVC: UIViewController {
    
    // Constance
    let HEADER_ROWS = 2
    let NAV_BAR_HEIGHT = CGFloat(30)
    
    // Outlets
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var postOwnerImageView: CircleImage!
    @IBOutlet weak var postOwnerNameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var commentText: UITextView!
    
    // Variables
    var postKey: String?
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.tableFooterView = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PostDetailVC.handleTap))
        view.addGestureRecognizer(tap)
        
        fetchPostInfo(commentIsAdded: false)

    }
    
    private func setUpView() {
        postOwnerImageView.kf.setImage(with: AllFormat.instance.getURL(stringURL: (post?.user?.imageUrlProfile)!))
        postOwnerNameLabel.text = (post?.user?.displayName)!
        postDateLabel.text = AllFormat.instance.formatDatetime(timeStr: (post?.postDate)!)
    }
    
    private func fetchPostInfo(commentIsAdded: Bool) {
        PostService.instance.fetchPost(postKey: postKey!) { (post) in
            self.post = post
            self.setUpView()
            self.postTableView.reloadData()
            
            if commentIsAdded {
                let endIndex = IndexPath(row: (post?.comment?.count)! + 1, section: 0)
                self.postTableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
            }
        }
    }
    
    @IBAction func commentBtnPressed(_ sender: Any) {
        let commText = commentText.text
        let commentDate = AllFormat.instance.getCurrentTime()
        let comment = Comment(uid: (post?.uid)!, commentStatus: commText!, commentDate: commentDate)
        commentText.text = ""
        PostService.instance.addComment(postKey: (post?.postKey)!, comment: comment) { success in
            if success {
                self.fetchPostInfo(commentIsAdded: true)
            }
        }
    }
    
    @IBAction func optionsBtnPressed(_ sender: Any) {
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
}

extension PostDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if post != nil {
            switch indexPath.row {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: POST_DETAIL_CELL) as? StatusCell {
                    cell.configureCell(status: (post?.status)!)
                    
                    return cell
                }
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: POST_NAV_BAR_CELL) as? PostNavBarCell {
                    
                    return cell
                }
            default:
                if let cell = tableView.dequeueReusableCell(withIdentifier: COMMENT_CELL) as? CommentCell {
                    let comment = post?.comment![indexPath.row - 2]
                    cell.configureCell(comment: comment!)
                    cell.separatorInset = UIEdgeInsetsMake(0, 1000, 0, 0);
                    
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
}

extension PostDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.post != nil ? (self.post?.comment?.count)! + HEADER_ROWS : HEADER_ROWS
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return NAV_BAR_HEIGHT
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
