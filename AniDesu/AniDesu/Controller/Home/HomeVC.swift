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
        setUpView()
        
    }
    
    func setUpView() {
        postTableView.rowHeight = UITableViewAutomaticDimension
        postTableView.estimatedRowHeight = UITableViewAutomaticDimension
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
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
        }
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
                break
        }
    }
}

extension HomeVC: CreatePostDelegate {
    func onPostComplete() {
        self.setUpView()
    }
}
