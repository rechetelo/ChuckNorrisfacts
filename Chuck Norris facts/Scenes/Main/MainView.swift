//
//  MainView.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/16/22.
//

import UIKit
import Common

protocol MainViewDelegate {
    func didTapCategorie(_ categorie: CategorieVO)
}

class MainView: UIView {
    
    //MARK: - Constants
    fileprivate let imageBackground: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "image2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let blurEffect: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let visualEffect = UIVisualEffectView(effect: blur)
        visualEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        return visualEffect
    }()
    
    fileprivate let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    fileprivate let labelDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Empty list, select a category"
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    fileprivate let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: - Variables
    fileprivate var listCategories: [CategorieVO] = []
    fileprivate var listJokes: [JokeVO] = []
    var delegate: MainViewDelegate?
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        setupView()
    }
    
    //MARK: - Methods
    func setCategories(_ categories: [CategorieVO]) {
        listCategories = categories
        DispatchQueue.main.async {
            self.showActivityIndicator(false)
            self.collection.reloadData()
        }
    }
    
    func setJokes(_ jokes: [JokeVO]) {
        listJokes = jokes
        DispatchQueue.main.async {
            self.showActivityIndicator(false)
            self.labelDescription.isHidden = !jokes.isEmpty
            self.tableView.reloadData()
        }
    }
    
    func showActivityIndicator(_ show: Bool) {
        self.activityIndicator.isHidden = !show
        activityIndicator.stopAnimating()
        if(show) {
            activityIndicator.startAnimating()
        }
    }
}

//MARK: - extension CodeView
extension MainView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(imageBackground)
        self.addSubview(blurEffect)
        self.addSubview(collection)
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
        self.addSubview(labelDescription)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: self.topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            blurEffect.topAnchor.constraint(equalTo: self.topAnchor),
            blurEffect.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffect.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurEffect.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            collection.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collection.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            labelDescription.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    func setupCustomConfiguration() {
        self.backgroundColor = .cyan
        
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.register(CategorieCollectionCell.self, forCellWithReuseIdentifier: CategorieCollectionCell.cellID)
     
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(JokeTableCell.self, forCellReuseIdentifier: JokeTableCell.cellID)
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

//MARK: - extension UICollectionViewDelegate
extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else {
            return
        }
        self.showActivityIndicator(true)
        delegate.didTapCategorie(listCategories[indexPath.row])
    }
}

//MARK: - extension UICollectionViewDelegateFlowLayout
extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = listCategories[indexPath.item].categorie
        label.sizeToFit()
        return CGSize(width: label.frame.width + 4, height: 32)
    }
}

//MARK: - extension UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorieCollectionCell.cellID, for: indexPath) as! CategorieCollectionCell
        cell.setTitle(listCategories[indexPath.row])
        return cell
    }
}

//MARK: - extension UITableViewDelegate
extension MainView: UITableViewDelegate {
    
}

//MARK: - extension UITableViewDataSource
extension MainView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listJokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JokeTableCell.cellID, for: indexPath) as! JokeTableCell
        cell.setJoke(listJokes[indexPath.row])
        return cell
    }
}
