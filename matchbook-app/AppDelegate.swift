//
//  AppDelegate.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseAnalytics
import RealmSwift
import PhotosUI

@main
final class AppDelegate: UIResponder {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
}
                   
// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Firebase configure for authentication services
        FirebaseApp.configure()
        
        // Disable AutoLayout output 
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        // MARK: - IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        
        // Initial view controller
        setInitialViewController()
        
        // MARK: - Realm
        initRealm()
        
        // MARK: - Camera Permissions
        cameraPermissions()
        
        return true
    }
}

// MARK: - SetInitialViewController
extension AppDelegate {
    func setInitialViewController() {
        let nc = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: nc)
        appCoordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
}

// MARK: - InitRealm
extension AppDelegate {
    private func initRealm() {
        let config = Realm.Configuration(schemaVersion: 17)
        Realm.Configuration.defaultConfiguration = config
    }
}

// MARK: - cameraPermissions
extension AppDelegate {
    func cameraPermissions() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
            DispatchQueue.main.async { [unowned self] in
                switch status {
                case .authorized: break
                case .limited: print("Access limited.")
                case .restricted: print("Restricted")
                case .denied: print("Access Denied")
                case .notDetermined:
                    break

                @unknown default:
                    break
                }
            }
        }
    }
}
