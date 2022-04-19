//
//  JokeTableCell.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/18/22.
//

import UIKit
import Common

class JokeTableCell: UITableViewCell {

    //MARK: - Constants
    static let cellID = "cell"
    
    fileprivate let viewBase: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let labelDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    fileprivate func setup() {
        setupView()
    }
    
    //MARK: - Methods
    func setJoke(_ joke: JokeVO) {
        self.labelDescription.text = joke.value
    }
}

extension JokeTableCell: CodeView {
    func buildViewHierarchy() {
        self.addSubview(viewBase)
        viewBase.addSubview(labelDescription)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            viewBase.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            viewBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            viewBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            viewBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            labelDescription.topAnchor.constraint(equalTo: viewBase.topAnchor),
            labelDescription.leadingAnchor.constraint(equalTo: viewBase.leadingAnchor),
            labelDescription.trailingAnchor.constraint(equalTo: viewBase.trailingAnchor),
            labelDescription.bottomAnchor.constraint(equalTo: viewBase.bottomAnchor),
        ])
    }
    
    func setupCustomConfiguration() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
}
