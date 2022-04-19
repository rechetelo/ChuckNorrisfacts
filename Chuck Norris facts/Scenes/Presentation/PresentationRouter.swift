//
//  PresentationRouter.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation
import UIKit

protocol PresentationRoutingLogic {
    func routeToMain()
}

protocol PresentationDataPassing {
}

class PresentationRouter: NSObject {
    
    var viewController: PresentationViewController?
    var dataStore: PresentationDataStore?
}

extension PresentationRouter: PresentationRoutingLogic {
    func routeToMain() {
        let main = MainViewController()
        main.modalPresentationStyle = .overFullScreen
        viewController?.present(main, animated: true)
    }
}

extension PresentationRouter: PresentationDataPassing {
    
}
