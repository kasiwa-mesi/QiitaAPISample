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
    case getArticles
}

final class API {
    static let shared = API()
    private init() {}
    
    private let host = "https://qiita.com/api/v2"
    private let clientID = "3a21fcf230f4ba8f1212df27292f9744dbae93e6"
    private let clientSecret = "77fe92ae8f95e18c9d2c9802e816d09617ecde24"
    let qiitState = "bb17785d811bb1913ef54b0a7657de780defaa2d"
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

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
    
    func postAccessToken(code: String, completion: ((Result<QiitaAccessTokenModel, Error>) -> Void)? = nil) {
        let endPoint = "/access_tokens"
        guard let url = URL(string: host + endPoint + "?" +
                                "\(URLParameterName.clientID.rawValue)=\(clientID)" + "&" +
                                "\(URLParameterName.clientSecret.rawValue)=\(clientSecret)" + "&" +
                                "\(URLParameterName.code)=\(code)") else {
            completion?(.failure(APIError.postAccessToken))
            return
        }
        
        AF.request(url, method: .post).responseData { (response) in
            do {
                print("リクエスト進行中")
                guard
                    let _data = response.data else {
                    completion?(.failure(APIError.postAccessToken))
                    return
                }
                let accessToken = try API.jsonDecoder.decode(QiitaAccessTokenModel.self, from: _data)
                completion?(.success(accessToken))
            } catch let error {
                print("リクエスト失敗")
                completion?(.failure(error))
            }
        }
    }
}
