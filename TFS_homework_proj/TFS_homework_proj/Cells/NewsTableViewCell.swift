//
//  NewsTableViewCell.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 04.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
  // MARK: - Outlets
  @IBOutlet weak var newsImageView: UIImageView!

  @IBOutlet weak var newsTitleLabel: UILabel!

  @IBOutlet weak var newsSeenLabel: UILabel!

  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()

    newsTitleLabel.text = ""
    newsSeenLabel.text = ""
    newsImageView.image = UIImage(systemName: "photo.on.rectangle")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    newsImageView.image = nil
    newsTitleLabel.text = nil
    newsSeenLabel.text = nil
  }

  // MARK: - Methods
  func update(title: String?) {
    newsTitleLabel.text = title
  }

  func update(newsSeen: String?) {
    newsSeenLabel.text = newsSeen
  }

  func update(image: UIImage?) {
    newsImageView.image = image
  }
}
