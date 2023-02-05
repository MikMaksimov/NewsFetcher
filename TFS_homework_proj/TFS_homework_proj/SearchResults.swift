//
//  News.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 04.02.2023.
//

import Foundation

struct SearchResults: Codable {
    
  let totalResults: Int
  let articles: [Article]?
}

struct Article: Codable {
    
    let title: String?
    let description: String?
    let urlToImage: String?
    let author: String?
    let publishedAtString: String?
    let urlString: String?
    let source: ArticleSource?

    enum CodingKeys: String, CodingKey {
      case title
      case description
      case urlToImage
      case author
      case publishedAtString = "publishedAt"
      case urlString = "url"
      case source
    }
}

extension Article {
    
    static func saveToFile(articles: [Article]?) {
        let documentsDirectory =
           FileManager.default.urls(for: .documentDirectory,
           in: .userDomainMask).first!
        let archiveURL =
           documentsDirectory.appendingPathComponent("articles")
           .appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedNotes = try? propertyListEncoder.encode(articles)
        
        try? encodedNotes?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Article]? {
        let propertyListDecoder = PropertyListDecoder()
        
        let documentsDirectory =
           FileManager.default.urls(for: .documentDirectory,
           in: .userDomainMask).first!
        let archiveURL =
           documentsDirectory.appendingPathComponent("articles")
           .appendingPathExtension("plist")
        
        
        if let retrievedArticlesData = try? Data(contentsOf: archiveURL),
            let decodedNotes = try?
            propertyListDecoder.decode(Array<Article>.self,from: retrievedArticlesData) {
            return decodedNotes
        }
        return nil
    }
}

  struct ArticleSource: Codable {
    let id: String?
    let name: String?
  }

