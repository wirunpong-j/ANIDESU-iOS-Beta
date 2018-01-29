//
//  MenuCell.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 29/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    @IBOutlet weak var menuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(menuText: String) {
        menuLabel.text = menuText
    }
    
    override var isSelected: Bool {
        didSet {
            self.menuLabel.textColor = isSelected ? UIColor.red : UIColor.white
        }
    }
}
