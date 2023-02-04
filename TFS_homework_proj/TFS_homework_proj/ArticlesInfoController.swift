//
//  ArticlesInfoController.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 05.02.2023.
//

import Foundation
import UIKit

class ArticlesInfoController {
    
    enum fetchDataError: Error, LocalizedError {
        case itemsNotFound
        case imageDataMissing
    }
    
    func fetchArticles() async throws -> Article {
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&page=0&pageSize=20&apiKey=10783ccdd9584cb2ba601864a3f6d46b")!


        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw fetchDataError.itemsNotFound // нужна ли функция, обработка исключения (вывод сообщения на экран)
            
        }
        
        let jsonDecoder = JSONDecoder()
        let article = try jsonDecoder.decode(Article.self, from: data)
        return (article)
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw fetchDataError.imageDataMissing
        }
        
        guard let image = UIImage(data: data) else {
            throw fetchDataError.imageDataMissing
        }
        
        return image
    }
    
}
