//
//  FetchAllUsers.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import Foundation

protocol FetchAllUsers: AnyObject {
    func fetchUsers(completion: @escaping (([ViewData]?, String?) -> Void))
    
    func searchUsers(searchText: String) -> [ViewData]
    
    func clearState() -> [ViewData]
}

protocol FetchUsersService: AnyObject {
    func fetchUsers(completion: @escaping (([ViewData]?, String?) -> Void))
    
    func searchUser(searchText: String) -> [ViewData]
    
    func clearState() -> [ViewData]
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
    
    func searchUsers(searchText: String) -> [ViewData] {
        return service.searchUser(searchText: searchText)
    }
    
    func clearState() -> [ViewData] {
        return service.clearState()
    }
}
