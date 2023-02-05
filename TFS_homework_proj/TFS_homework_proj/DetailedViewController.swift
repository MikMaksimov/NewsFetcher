//
//  DetailedViewController.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 05.02.2023.
//

import UIKit

class DetailedViewController: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var sourceLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet weak var contentStackView: UIStackView!
  @IBOutlet weak var actionButton: UIButton!

  // MARK: - Properties
  let imageFetcher = ImageFetcher()
  var fullArticleURL: String?

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Methods
  func configure(article: Article) {
    title = article.source?.name ?? "News"
    titleLabel.text = article.title
    descriptionLabel.text = article.description
    sourceLabel.text = article.source?.name

    if let dateString = article.publishedAtString {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
      if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateLabel.text = dateFormatter.string(from: date)
      } else {
        dateLabel.text = "Recent"
      }
    } else {
      dateLabel.text = "Recent"
    }


    if let imageURL = article.urlToImage {
      loadImage(url: imageURL)
    } else {
      //        imageView.isHidden = true
      imageView.image = UIImage(systemName: "photo.on.rectangle")
    }

    fullArticleURL = article.urlString
    actionButton.isEnabled = article.urlString != nil
  }

  // MARK: - Private methods
  private func loadImage(url: String) {
    Task {
      do {
        if let imageURL = URL(string: url) {
          loadingIndicator.startAnimating()
          let image = try await imageFetcher.fetchImage(from: imageURL)
          loadingIndicator.stopAnimating()
          imageView.image = image
        }
      } catch {
        if loadingIndicator.isAnimating {
          loadingIndicator.stopAnimating()
        }
        imageView.image = UIImage(systemName: "photo.on.rectangle")
      }
    }
  }

  // MARK: - Actions
  @IBAction func didTapButton(_ sender: Any) {
    guard let url = fullArticleURL else {
      return
    }
    let webViewController = NewsBrowser(url: url)
    navigationController?.pushViewController(webViewController, animated: true)
  }
}
