//
//  FetchUserAssembly.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import Foundation
import UIKit

class FetchUserAssembly {
    class func configuredModule() -> UIViewController {
        let view = FetchUserVC()
        let service = FetchUsersServiceImpl()
        let presenter = FetchUserPresenter()
        let interactor = FetchAllUsersImpl(service: service)
        
        view.presenterInput = presenter
        presenter.viewController = view
        presenter.fetchUser = interactor
        
        return view
    }
}
