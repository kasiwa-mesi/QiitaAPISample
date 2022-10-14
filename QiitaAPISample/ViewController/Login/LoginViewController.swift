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
}

private extension LoginViewController {
  @objc func tapLoginButton() {
    print("QiitaのログインURLを開く")
    UIApplication.shared.open(API.shared.oAuthURL, options: [:], completionHandler: nil)
  }
}
