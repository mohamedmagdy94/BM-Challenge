//
//  IngredientDetailsViewController.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 30/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class IngredientDetailsViewController: UIViewController {

    private var viewModel: IngredientDetailsViewModelContract?
    @IBOutlet private weak var ingredientsTable: UITableView!
    @IBOutlet private weak var totalAnalysisButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        setupRx()
    }
    
    private func setupRx(){
        guard let viewModel = viewModel else {
            return
        }
        ingredientsTable.register(UINib(nibName: IngredientTableViewCell.NIB_IDENTIFIER, bundle: nil), forCellReuseIdentifier: IngredientTableViewCell.IDENTIFIER)
        viewModel
            .ingredientDetails
            .asDriver(onErrorJustReturn: [IngredientDetailsCellViewModel]())
            .asObservable()
            .bind(to: ingredientsTable.rx
                    .items(cellIdentifier: IngredientTableViewCell.IDENTIFIER, cellType: IngredientTableViewCell.self))
                { index, element, cell in
                    cell.setup(with: element)
            }
            .disposed(by: disposeBag)
        totalAnalysisButton
            .rx
            .tap
            .bind(to: viewModel.onTotalReportRequested)
            .disposed(by: disposeBag)
        viewModel.getIngredientDetails()
        viewModel
            .errorMessage
            .subscribe(onNext: handleError)
            .disposed(by: disposeBag)
        viewModel
            .isLoading
            .map{ !$0 }
            .bind(to: loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
    }
    private func handleError(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setViewModel(with viewModel: IngredientDetailsViewModelContract){
        self.viewModel = viewModel
    }
    

}
