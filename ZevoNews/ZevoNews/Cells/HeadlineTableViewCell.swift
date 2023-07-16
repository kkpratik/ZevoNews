//
//  HeadlineTableViewCell.swift
//  ZevoNews
//
//  Created by Apple on 15/07/23.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {

    @IBOutlet weak var headlineIconImageView: UIImageView!
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    
    let imageManager = ImageManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.headlineIconImageView.layer.cornerRadius = 5
        self.headlineIconImageView.layer.borderColor = UIColor.lightGray.cgColor
        self.headlineIconImageView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(object:Article){
        self.headlineTitleLabel.text = object.title
        self.autherLabel.text = object.author
        if let url = object.urlToImage{
          loadArticleImage(url: url)
        }
    }
    
    func loadArticleImage(url:String){
    
        self.imageManager.loadImage(from: url) { image in
            if let img = image{
                DispatchQueue.main.async {
                    self.headlineIconImageView.image = img
                }
            }
        }
    }
}

