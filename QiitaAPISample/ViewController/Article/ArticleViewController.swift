//
//  ArticleViewController.swift
//  QiitaAPISample
//
//  Created by kasiwa on 2022/10/12.
//

import UIKit

final class ArticleViewController: UIViewController {
    private let cellID = "UITableViewCell"
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        }
    }
    
    private var qiitaArticles: [QiitaArticleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.shared.getArticles {[weak self] result in
            switch result {
            case .success(let articles):
                self?.qiitaArticles = articles
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = qiitaArticles[indexPath.row].url,
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qiitaArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            fatalError()
        }
        
        let article = qiitaArticles[indexPath.row]
        cell.textLabel?.text = article.title
        
        return cell
    }
}
