//
//  ArticleCell.swift
//  NYMPA
//
//  Created by Parimala Ranganath Velayudam on 13/11/19.
//  Copyright © 2019 VPR productions. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var byLineLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var dateIcon:UIImageView!
    @IBOutlet weak var articleIcon:UIImageView!
    
    var articleCellVM : ArticleCellViewModel? {
        didSet {
            
            guard let articleCellVM = articleCellVM else {
                return
            }
            
            titleLabel?.text = articleCellVM.title
            byLineLabel?.text = articleCellVM.byLineString
            dateLabel?.text = Utilities.getStringFromDate(date: articleCellVM.publishedDate)
            
            if let urlStr = articleCellVM.imageUrl {
                let url = URL(string: urlStr)
                //Image Cache using SDWebImage
                articleIcon.sd_setShowActivityIndicatorView(true)
                articleIcon.sd_setIndicatorStyle(.gray)
                articleIcon.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeHolderImage"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

