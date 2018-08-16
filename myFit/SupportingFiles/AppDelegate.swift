//
//  AppDelegate.swift
//  Fit
//
//  Created by Winston Maragh on 4/28/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
		return true
	}


}
