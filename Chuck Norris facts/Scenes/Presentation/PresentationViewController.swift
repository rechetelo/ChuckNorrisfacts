//
//  PresentationViewController.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import UIKit

protocol PresentationDisplayLogic: NSObject {
    func displayRandomJoke(_ randomJoke: String)
}

class PresentationViewController: UIViewController {

    //MARK: - Variables
    fileprivate var mainView = PresentationView()
    fileprivate var interactor: PresentationBusinessLogic?
    fileprivate var router: (NSObjectProtocol & PresentationRoutingLogic & PresentationDataPassing)?
    
    //MARK: - View Lifecycle
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.getRandomJoke()
    }
    
    //MARK: - Setup
    func setupView() {
        self.mainView.delegate = self
        setup()
    }
    
    func setup() {
        let viewcontroller = self
        let interactor = PresentationInteractor()
        let presenter = PresentationPresenter()
        let router = PresentationRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router = router
        interactor.presenter = presenter
        presenter.viewController = viewcontroller
        router.viewController = viewcontroller
        router.dataStore = interactor
    }
}

extension PresentationViewController: PresentationDisplayLogic {
    func displayRandomJoke(_ randomJoke: String) {
        mainView.setDescription(randomJoke)
    }
}

extension PresentationViewController: PresentationViewDelegate {
    func didTapContinue() {
        router?.routeToMain()
    }
}
