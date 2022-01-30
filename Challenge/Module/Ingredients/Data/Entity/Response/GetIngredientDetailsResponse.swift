//
//  GetIngredientDetailsResponse.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 29/01/2022.
//

import Foundation

typealias IngredientDetails = GetIngredientDetailsResponse

// MARK: - GetIngredientDetailsResponse
struct GetIngredientDetailsResponse: Codable{
    let uri: String?
    let calories: Int?
    let totalWeight: Double?
    let dietLabels, healthLabels: [String]?
    let totalNutrients, totalDaily: [String: TotalDaily]?
    let totalNutrientsKCal: TotalNutrientsKCal?
}

// MARK: - TotalDaily
struct TotalDaily: Codable {
    let label: String?
    let quantity: Double?
    let unit: String?
}

// MARK: - TotalNutrientsKCal
struct TotalNutrientsKCal: Codable {
    let enercKcal, procntKcal, fatKcal, chocdfKcal: TotalDaily?
}
