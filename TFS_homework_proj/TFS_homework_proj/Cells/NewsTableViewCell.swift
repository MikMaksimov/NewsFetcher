//
//  NewsTableViewCell.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 04.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    @IBOutlet weak var newsSeenLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsTitleLabel.text = ""
        newsSeenLabel.text = ""
        newsImageView.image = UIImage(systemName: "photo.on.rectangle")
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
