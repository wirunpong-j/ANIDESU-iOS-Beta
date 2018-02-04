//
//  ExternalLinkCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 4/2/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class ExternalLinkCell: UITableViewCell {
    
    @IBOutlet weak var linkTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(linkTitle: String) {
        linkTitleLabel.text = linkTitle
    }
    

}
