//
//  NewsViewController.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 04.02.2023.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var articlesInfo: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "News"
        
        view.backgroundColor = .green
        
        tableView.register(UINib(nibName: String(describing: NewsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: NewsTableViewCell.self))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Task {
            do {
                articlesInfo = try await fetchArticles()
                if let firstarticletitle = articlesInfo?.articles?[0].title {
                    print("Fetch first title: \(firstarticletitle)")
                }
                tableView.reloadData()
                } catch {
                    print("Fetch news failed with error: \(error)") // отображение ошибок сделать ??? (с.420)
                }
        }
        

    
    }
    
    func fetchArticles() async throws -> Article {
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&page=0&pageSize=20&apiKey=10783ccdd9584cb2ba601864a3f6d46b")!


        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw fetchArticlesError.itemsNotFound
            
        }
        
        let jsonDecoder = JSONDecoder()
        let article = try jsonDecoder.decode(Article.self, from: data)
    //    print(article)
        return(article)
    }
    
}

extension NewsViewController: UITableViewDelegate{
    
}

extension NewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        print("Count  \(articlesInfo?.totalResults)")
        
        if let count = self.articlesInfo?.articles?.count {
//            print("Count in NumberofRows: \(count)")
            return count
        }
//        print(0)
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableViewCell.self)) as! NewsTableViewCell
        
        // Get the article that the tableView is asking about
        let article = articlesInfo?.articles?[indexPath.row]
        
        //можно ли так делать
        cell.newsTitleLabel.text = article?.title
        cell.newsSeenLabel.text = "Seen 10 times"
        return cell
    }
    
    
}

enum fetchArticlesError: Error, LocalizedError {
    case itemsNotFound
}




//extension NewsViewController:  NewsModernProtocol{
//
//    //MARK: - Article Model Protocol Methods
//
//    func oneNewsRetrived(_ news: [News]) {
//
//        // Set the articles property of the view controller to the articless passed back from the model
//        self.newsArr = news
//
//        // Refresh the tableview
//        tableView.reloadData()
//    }
//
//}

