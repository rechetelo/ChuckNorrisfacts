//
//  MainPresenter.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/16/22.
//

import Foundation
import Network

protocol MainPresentationLogic {
    func presentListCategories(_ categories: [String])
    func presentJokes(_ search: SearchDTO)
}

class MainPresenter {
    weak var viewController: MainDisplayLogic?
}

extension MainPresenter: MainPresentationLogic {
    func presentJokes(_ search: SearchDTO) {
        
        let serachVO = search.result.map { JokeVO(categories: $0.categories,
                                                  url: $0.url,
                                                  value: $0.value) }
        viewController?.displayJokes(serachVO)
    }
    
    func presentListCategories(_ categories: [String]) {
        let categoriesVO = categories.map { CategorieVO(categorie: $0) }
        viewController?.displayCategories(categoriesVO)
    }
}
