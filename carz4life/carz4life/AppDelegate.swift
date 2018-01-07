//
//  AppDelegate.swift
//  carz4life
//
//  Created by Arthur Quemard on 29.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let user = user, let email = user.email else {
                UserManager.shardedInstance.user = User(id: "", email: "")
                let initialViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginSignUpVC")
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
                return
            }
            
            UserManager.shardedInstance.user = User(id: user.uid, email: email)
            let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }

}

