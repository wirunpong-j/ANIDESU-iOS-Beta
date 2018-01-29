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
    @IBOutlet weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(menuText: String) {
        menuLabel.text = menuText
    }
    
    
    override var isSelected: Bool {
        didSet {
            self.underlineView.backgroundColor = isSelected ? #colorLiteral(red: 0.2648853064, green: 0.8780197501, blue: 0.07720620185, alpha: 1) : UIColor.clear
            self.menuLabel.textColor = isSelected ? #colorLiteral(red: 0.2648853064, green: 0.8780197501, blue: 0.07720620185, alpha: 1) : UIColor.white
        }
    }
}
