//
//  IngredientDetailsCoordinator.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 29/01/2022.
//

import Foundation
import UIKit

protocol IngredientDetailsCoordinating: Coordinating{
    func showTotalReport(with ingredients: [Ingredient])
}

class IngredientDetailsCoordinator: IngredientDetailsCoordinating{
    var navigationContoller: UINavigationController
    var userInput: [Ingredient]

    init(navigationContoller: UINavigationController,userInput: [Ingredient]){
        self.navigationContoller = navigationContoller
        self.userInput = userInput
    }

    func start() {
        let storyboard = R.storyboard.ingredients
        guard let view = storyboard.ingredientDetailsViewController() else{ return }
        let configurator = IngredientsDetailsConfigurator()
        let configuredView = configurator.configure(coordinator: self, view: view, ingredients: userInput)
        navigationContoller.pushViewController(configuredView, animated: true)
    }

    func showTotalReport(with ingredients: [Ingredient]) {
        
    }
}

