//
//  MainInteractor.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/16/22.
//

import Foundation

protocol MainBusinessLogic {
    func getCategories()
    func searchJokes(_ query: String)
}

protocol MainDataStore {
}

class MainInteractor {
    
    //MARK: - Variables
    fileprivate var worker = MainWorker()
    var presenter: MainPresentationLogic?
}

extension MainInteractor: MainBusinessLogic {
    func getCategories() {
        worker.getCategories { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let categories):
                self.presenter?.presentListCategories(categories)
            case .failure(_):
                break
            }
        }
    }
    
    func searchJokes(_ query: String) {
        worker.searchJokes(query) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let SearchDTO):
                self.presenter?.presentJokes(SearchDTO)
            case .failure(_):
                break
            }
        }
    }
}

extension MainInteractor: MainDataStore {
    
}
