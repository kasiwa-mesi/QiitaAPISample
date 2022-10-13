//
//  QiitaAccessTokenModel.swift
//  QiitaAPISample
//
//  Created by kasiwa on 2022/10/13.
//

import Foundation

struct QiitaAccessTokenModel: Codable {
  let clientId: String
  let scopes: [String]
  let token: String
}
