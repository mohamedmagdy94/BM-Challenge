//
//  AppCoordinator.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 26/01/2022.
//

import Foundation
import UIKit

struct AppCoordinator: Coordinating{
    
    var window: UIWindow
    
    init(window: UIWindow){
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let firstView = AddIngredientsCoordinator(navigationContoller: navigationController)
        window.rootViewController = navigationController
        firstView.start()
    }
    
}
