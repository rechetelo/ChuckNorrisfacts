//
//  MainViewController.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/16/22.
//

import UIKit
import Network

protocol MainDisplayLogic: NSObject {
    func displayCategories(_ categories: [CategorieVO])
    func displayJokes(_ listJokes: [JokeVO])
}

class MainViewController: UIViewController {

    //MARK: - Variables
    fileprivate var mainView = MainView()
    fileprivate var interactor: MainBusinessLogic?
    fileprivate var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    
    //MARK: - View Lifecycle
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.showActivityIndicator(true)
        interactor?.getCategories()
    }
    
    //MARK: - Setup
    func setup() {
        setupConfigurations()
        mainView.delegate = self
    }
    
    fileprivate func setupConfigurations() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension MainViewController: MainDisplayLogic {
    func displayJokes(_ listJokes: [JokeVO]) {
        mainView.setJokes(listJokes)
    }
    
    func displayCategories(_ categories: [CategorieVO]) {
        mainView.setCategories(categories)
    }
}

extension MainViewController: MainViewDelegate {
    func didTapCategorie(_ categorie: CategorieVO) {
        interactor?.searchJokes(categorie.categorie)
    }
}
