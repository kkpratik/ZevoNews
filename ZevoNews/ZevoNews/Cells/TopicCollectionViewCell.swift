//
//  TopicCollectionViewCell.swift
//  ZevoNews
//
//  Created by Apple on 15/07/23.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
//    var selectCell:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        
    }
    
    func configureWith(title: String, selected:Bool){
        self.titleLabel.text = title
        self.backgroundColor = selected ? .systemBlue : .systemGray3
    }
    
    
}
