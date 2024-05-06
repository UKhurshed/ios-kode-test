//
//  API.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import Foundation
import Moya

let apiProvider = MoyaProvider<API>()

enum API {
    case fetchUsers
}

extension API: TargetType {
    var task: Moya.Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var baseURL: URL {
        return URL(string: "https://stoplight.io/mocks/kode-api/trainee-test/331141861/")!
    }
    
    var path: String  {
        switch self {
        case .fetchUsers:
            return "users"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
}
