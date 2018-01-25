//
//  PostCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(post: Post) {
//        profileImage.image =
        displayNameLabel.text = post.uid
        postDateLabel.text = post.postDate
        statusLabel.text = post.status
        likeCountLabel.text = "\(post.likeCount) Likes"
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
    }
    
    @IBAction func commentBtnPressed(_ sender: Any) {
    }
    
    
    
}
