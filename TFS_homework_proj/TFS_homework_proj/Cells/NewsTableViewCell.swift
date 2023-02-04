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
    
//    var newsToShow: News?
//
//    func showStory(_ news:News) {
//
//         // Clean up the cell before displaying the next article
//        newsImageView.image = nil
//        newsImageView.alpha = 0
//        newsTitleLabel.text = ""
//        newsTitleLabel.alpha = 0
//
//           // Keep a reference to the article
//        newsToShow = news
//
//           // Set the headline
//        newsTitleLabel.text = newsToShow!.title
//
////           // Animated the label into view
////           UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
////
////               self.headlineLabel.alpha = 1
////
////           }, completion: nil)
//
//
//           // Download and display the image
//
//           // Check the article actually has an image
//           guard newsToShow!.urlToImage != nil else {
//               return
//           }
//
//           // Create url string
//           let urlString = newsToShow!.urlToImage!
//
//           // Check the cachemanager before downloading any image data
////           if let imageData = CacheManager.retrievedData(urlString) {
////
////               // There is image data, set the imageview and return
////               articleImageView.image = UIImage(data: imageData)
////
////               UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
////
////                   self.articleImageView.alpha = 1
////
////               }, completion: nil)
////
////               return
////           }
//
//           // Create the url
//           let url = URL(string: urlString)
//
//           // Check that the url isn't nil
//           guard url != nil else {
//               print("Coudn't create the url object ")
//               return
//           }
//
//           // Get a URLSession
//           let session = URLSession.shared
//
//           // Create the datatask
//           let dataTask = session.dataTask(with: url!) { data, response, error in
//
//               // Check that there no errors
//               if error == nil && data != nil {
//
//                   // Save the date into cache
////                   CacheManager.saveData(urlString, data!)
//
//
//                   // Check if the url string that the data task went off download matches the article this cell is set to display
//                   if self.newsToShow!.urlToImage == urlString {
//
//                       DispatchQueue.main.async {
//
//                           // Dispaly the image data in the image view
//                           self.newsImageView.image = UIImage(data: data!)
//
////                           UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
////
////                               self.articleImageView.alpha = 1
////
////                           }, completion: nil)
//
//                       }
//                   }
//
//
//               } // End if
//           } // End data task
//
//           // Kick off the datatask
//           dataTask.resume()
//
//
//
//
//       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        newsTitleLabel.text = "Title"
//        newsSeenLabel.text = "10"
        // Initialization code
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
