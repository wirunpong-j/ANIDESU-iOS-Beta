import UIKit
import Hero

class ReviewVC: UIViewController {
    
    @IBOutlet weak var reviewTableView: UITableView!
    var allReview = [Review]()
    let cellHeight: CGFloat = 180
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: REVIEW_CELL)
        
        
        isHeroEnabled = true
        setUpView()
        
        ReviewService.instance.fetchAllReview { (allReview) in
            self.allReview = allReview!
            self.reviewTableView.reloadData()
        }
    }
    
    func setUpView() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_REVIEW_DETAIL {
            if let reviewDetailVC = segue.destination as? ReviewDetailVC {
                reviewDetailVC.review = sender as! Review
            }
        }
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

