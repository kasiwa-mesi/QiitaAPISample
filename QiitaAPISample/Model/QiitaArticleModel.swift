//
//  QiitaArticleModel.swift
//  QiitaAPISample
//
//  Created by kasiwa on 2022/10/13.
//

import Foundation

struct QiitaArticleModel: Codable {
  var urlStr: String
  var title: String

  enum CodingKeys: String, CodingKey {
    case urlStr = "url"
    case title = "title"
  }
  var url: URL? { URL.init(string: urlStr) }
}
