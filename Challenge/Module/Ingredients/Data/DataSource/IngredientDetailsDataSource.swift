//
//  IngredientDetailsDataSource.swift
//  Challenge
//
//  Created by Mohamed Eltaweel on 29/01/2022.
//

import Foundation
import Moya

enum IngredientDetailsDataSource {
    case getIngredientDetails(request: GetIngredientDetailsRequest)
}

extension IngredientDetailsDataSource : TargetType
{
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    var baseURL: URL { return URL(string: APIConstants.BASE_URL.rawValue)! }
    
    var path: String {
        switch self {
        case .getIngredientDetails:
            return "nutrition-data"
        }
    }
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getIngredientDetails(let request):
            return .requestParameters(parameters: request.dictionary!, encoding: URLEncoding.queryString)
        }
    }
}
