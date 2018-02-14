//
//  UserProfileCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 2/2/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
        
    }


}
