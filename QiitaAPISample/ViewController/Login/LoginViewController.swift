//
//  LoginViewController.swift
//  QiitaAPISample
//
//  Created by kasiwa on 2022/10/12.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var loginButton: UIButton! {
        didSet {
            loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func openURL(_ url: URL) {
        guard let queryItems = URLComponents(string: url.absoluteString)?.queryItems,
              let code = queryItems.first(where: {$0.name == "code"})?.value,
              let getState = queryItems.first(where: {$0.name == "state"})?.value,
              getState == API.shared.qiitState
        else {
            return
        }
        API.shared.postAccessToken(code: code) { result in
            switch result {
            case .success(let accessToken):
                UserDefaults.standard.qiitaAccessToken = accessToken.token
                guard let vc = UIStoryboard.init(name: "Article", bundle: nil).instantiateInitialViewController() as? ArticleViewController else {
                    fatalError()
                  }
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

private extension LoginViewController {
    @objc func tapLoginButton() {
        UIApplication.shared.open(API.shared.oAuthURL, options: [:], completionHandler: nil)
    }
}
