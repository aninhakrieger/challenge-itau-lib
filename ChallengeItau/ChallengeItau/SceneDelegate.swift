//
//  SceneDelegate.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()
    }
    
    func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemPink
        
        tabbar.viewControllers = [createNavigationController(viewController: HomeViewController(), title: "Home", iconImage: UIImage(systemName: "square.and.arrow.up")!, tag: 0),
                                  createNavigationController(viewController: InfoViewController(), title: "Info", iconImage: UIImage(systemName: "suit.heart.fill")!, tag: 1)]
        
        return tabbar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = .systemPurple
    }
    
    func createNavigationController(viewController: UIViewController, title: String, iconImage: UIImage, tag: Int) -> UINavigationController{
        viewController.title = title
        viewController.tabBarItem = UITabBarItem(title: title, image: iconImage, tag: tag)
        return UINavigationController(rootViewController: viewController)
    }
}

