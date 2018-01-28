//
//  HomeVC.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.delegate = self
        postTableView.dataSource = self
        setUpView()
        
        PostService.instance.findAllPost { (success) in
        }
        
    }
    
    func setUpView() {
        postTableView.rowHeight = UITableViewAutomaticDimension
        postTableView.estimatedRowHeight = UITableViewAutomaticDimension
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        let ac = UIAlertController(title: "Menu", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "New Post", style: .default, handler: createPost))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func createPost(action: UIAlertAction) {
        performSegue(withIdentifier: SEGUE_CREATE_POST, sender: nil)
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: POST_CELL, for: indexPath) as? PostCell {
            let post = PostService.instance.posts[indexPath.row]
            cell.configureCell(post: post)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostService.instance.posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension HomeVC: UITableViewDataSource {
    
}
