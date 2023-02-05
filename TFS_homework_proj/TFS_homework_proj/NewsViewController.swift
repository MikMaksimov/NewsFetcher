//
//  NewsViewController.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 04.02.2023.
//

import UIKit

import Foundation

class NewsViewController: UIViewController {
  //MARK: - Outlets

  @IBOutlet weak var tableView: UITableView!

  @IBOutlet weak var emptyStateView: UIView!
  @IBOutlet weak var emptyImage: UIImageView!
  @IBOutlet weak var emptyLabel: UILabel!

  //MARK: - Properties

  var articles: [Article]?

  let newsFetcher = NewsFetcher()

  let imageFetcher = ImageFetcher()

  var newsCounter: NewsSeen?

  //MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "News"
    configureTable()
    configureNavigationBar()
    decodeData()
    fetchNews()
  }

  //MARK: - Private Methods

  private func decodeData() {

    if let articlesFromFile = Article.loadFromFile() {
      articles = articlesFromFile
      tableView.reloadData()
    }

    if let countFromFile = NewsSeen.loadCountFromFile() {
      newsCounter = countFromFile
    }
  }

  private func configureTable() {
    tableView.register(
      UINib(nibName: String(describing: NewsTableViewCell.self), bundle: nil),
      forCellReuseIdentifier: String(describing: NewsTableViewCell.self)
    )

    tableView.delegate = self
    tableView.dataSource = self

    // Added Pull-to-Refresh
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }

  private func fetchNews() {
    Task {
      do {
        let searchResults = try await newsFetcher.fetchArticles()

        if let articlesFetched = searchResults.articles {
          articles = articlesFetched
          Article.saveToFile(articles: articles)
        }

        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()

        let isEmptyData = articles?.isEmpty == true || articles == nil
        emptyStateView.isHidden = !isEmptyData

        if isEmptyData {
          emptyImage.image = UIImage(systemName: "doc.append")
          emptyLabel.text = "No data to show"
        }

      } catch {
        emptyStateView.isHidden = false
        emptyImage.image = UIImage(systemName: "doc.append")
        emptyLabel.text = "Sorry, no connection"
      }
    }
  }

  private func configureNavigationBar() {
    let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
    navigationItem.rightBarButtonItem = reloadButton
  }

  //MARK: - Actions

  @objc
  private func reloadData() {
    self.articles = nil
    self.tableView.reloadData()
    fetchNews()
  }
}

//MARK: - UITableView Delegate

extension NewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    guard let article = articles?[indexPath.row] else {
      return
    }


    let detailedViewController = UINib(nibName: "DetailedViewController", bundle: Bundle.main)
      .instantiate(withOwner: nil)
      .first as! DetailedViewController

    detailedViewController.configure(article: article)
    navigationController?.pushViewController(detailedViewController, animated: true)
    tableView.deselectRow(at: indexPath, animated: true)

    if let sourceUrl = article.urlString {
      incrementCounter(urlString: sourceUrl, indexPath: indexPath)
    }

  }

  private func incrementCounter(urlString: String, indexPath: IndexPath) {

    var numberOfViews = 1

    if let oldValue = newsCounter?.countDict[urlString] {
      numberOfViews = oldValue + 1
      newsCounter?.countDict.updateValue(numberOfViews, forKey: urlString)
    } else {
      newsCounter?.countDict[urlString] = numberOfViews
    }

    if let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell {
      cell.newsSeenLabel.text = "Watched \(numberOfViews) times"
    }

    NewsSeen.saveCountToFile(counterDict: newsCounter)
  }
}

//MARK: - UITableView Data Source

extension NewsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return articles?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: String(describing: NewsTableViewCell.self),
      for: indexPath
    ) as! NewsTableViewCell

    guard let article = articles?[indexPath.row] else {
      return cell
    }

    cell.update(title: article.title)
    cell.update(newsSeen: articleCounter(urlString: article.urlString!))
    cell.update(image: UIImage(systemName: "photo.on.rectangle"))

    fetchImage(urlToImageString: article.urlToImage, cell: cell)

    return cell
  }

  private func articleCounter(urlString: String) -> String? {

    if newsCounter == nil {
      newsCounter = NewsSeen(countDict: [urlString : 1])
      return "Not watched"
    }

    if let value = newsCounter?.countDict[urlString] {
      return "Watched \(String(value)) times"
    } else {
      return "Not watched"
    }
  }

  private func fetchImage(urlToImageString: String?, cell: NewsTableViewCell) {
    // TODO: Add image caching
    Task {
      do {
        if let stringURL = urlToImageString {
          if let imageURL = URL(string: stringURL) {
            let image = try await imageFetcher.fetchImage(from: imageURL)
            cell.update(image: image)
          }
        }
      } catch {
        cell.update(image: UIImage(systemName: "photo.on.rectangle"))
      }
    }
  }
}

