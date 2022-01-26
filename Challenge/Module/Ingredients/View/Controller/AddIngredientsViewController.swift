//
//  AddIngredientsViewController.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 26/01/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class AddIngredientsViewController: UIViewController {

    @IBOutlet weak var analyzeButton: UIButton!
    @IBOutlet weak var userInputTextView: UITextView!
    private var viewModel: AddIngredientViewModelContract?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup(){
        setupRx()
        setupViews()
    }
    
    private func setupRx(){
        guard let viewModel = viewModel else {
            return
        }
        userInputTextView
            .rx
            .text
            .filterNil()
            .bind(to: viewModel.userInput)
            .disposed(by: disposeBag)
        analyzeButton
            .rx
            .tap
            .bind(to: viewModel.onAnlayzeInputRequest)
            .disposed(by: disposeBag)
        viewModel
            .canAnalyzeText
            .bind(to: analyzeButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func setupViews(){
        userInputTextView.layer.borderColor = UIColor.lightGray.cgColor
        userInputTextView.layer.borderWidth = 0.5
        userInputTextView.layer.cornerRadius = 16
    }
    
    func setViewModel(viewModel: AddIngredientViewModelContract){
        self.viewModel = viewModel
    }

}
