//
//  SceneDelegate.swift
//  ResumeApp
//
//  Created by Łukasz Bazior on 19/06/2020.
//  Copyright © 2020 Łukasz Bazior. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = makeResumeTabBarController()
        window?.makeKeyAndVisible()
    }
    
    private func makeResumeTabBarController() -> UIViewController {
        let service = ResumeService()
        
        let generalViewController = GeneralViewController()
        let generalPresenter = GeneralPresenter()
        generalPresenter.view = generalViewController
        generalViewController.presenter = generalPresenter
        generalPresenter.mailHandler = MailHandler(viewController: generalViewController)
        
        let skillsViewController = SkillsViewController()
        let skillsPresenter = SkillsPresenter()
        skillsPresenter.view = skillsViewController
        
        let experienceViewController = ExperienceViewController()
        
        let resumeTabBarController = ResumeTabBarController(generalView: generalViewController, skillsView: skillsViewController, experienceView: experienceViewController)
        let resumeTabBarPresenter = ResumeTabBarPresenter(service: service)
        service.delegate = resumeTabBarPresenter
        resumeTabBarPresenter.generalResumeSetter = generalPresenter
        resumeTabBarPresenter.skillsResumeSetter = skillsPresenter
        
        resumeTabBarController.presenter = resumeTabBarPresenter
        
        return resumeTabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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


}
