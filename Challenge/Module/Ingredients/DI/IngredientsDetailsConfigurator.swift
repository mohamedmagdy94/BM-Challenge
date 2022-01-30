//
//  IngredientsDetailsConfigurator.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 30/01/2022.
//

import Foundation
import Moya

protocol IngredientsDetailsConfigurating{
    func configure(coordinator: IngredientDetailsCoordinating,view: IngredientDetailsViewController,ingredients: [Ingredient])->IngredientDetailsViewController
}

struct IngredientsDetailsConfigurator: IngredientsDetailsConfigurating{
    
    func configure(coordinator: IngredientDetailsCoordinating,view: IngredientDetailsViewController,ingredients: [Ingredient])->IngredientDetailsViewController {
        let dataSource = MoyaProvider<IngredientDetailsDataSource>(plugins: [NetworkLoggerPlugin()])
        let reprository = IngredientDetailsReprository(dataSource: dataSource)
        let useCase = IngredientsDetailsUseCase(reprository: reprository, userInput: ingredients)
        let viewModel = IngredientDetailsViewModel(useCase: useCase, navigationCoordinator: coordinator)
        view.setViewModel(with: viewModel)
        return view
    }
}
