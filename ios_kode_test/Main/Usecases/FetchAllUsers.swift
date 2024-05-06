//
//  FetchAllUsers.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import Foundation

protocol FetchAllUsers: AnyObject {
    func fetchUsers(completion: @escaping (([ViewData]?, String?) -> Void))
}

protocol FetchUsersService: AnyObject {
    func fetchUsers(completion: @escaping (([ViewData]?, String?) -> Void))
}

class FetchAllUsersImpl: FetchAllUsers {
    
    let service: FetchUsersService
    
    init(service: FetchUsersService) {
        self.service = service
    }
    
    func fetchUsers(completion: @escaping (([ViewData]?, String?) -> Void)) {
        service.fetchUsers { model, error in
            if let model {
                completion(model, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
