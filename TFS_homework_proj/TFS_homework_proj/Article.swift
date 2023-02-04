//
//  News.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 04.02.2023.
//

import Foundation

struct Article: Decodable {
    
    var totalResults: Int? // необходимость?
    var articles: [SomeArticle]?
}

extension Article {
    struct SomeArticle: Decodable {
        var title: String?
        var urlToImage: String?
    }
}
