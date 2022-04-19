//
//  PresentationPresenter.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

protocol PresentationPresentationLogic {
    func presentRandomJoke(_ randomJoke: String)
}

class PresentationPresenter {
    weak var viewController: PresentationDisplayLogic?
}

extension PresentationPresenter: PresentationPresentationLogic {
    func presentRandomJoke(_ randomJoke: String) {
        viewController?.displayRandomJoke(randomJoke)
    }
}
