//
//  NewsModel.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 04.02.2023.
//

import Foundation

//protocol NewsModernProtocol {
//    
//    func oneNewsRetrived(_ news:[News])
//}

class NewsModel {
    

    
//    var delegate:NewsModernProtocol?
//
//    func getNews(){
//
//        // Fire off the request to the API
//
//        // Create a string URL
//        let stringUrl = "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=10783ccdd9584cb2ba601864a3f6d46b"
//
//        // Create a URL object
//        let url = URL(string: stringUrl)
//        print(url)
//
//        // Check that it isn't a nil
//        guard url != nil else {
//            print("Coudn't create url object")
//            return
//        }
//
//        // Get the URL Session
//        let session = URLSession.shared
//
//        // Create the data task
//        let dataTask = session.dataTask(with: url!) { data, response, error in
//
//            // Check that there are no errors and that there is data
//            if error == nil && data != nil {
//
//                // Attempt to parse the JSON
//                let decoder = JSONDecoder()
//
//                do{
//
//                    // Parse the json into ArticleService
//                    let articleService = try decoder.decode(NewsService.self, from: data!)
//
//                    // Get the articles
//                    let articles = articleService.news!
//
//                    // Pass it back to the view controller in the main thread
//                    DispatchQueue.main.async {
//                        self.delegate?.oneNewsRetrived(articles)
//                    }
//
//                }
//                catch{
//
//                    print("error parsing the json")
//
//                } // End Do - Catch
//
//            } // End if
//
//        } // End Data Task
//
//
//        // Start the data task
//        dataTask.resume()
//
//
//
//
//    }
}
