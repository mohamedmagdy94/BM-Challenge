//
//  IngredientTableViewCell.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 30/01/2022.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    static var IDENTIFIER = "INGREDIENT"
    static var NIB_IDENTIFIER = "IngredientTableViewCell"
    
    @IBOutlet weak var qunatityLabek: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var rootView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(with viewModel: IngredientDetailsCellViewModel){
        rootView.layer.cornerRadius = 8
        rootView.layer.borderColor = UIColor.lightGray.cgColor
        rootView.layer.borderWidth = 0.5
        qunatityLabek.text = viewModel.qunatity
        unitLabel.text = viewModel.unit
        nameLabel.text = viewModel.name
        weightLabel.text = viewModel.weight
        caloriesLabel.text = viewModel.calories
    }
    
}
