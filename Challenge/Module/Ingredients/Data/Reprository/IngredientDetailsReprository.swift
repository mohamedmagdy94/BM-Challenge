//
//  IngredientDetailsReprository.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 29/01/2022.
//

import Foundation
import RxSwift
import Moya

protocol IngredientDetailsReprositoryContract{
    func get(ingredient: Ingredient)->Observable<GetIngredientDetailsResponse>
}

class IngredientDetailsReprository: IngredientDetailsReprositoryContract{
    
    var dataSource: MoyaProvider<IngredientDetailsDataSource>
    
    init(dataSource: MoyaProvider<IngredientDetailsDataSource>){
        self.dataSource = dataSource
    }
    
    func get(ingredient: Ingredient) -> Observable<GetIngredientDetailsResponse> {
        let ingredientString = "\(ingredient.quantity) \(ingredient.unit) \(ingredient.name)"
        let request = GetIngredientDetailsRequest(appID: APIConstants.APP_ID.rawValue, appKey: APIConstants.API_KEY.rawValue, nutritionType: "cooking", ingredient: ingredientString)
        let apiCallObservable = dataSource
            .rx
            .request(.getIngredientDetails(request: request))
            .asObservable()
            .map(mapResponseDataToEntity(from:))
            .debug()
        return apiCallObservable
    }
    
    private func mapResponseDataToEntity(from response: Response) throws -> GetIngredientDetailsResponse {
        let jsonDecoder = JSONDecoder()
        do{
            try jsonDecoder.decode(GetIngredientDetailsResponse.self, from: response.data)
        }catch{
            print(error)
        }
        guard let entity = try? jsonDecoder.decode(GetIngredientDetailsResponse.self, from: response.data) else{ throw GetIngredientDetailsError.SERVER_ERROR }
        return entity
        
    }
    
}
