//
//  IngredientDetailsViewModel.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 29/01/2022.
//

import Foundation
import RxSwift

protocol IngredientDetailsViewModelContract{
    var ingredientDetails: Observable<[IngredientDetailsCellViewModel]>{get}
    var isLoading: Observable<Bool>{get}
    var errorMessage: Observable<String>{get}
    var onTotalReportRequested: PublishSubject<Void>{get}
    func getIngredientDetails()
}

class IngredientDetailsViewModel: IngredientDetailsViewModelContract{
    var ingredientDetails: Observable<[IngredientDetailsCellViewModel]>{observeIngredientDetails()}
    var isLoading: Observable<Bool>{observeLoading()}
    var errorMessage: Observable<String>{observeError()}
    var onTotalReportRequested: PublishSubject<Void>
    private var navigationCoordinator: IngredientDetailsCoordinating
    private var useCase: IngredientsDetailsUseCaseContract
    private var isLoadingSubject: PublishSubject<Bool>
    private var errorMessageSubject: PublishSubject<String>
    private var disposeBag = DisposeBag()
    
    init(useCase: IngredientsDetailsUseCaseContract,navigationCoordinator: IngredientDetailsCoordinating){
        self.useCase = useCase
        self.navigationCoordinator = navigationCoordinator
        self.isLoadingSubject = PublishSubject()
        self.onTotalReportRequested = PublishSubject()
        self.errorMessageSubject = PublishSubject()
    }
    
    private func observeTotalReportRequest(){
        onTotalReportRequested
            .asObservable()
            .subscribe(onNext: showTotalReport)
            .disposed(by: disposeBag)
    }
    
    func showTotalReport() {
        let userInput = useCase.userInput
        navigationCoordinator.showTotalReport(with: userInput)
    }
    
    func getIngredientDetails() {
        self.isLoadingSubject.onNext(true)
        self.useCase.getIngredientsDetails()
    }
    
    private func observeIngredientDetails()->Observable<[IngredientDetailsCellViewModel]>{
        return useCase
            .ingredientsWithDetails
            .map(mapIngredientDetailsToViewModels(from:))
            .do(onNext: handleDetailsFetch(_:),onError: handleFetchError(_:))
    }
    
    private func handleDetailsFetch(_:[IngredientDetailsCellViewModel]){
        self.isLoadingSubject.onNext(false)
    }
    
    private func handleFetchError(_:Error){
        self.isLoadingSubject.onNext(false)
        self.errorMessageSubject.onNext("Server Error")
    }
    
    private func mapIngredientDetailsToViewModels(from details: [Ingredient])->[IngredientDetailsCellViewModel]{
        let viewModels = details
            .map{ IngredientDetailsCellViewModel(qunatity: "\($0.quantity)", unit: $0.unit, name: $0.name, calories: "\($0.details?.calories ?? 0)", weight: "\($0.details?.totalWeight ?? 0)") }
        return viewModels
    }
    
    private func observeError()->Observable<String>{
        return errorMessageSubject.asObservable()
    }
    
    private func observeLoading()->Observable<Bool>{
        return isLoadingSubject.asObservable()
    }
}
