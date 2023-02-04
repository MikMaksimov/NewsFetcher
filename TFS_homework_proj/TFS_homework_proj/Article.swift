//
//  News.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 04.02.2023.
//

import Foundation

struct Article: Decodable {
    
//    var author:String?
//    var title:String?
//    var description:String?
//    var url:String?
//    var urlToImage:String?
//    var publishedAt:String?
    
//    var status: String?
    var totalResults: Int?
    var articles: [SomeArticle]?
}

extension Article {
    struct SomeArticle: Decodable {
        var author: String?
        var title: String?
    }
}
