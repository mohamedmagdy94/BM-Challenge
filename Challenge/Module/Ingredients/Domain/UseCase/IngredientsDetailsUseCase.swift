//
//  IngredientsDetailsUseCase.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 29/01/2022.
//

import Foundation
import RxSwift

protocol IngredientsDetailsUseCaseContract {
    var userInput: [Ingredient]{get}
    var ingredientsWithDetails: Observable<[Ingredient]>{get}
    func getIngredientsDetails()
}

class IngredientsDetailsUseCase: IngredientsDetailsUseCaseContract{
    
    var ingredientsWithDetails: Observable<[Ingredient]>{observeIngredientsDetailsFetch()}
    private var ingredientsSubject: BehaviorSubject<[Ingredient]>
    var reprository: IngredientDetailsReprositoryContract
    var userInput: [Ingredient]
    private var disposeBag = DisposeBag()
    
    init(reprository: IngredientDetailsReprositoryContract,userInput: [Ingredient]) {
        self.reprository = reprository
        self.ingredientsSubject = BehaviorSubject(value: [])
        self.userInput = userInput
    }
    
    private func observeIngredientsDetailsFetch()->Observable<[Ingredient]>{
        return ingredientsSubject.asObservable()
    }
    
    func getIngredientsDetails() {
        let resultsObservables = userInput.map(reprository.get(ingredient:))
        Observable
            .zip(resultsObservables)
            .map(saveIngredientDetails(details:))
            .debug()
            .bind(to: ingredientsSubject)
            .disposed(by: disposeBag)
    }
    
    private func saveIngredientDetails(details: [GetIngredientDetailsResponse])->[Ingredient]{
        var userIngredients = userInput
        for i in 0..<details.count{
            userIngredients[i].details = details[i]
        }
        return userIngredients
    }
    
}


