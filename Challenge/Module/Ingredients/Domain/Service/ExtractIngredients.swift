//
//  ExtractIngredients.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 23/01/2022.
//

import Foundation

protocol ExtractingIngredients{
    var ingredients: [Ingredient] {get}
    func extractIngredients(userInput: String)->[Ingredient]
}

class ExtractIngredients: ExtractingIngredients{
    
    var ingredientsDelimeter: String
    var ingredientDelimeter: String
    var ingredients: [Ingredient]
    private var userInput: String
    
    init(ingredientsDelimeter: String, ingredientDelimeter: String){
        self.ingredientDelimeter = ingredientsDelimeter
        self.ingredientsDelimeter = ingredientsDelimeter
        userInput = ""
        ingredients = []
    }
    
    func extractIngredients(userInput: String) -> [Ingredient] {
        self.userInput = userInput
        let ingredients = splitIngredientsInStrings()
            .compactMap(mapStringToIngredient)
        self.ingredients = ingredients
        return ingredients
    }
    
    private func splitIngredientsInStrings()->[String]{
        let ingredients = userInput
            .replacingOccurrences(of: ",", with: "")
            .split(separator: "\n")
            .map{ String($0) }
        return ingredients
    }
    
    private func mapStringToIngredient(string: String)->Ingredient?{
        let ingredientComponents = string
            .split(separator: " ")
            .map{ String($0) }
        guard ingredientComponents.count == 3 else{ return nil }
        let ingredientName = ingredientComponents[0]
        let ingredientQuantity = Int(ingredientComponents[1]) ?? 0
        let ingredientUnit = ingredientComponents[1]
        let ingredient = Ingredient(name: ingredientName, quantity: ingredientQuantity, unit: ingredientUnit)
        return ingredient
    }
    
}
