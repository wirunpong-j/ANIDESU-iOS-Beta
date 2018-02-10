import UIKit
import Kingfisher

protocol PostDetailDelegate {
    func onDeletePostComplete()
}

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
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var optionsBtn: UIButton!
    
    // Variables
    var postKey: String?
    var post: Post?
    var keyboardHeight: CGFloat?
    var delegate: PostDetailDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.tableFooterView = UIView()
        commentText.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(PostDetailVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PostDetailVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PostDetailVC.handleTap))
        view.addGestureRecognizer(tap)
        
        fetchPostInfo(commentIsAdded: false)

    }
    
    private func setUpView() {
        if UserDataService.instance.uid != post?.uid {
            optionsBtn.isHidden = true
        }
        commentText.textColor = UIColor.lightGray
        commentText.text = "Write a comment"
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
                self.handleTap()
                self.sendBtn.isEnabled = false
            }
        }
    }
    
    @IBAction func optionsBtnPressed(_ sender: Any) {
        let ac = UIAlertController(title: "Choose Options", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Edit Post", style: .default, handler: editPost))
        ac.addAction(UIAlertAction(title: "Delete Post", style: .default, handler: deletePost))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func editPost(action: UIAlertAction) {
        
    }
    
    func deletePost(action: UIAlertAction) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete this post ?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            PostService.instance.deletePost(postKey: (self.post?.postKey)!) { (success) in
                if success {
                    self.dismiss(animated: true, completion: {
                        self.delegate?.onDeletePostComplete()
                    })
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if var keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardHeight == nil {
                keyboardHeight = keyboardSize.height
            }
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardHeight!
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize)
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }
    
}

extension PostDetailVC: UIActionSheetDelegate {
    
}

extension PostDetailVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            sendBtn.isEnabled = false
        } else {
            sendBtn.isEnabled = true
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
            textView.text = "Write a comment"
            textView.textColor = UIColor.lightGray
        }
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