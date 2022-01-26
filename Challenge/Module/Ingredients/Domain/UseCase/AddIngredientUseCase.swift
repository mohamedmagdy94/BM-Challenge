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
    private var ingredientsSubject: BehaviorSubject<[Ingredient]>
    
    init(){
        analyzeText = PublishSubject()
        userInput = BehaviorSubject(value: "")
        ingredientsSubject = BehaviorSubject(value: [])
    }
    
    private func getIngredientsFromUserInput()->Observable<[Ingredient]>{
        return Observable.empty()
    }
    
    private func analyzeUserInput()->Observable<Bool>{
        return Observable.empty()
    }
    
}



