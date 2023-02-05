//
//  NewsSeen.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 05.02.2023.
//

import Foundation

struct NewsSeen: Codable {
  // MARK: - Properties
  var countDict: [String:Int]
  
  // MARK: - Static methods
  static func saveCountToFile(counterDict: NewsSeen?) {
    let documentsDirectory =
    FileManager.default.urls(for: .documentDirectory,
                             in: .userDomainMask).first!
    let archiveURL =
    documentsDirectory.appendingPathComponent("counter")
      .appendingPathExtension("plist")
    
    let propertyListEncoder = PropertyListEncoder()
    let encodedInfo = try? propertyListEncoder.encode(counterDict)
    
    try? encodedInfo?.write(to: archiveURL, options: .noFileProtection)
  }
  
  static func loadCountFromFile() -> NewsSeen? {
    let propertyListDecoder = PropertyListDecoder()
    
    let documentsDirectory =
    FileManager.default.urls(for: .documentDirectory,
                             in: .userDomainMask).first!
    let archiveURL =
    documentsDirectory.appendingPathComponent("counter")
      .appendingPathExtension("plist")
    
    
    if let retrievedArticlesData = try? Data(contentsOf: archiveURL),
       let decodedInfo = try?
        propertyListDecoder.decode(NewsSeen.self,from: retrievedArticlesData) {
      return decodedInfo
    }
    return nil
  }
}
