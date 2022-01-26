//
//  AddIngredientsConfigurator.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 26/01/2022.
//

import Foundation

protocol AddIngredientsConfigurating{
    func configure(coordinator: AddIngredientsCoordinating,view: AddIngredientsViewController)->AddIngredientsViewController
}

struct AddIngredientsConfigurator: AddIngredientsConfigurating{
    func configure(coordinator: AddIngredientsCoordinating,view: AddIngredientsViewController) -> AddIngredientsViewController {
        let service = ExtractIngredients(ingredientsDelimeter: "\n", ingredientDelimeter: ",")
        let useCase = AddIngredientUseCase(extractIngredientsService: service)
        let viewModel = AddIngredientViewModel(addIngredientsUseCase: useCase, navigatonCoordinator: coordinator)
        view.setViewModel(viewModel: viewModel)
        return view
    }
}
