//
//  AddIngredientUseCase.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 23/01/2022.
//

import Foundation
import RxSwift
import UIKit

protocol AddIngredientUseCaseContract{
    var canAnalyzeText: Observable<Bool>{get}
    var analyzeText: PublishSubject<Void>{get}
    var userInput: BehaviorSubject<String>{get}
    var ingredients: Observable<[Ingredient]>{get}
}

class AddIngredientUseCase: AddIngredientUseCaseContract{
    
    var ingredients: Observable<[Ingredient]> { getIngredientsFromUserInput() }
    var canAnalyzeText: Observable<Bool> { analyzeUserInput() }
    var analyzeText: PublishSubject<Void>
    var userInput: BehaviorSubject<String>
    var extractIngredientsService: ExtractingIngredients
    private var ingredientsSubject: BehaviorSubject<[Ingredient]>
    
    init(extractIngredientsService: ExtractingIngredients){
        analyzeText = PublishSubject()
        userInput = BehaviorSubject(value: "")
        ingredientsSubject = BehaviorSubject(value: [])
        self.extractIngredientsService = extractIngredientsService
    }
    
    private func getIngredientsFromUserInput()->Observable<[Ingredient]>{
        let observable = userInput
            .asObservable()
            .map(extractIngredientsService.extractIngredients(userInput:))
        return observable
    }
    
    private func analyzeUserInput()->Observable<Bool>{
        let observable = userInput
            .asObservable()
            .map(extractIngredientsService.extractIngredients(userInput:))
            .map(canAnalyzeText)
        return observable
    }
    
    private func canAnalyzeText(ingredients: [Ingredient])->Bool{
        return ingredients.count > 0
    }
    
}



