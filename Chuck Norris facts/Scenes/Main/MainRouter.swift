//
//  MainRouter.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/16/22.
//

import Foundation

protocol MainRoutingLogic {
}

protocol MainDataPassing {
}

class MainRouter: NSObject {
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
}

extension MainRouter: MainRoutingLogic {
}

extension MainRouter: MainDataPassing {
}
