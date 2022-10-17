import UIKit
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var loginViewController: LoginViewController?
    private var offlineViewController: OfflineViewController?
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.kasiwa")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let loginViewController = UIStoryboard.init(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController else {
            fatalError()
        }
        
        guard let offlineViewController = UIStoryboard.init(name: "Offline", bundle: nil).instantiateInitialViewController() as? OfflineViewController else {
            fatalError()
        }
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.loginViewController = loginViewController
                self.pushNavigate(vc: loginViewController)
            } else {
                self.offlineViewController = offlineViewController
                self.pushNavigate(vc: offlineViewController)
            }
        }
        
        monitor.start(queue: queue)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let loginViewController = self.loginViewController else {
            return true
        }
        loginViewController.openURL(url)
        return true
    }
    
    func pushNavigate(vc: UIViewController) {
        DispatchQueue.main.async {
            let navigationController = UINavigationController(rootViewController: vc)
            let window = UIWindow()
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            
            self.window = window
        }
    }
}

