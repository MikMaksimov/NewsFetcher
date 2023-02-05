//
//  ArticlesInfoController.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 05.02.2023.
//

import Foundation
import UIKit

class NewsFetcher {
  func fetchArticles() async throws -> SearchResults {
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&page=0&pageSize=20&apiKey=10783ccdd9584cb2ba601864a3f6d46b")!

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw FetchDataError.itemsNotFound // нужна ли функция, обработка исключения (вывод сообщения на экран)

    }

    let jsonDecoder = JSONDecoder()
    let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)

    return searchResults
  }
}
