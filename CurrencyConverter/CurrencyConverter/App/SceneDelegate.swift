//
//  SceneDelegate.swift
//  CurrencyConverter
//
//  Created by kingj on 4/19/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let userStateDataSource = UserStateDataSource(context: context)
        let userStateRepository = UserStateRepositoryImpl(userStateDataSource: userStateDataSource)
        let userStateUseCase = UserStateUseCaseImpl(userStateRepository: userStateRepository)

        let savedClassName = userStateUseCase.getLastViewURI() ?? NSStringFromClass(CurrencyViewController.self)
        
        let currencyVM = DIContainer().currencyViewModel()
        let rootVC = CurrencyViewController(viewModel: currencyVM)
        let nav = UINavigationController(rootViewController: rootVC)
        
        if savedClassName == NSStringFromClass(CalculatorViewController.self) {
            let calculatorVM = DIContainer().calculatorViewModel()
            let calculatorVC = CalculatorViewController(viewModel: calculatorVM)
            rootVC.navigationItem.backButtonTitle = "환율 정보"
            nav.pushViewController(calculatorVC, animated: false)
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
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
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let userStateDataSource = UserStateDataSource(context: context)
        let userStateRepository = UserStateRepositoryImpl(userStateDataSource: userStateDataSource)
        let userStateUseCase = UserStateUseCaseImpl(userStateRepository: userStateRepository)

        guard let savedClassName = userStateUseCase.getLastViewURI() else {
            print("Error: 기본화면으로 이동")
            return
        }
        
        let currencyVM = DIContainer().currencyViewModel()
        let rootVC = CurrencyViewController(viewModel: currencyVM)
        let nav = UINavigationController(rootViewController: rootVC)
        
        if savedClassName == NSStringFromClass(CalculatorViewController.self) {
            let calculatorVM = DIContainer().calculatorViewModel()
            let calculatorVC = CalculatorViewController(viewModel: calculatorVM)
            rootVC.navigationItem.backButtonTitle = "환율 정보"
            nav.pushViewController(calculatorVC, animated: false)
        }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        guard let nav = window?.rootViewController as? UINavigationController,
              let topVC = nav.topViewController else { return }
        
        let vcIdentifier = NSStringFromClass(type(of: topVC))
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // UserState
        let userStateDataSource = UserStateDataSource(context: context)
        let userStateRepository = UserStateRepositoryImpl(userStateDataSource: userStateDataSource)
        let userStateUseCase = UserStateUseCaseImpl(userStateRepository: userStateRepository)
        
        let userState = UserStatePrsn(lastViewURI: vcIdentifier)
        userStateUseCase.updateLastViewURI(userState.lastViewURI ?? "")
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    
}

