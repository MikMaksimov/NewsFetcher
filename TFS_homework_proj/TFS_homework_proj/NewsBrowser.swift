//
//  NewsBrowser.swift
//  TFS_homework_proj
//
//  Created by Михаил Максимов on 05.02.2023.
//

import WebKit

class NewsBrowser: UIViewController {
  // MARK: - Properties
  private lazy var webView: WKWebView = {
    let webView = WKWebView()
    webView.navigationDelegate = self
    return webView
  }()

  private let loadingIndicator = UIActivityIndicatorView()

  private let urlString: String

  // MARK: - Initializer
  init(url: String) {
    self.urlString = url
    super.init(nibName: nil, bundle: nil)

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    addViews()

    loadingIndicator.startAnimating()
    let myURL = URL(string: urlString)
    let myRequest = URLRequest(url: myURL!)
    webView.load(myRequest)
  }

  // MARK: - Private methods
  private func addViews() {
    view.addSubview(webView)
    webView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
    ])

    view.addSubview(loadingIndicator)
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0),
      loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0),
    ])
  }
}

// MARK: - WKNavigationDelegate
extension NewsBrowser: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    loadingIndicator.stopAnimating()
  }
}
