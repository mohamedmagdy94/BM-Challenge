//
//  AddIngredientsCoordinator.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 26/01/2022.
//

import Foundation
import UIKit

protocol AddIngredientsCoordinating: Coordinating{
    func analyzeText(with ingredients: [Ingredient])
}

class AddIngredientsCoordinator: AddIngredientsCoordinating{
    var navigationContoller: UINavigationController
    
    init(navigationContoller: UINavigationController){
        self.navigationContoller = navigationContoller
    }
    
    func start() {
        let storyboard = R.storyboard.ingredients
        guard let view = storyboard.addIngredientsViewController() else{ return }
        let configurator = AddIngredientsConfigurator()
        let configuredView = configurator.configure(coordinator: self, view: view)
        navigationContoller.pushViewController(configuredView, animated: true)
    }
    
    func analyzeText(with ingredients: [Ingredient]) {
        let nextViewCoorindator = IngredientDetailsCoordinator(navigationContoller: navigationContoller, userInput: ingredients)
        nextViewCoorindator.start()
    }
}
