//
//  NewsViewController.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 04.02.2023.
//

import UIKit

import Foundation

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var articlesInfo: Article?
    
    let articlesInfoController = ArticlesInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "News"
        view.backgroundColor = .green
        
        tableView.register(UINib(nibName: String(describing: NewsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: NewsTableViewCell.self))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Task {
            do {
                articlesInfo = try await articlesInfoController.fetchArticles()
//                articlesInfo = try await fetchArticles() // old
                tableView.reloadData()
                } catch {
                    print("Fetch news failed with error: \(error)") // отображение ошибок сделать ??? (с.420)
                }
        }
    }
}

extension NewsViewController: UITableViewDelegate{
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = self.articlesInfo?.articles?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableViewCell.self)) as! NewsTableViewCell
        
        // Get the article that the tableView is asking about
        let article = articlesInfo?.articles?[indexPath.row]
        
        cell.newsTitleLabel.text = article?.title
        cell.newsSeenLabel.text = "Seen 10 times"
        
        Task {
            do {
                if let stringURL = article?.urlToImage {
                    if let imageURL = URL(string: stringURL) {
                        let image = try await articlesInfoController.fetchImage(from: imageURL)
                        cell.newsImageView.image = image
                    }
                }
            } catch {
//              updateUI(with: error)
            }

        }
        
        return cell
    }
    
}

