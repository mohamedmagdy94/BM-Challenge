//
//  GetIngredientDetailsRequest.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 29/01/2022.
//

import Foundation

struct GetIngredientDetailsRequest: Codable{
    var appID: String
    var appKey: String
    var nutritionType: String
    var ingredient: String
    
    enum CodingKeys: String, CodingKey {
        case appID = "app_id"
        case appKey = "app_key"
        case nutritionType = "nutrition-type"
        case ingredient = "ingr"
    }
}
