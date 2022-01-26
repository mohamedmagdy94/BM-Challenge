//
//  AddIngredientViewModel.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 26/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol AddIngredientViewModelContract{
    var canAnalyzeText: Observable<Bool>{get}
    var userInput: BehaviorSubject<String>{get}
    var onAnlayzeInputRequest: PublishSubject<Void>{get}
}

class AddIngredientViewModel: AddIngredientViewModelContract{
    
    var canAnalyzeText: Observable<Bool> { createCanAnalyzeTextObservable() }
    var userInput: BehaviorSubject<String>
    var addIngredientsUseCase: AddIngredientUseCaseContract
    var onAnlayzeInputRequest: PublishSubject<Void>
    private var navigatonCoordinator: AddIngredientsCoordinating
    private var disposeBag: DisposeBag = DisposeBag()
    
    init( addIngredientsUseCase: AddIngredientUseCaseContract,navigatonCoordinator: AddIngredientsCoordinating) {
        self.userInput = BehaviorSubject(value: "")
        self.addIngredientsUseCase = addIngredientsUseCase
        self.navigatonCoordinator = navigatonCoordinator
        self.onAnlayzeInputRequest = PublishSubject()
        observeUserInput()
        observeAnalyzeInputRequest()
    }
    
    private func observeAnalyzeInputRequest(){
        onAnlayzeInputRequest
            .asObservable()
            .subscribe(onNext: analyzeInput)
            .disposed(by: disposeBag)
    }
    
    private func analyzeInput(){
        let service = addIngredientsUseCase.extractIngredientsService
        navigatonCoordinator.analyzeText(with: service)
    }
    
    private func observeUserInput(){
        userInput
            .bind(to: addIngredientsUseCase.userInput)
            .disposed(by: disposeBag)
    }
    
    private func createCanAnalyzeTextObservable()->Observable<Bool>{
        let observable = addIngredientsUseCase.canAnalyzeText
        return observable
    }
    
}
