//
//  UserDefaults+.swift
//  QiitaAPISample
//
//  Created by kasiwa on 2022/10/14.
//

import Foundation

extension UserDefaults {
  private var qiitaAccessTokenKey: String { "qiitaAccessTokenKey" }
  var qiitaAccessToken: String {
    get {
      self.string(forKey: qiitaAccessTokenKey) ?? ""
    }
    set {
      self.setValue(newValue, forKey: qiitaAccessTokenKey)
    }
  }
}
