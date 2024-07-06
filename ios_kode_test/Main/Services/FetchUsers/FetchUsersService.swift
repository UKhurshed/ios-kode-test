//
//  FetchUsersService.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import Foundation

class FetchUsersServiceImpl: FetchUsersService {
    
    private var viewData: [ViewData] = []
    
    func fetchUsers(completion: @escaping (([ViewData]?, String?) -> Void)) {
        apiProvider.request(.fetchUsers) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(UsersModel.self, from: response.data)
                    var viewData: [ViewData] = []
                    results.items.forEach { item in
                        viewData.append(ViewData(
                            id: item.id,
                            avatarUrl: item.avatarURL,
                            firstName: item.firstName,
                            lastName: item.lastName,
                            userTag: item.userTag,
                            department: item.department,
                            position: item.position,
                            birthday: item.birthday,
                            phone: item.phone))
                    }
                    self.viewData.removeAll()
                    self.viewData.append(contentsOf: viewData)
                    completion(viewData, nil)
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
                
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func searchUser(searchText: String) -> [ViewData] {
        
        if searchText.isEmpty {
            return viewData
        } else {
            var result: [ViewData] = []
            
            for viewDatum in viewData {
                if viewDatum.firstName.contains(searchText) {
                    result.append(viewDatum)
                }
            }
            
            return result
        }
    }
    
    func clearState() -> [ViewData] {
        return viewData
    }
}
