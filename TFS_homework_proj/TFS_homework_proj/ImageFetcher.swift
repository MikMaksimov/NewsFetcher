//
//  ImageFetcher.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 05.02.2023.
//

import UIKit

enum FetchDataError: Error, LocalizedError {
  case itemsNotFound
  case imageDataMissing
}

class ImageFetcher {
  func fetchImage(from url: URL) async throws -> UIImage {
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      throw FetchDataError.imageDataMissing
    }

    guard let image = UIImage(data: data) else {
      throw FetchDataError.imageDataMissing
    }

    return image
  }
}
