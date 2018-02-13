import UIKit
import Hero

class ReviewVC: UIViewController {
    
    @IBOutlet weak var reviewTableView: UITableView!
    var allReview = [Review]()
    let cellHeight: CGFloat = 180
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isHeroEnabled = true
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: REVIEW_CELL)
        
        // set navbar
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        // set refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            reviewTableView.refreshControl = refreshControl
        } else {
            reviewTableView.backgroundView = refreshControl
        }
        
        self.fetchAllData()
        
    }
    
    func fetchAllData() {
        ReviewService.instance.fetchAllReview { (allReview) in
            self.allReview = allReview!
            self.reviewTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_REVIEW_DETAIL {
            if let reviewDetailVC = segue.destination as? ReviewDetailVC {
                reviewDetailVC.delegate = self
                reviewDetailVC.review = sender as? Review
            }
        }
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        self.fetchAllData()
        refreshControl.endRefreshing()
    }

}

extension ReviewVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: REVIEW_CELL) as? ReviewCell {
            cell.configureCell(review: allReview[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension ReviewVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allReview.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SEGUE_REVIEW_DETAIL, sender: allReview[indexPath.row])
    }
    
}

extension ReviewVC: ReviewDetailDelegate {
    func onReviewUpdated() {
        self.fetchAllData()
    }
    
    
}

