//
//  AppDelegate.swift
//  unit5
//
//  Created by user169339 on 5/20/20.
//  Copyright © 2020 user169339. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var orderTabBarItem: UITabBarItem!
    
    @objc func updateOrderBadge() {
        switch MenuController.shared.order.menuItems.count {
        case 0:
            orderTabBarItem.badgeValue = nil
        case let count:
            orderTabBarItem.badgeValue = String(count)
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let temporaryDirectory = NSTemporaryDirectory()
        let urlCache = URLCache(memoryCapacity: 25_000_000, diskCapacity: 50_000_000, diskPath: temporaryDirectory)
        URLCache.shared = urlCache
        
        NotificationCenter.default.addObserver(self, selector:
           #selector(updateOrderBadge), name:
           MenuController.orderUpdatedNotification, object: nil)
        orderTabBarItem = (self.window?.rootViewController as?
           UITabBarController)?.viewControllers?[1].tabBarItem
        
        return true
    }

    func application(_ application: UIApplication,
       willFinishLaunchingWithOptions launchOptions:
       [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //MenuController.shared.loadOrder()
        MenuController.shared.loadItems()
        
        MenuController.shared.loadRemoteData()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application:
       UIApplication) {
        //MenuController.shared.saveOrder()
        MenuController.shared.saveItems()
    }

    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

