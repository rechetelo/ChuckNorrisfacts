//
//  CategorieCollectionCell.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/17/22.
//

import UIKit
import Common

class CategorieCollectionCell: UICollectionViewCell {
    
    //MARK: - Constants
    static let cellID = "JokeTableCell"
    fileprivate let labelTitle: UILabel = {
       let label = UILabel()
        label.layer.cornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    //MARK: - Setup
    fileprivate func setup() {
        setupView()
    }
    
    //MARK - Methods
    func setTitle(_ categorie: CategorieVO) {
        self.labelTitle.text = categorie.categorie
    }
}

extension CategorieCollectionCell: CodeView {
    func buildViewHierarchy() {
        self.addSubview(labelTitle)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            labelTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
        ])
    }
    
    func setupCustomConfiguration() {
        self.backgroundColor = .white
    }
}
