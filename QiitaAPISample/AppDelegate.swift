import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var loginViewController: LoginViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let loginViewController = UIStoryboard.init(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController else {
            fatalError()
        }
        print("ログイン画面を構築")
        self.loginViewController = loginViewController
        let navigationController = UINavigationController(rootViewController: loginViewController)
        let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let loginViewController = self.loginViewController else {
            return true
        }
        print("Qiitaのログイン認証処理を呼び出す")
        loginViewController.openURL(url)
        return true
    }
}

