//
//  AppDelegate.swift
//  Parstagram
//
//  Created by Nathan Miranda on 3/25/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.whiteColor()
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "InstaScratch"
                configuration.clientKey = "ljkshdf889thwenoi8eiuhf9os8934o8"
                configuration.server = "https://instascratch.herokuapp.com/parse"
            })
        )
        
        if PFUser.currentUser() != nil {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("tabBar") as UIViewController
            window?.rootViewController = vc
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout:", name: "logout", object: nil)
        
        // Override point for customization after application launch.
        return true
    }
    
    func userDidLogout(notification: NSNotification) {
        PFUser.logOut()
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

