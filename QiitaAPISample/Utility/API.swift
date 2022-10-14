//
//  API.swift
//  QiitaAPISample
//
//  Created by kasiwa on 2022/10/14.
//

import Foundation
import Alamofire

enum APIError: Error {
    case postAccessToken
    case getItems
}

final class API {
    static let shared = API()
    private init() {}
    
    private let host = "https://qiita.com/api/v2"
    private let clientID = "a8d5a755884459c5baea8e82092ad4f8256eb8ae"
    private let clientSecret = "cf2d75b3720432790eacdd836079cb9ab3298159"
    let qiitState = "bb17785d811bb1913ef54b0a7657de780defaa2d"

    enum URLParameterName: String {
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case scope = "scope"
        case state = "state"
        case code = "code"
    }
    
    var oAuthURL: URL {
        let endPoint = "/oauth/authorize"
        return URL(string: host + endPoint + "?" +
                    "\(URLParameterName.clientID.rawValue)=\(clientID)" + "&" +
                    "\(URLParameterName.scope.rawValue)=read_qiita+write_qiita" + "&" +
                    "\(URLParameterName.state.rawValue)=\(qiitState)")!
    }
}
