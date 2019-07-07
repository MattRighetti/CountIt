//
//  AppDelegate.swift
//  CountIt
//
//  Created by Mattia Righetti on 15/09/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//

import RealmSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        do {
            _ = try Realm()
        } catch {
            print(error)
        }

        return true
    }
}
