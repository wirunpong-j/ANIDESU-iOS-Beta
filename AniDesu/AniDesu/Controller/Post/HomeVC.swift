import UIKit

class HomeVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var postTableView: UITableView!
    
    // Variables
    var allPost = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
        postTableView.rowHeight = UITableViewAutomaticDimension
        postTableView.estimatedRowHeight = UITableViewAutomaticDimension
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        // set refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            postTableView.refreshControl = refreshControl
        } else {
            postTableView.backgroundView = refreshControl
        }
        
        self.fetchAllData()
        
    }
    
    func fetchAllData() {
        PostService.instance.fetchAllPost { (allPost) in
            if allPost != nil {
                self.allPost = allPost!
            } else {
                self.allPost.removeAll()
            }
            self.postTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_CREATE_POST {
            let navVC = segue.destination as? UINavigationController
            if let createPostVC = navVC?.viewControllers.first as? CreatePostVC {
                createPostVC.delegate = self
            }

        } else if segue.identifier == SEGUE_POST_DETAIL {
            if let postDetailVC = segue.destination as? PostDetailVC {
                postDetailVC.postKey = sender as? String
                postDetailVC.delegate = self
            }
        }
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        self.fetchAllData()
        refreshControl.endRefreshing()
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: PRE_POST_CELL, for: indexPath) as? PrePostCell {
                    cell.configureCell()
                    
                    return cell
                }
            default:
                if let cell = tableView.dequeueReusableCell(withIdentifier: POST_CELL, for: indexPath) as? PostCell {
                    let post = allPost[indexPath.row - 1]
                    cell.delegate = self
                    cell.configureCell(post: post)
                    
                    return cell
                }
            }
        
        return UITableViewCell()
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPost.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                performSegue(withIdentifier: SEGUE_CREATE_POST, sender: nil)
            default:
                performSegue(withIdentifier: SEGUE_POST_DETAIL, sender: allPost[indexPath.row - 1].postKey)
        }
    }
}

extension HomeVC: CreatePostDelegate {
    func onPostComplete() {
        self.fetchAllData()
    }
}

extension HomeVC: PostDetailDelegate {
    func onDeletePostComplete() {
        self.fetchAllData()
    }
}

extension HomeVC: PostCellDelegate {
    func onLikeBtnPressed(postKey: String) {
        PostService.instance.likePost(postKey: postKey) { (success) in
            self.fetchAllData()
        }
    }
    
    func onCommentBtnPressed(postKey: String) {
        performSegue(withIdentifier: SEGUE_POST_DETAIL, sender: postKey)
    }
}
