//
//  FetchUsersService.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import Foundation

class FetchUsersServiceImpl: FetchUsersService {
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
                    completion(viewData, nil)
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
                
            case .failure(let error):
                print("error: \(error.errorCode) & desc: \(error.errorDescription)")
                completion(nil, error.localizedDescription)
            }
        }
    }
}
