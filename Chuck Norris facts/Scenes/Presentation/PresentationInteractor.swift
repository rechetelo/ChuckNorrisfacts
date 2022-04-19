//
//  PresentationInteractor.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

protocol PresentationBusinessLogic {
    func getRandomJoke()
}

protocol PresentationDataStore {
}

class PresentationInteractor: NSObject {
    
    //MARK: - Variables
    fileprivate var worker = PresentationWorker()
    var presenter: PresentationPresentationLogic?
}

extension PresentationInteractor: PresentationBusinessLogic {
    func getRandomJoke() {
        worker.getRandom { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let randomJoke):
                self.presenter?.presentRandomJoke(randomJoke)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension PresentationInteractor: PresentationDataStore {
}
