//
//  PresentationView.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import UIKit
import Common

protocol PresentationViewDelegate {
    func didTapContinue()
}

class PresentationView: UIView {
    
    //MARK: - Constants
    fileprivate let imageBackground: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "image1")
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
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chuck_norris")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let labelTitle: UILabel = {
       let label = UILabel()
        label.text = "Chuck Norris facts"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labeldescription: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let buttonContinue: UIButton = {
       let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(onContinue), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Variables
    var delegate: PresentationViewDelegate?
    
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
    @objc private func onContinue() {
        guard let delegate = delegate else {
            return
        }
        delegate.didTapContinue()
    }
    
    func setDescription(_ description: String) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.labeldescription.text = description
        }
    }
}

//MARK: - Extension CodeView
extension PresentationView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(imageBackground)
        self.addSubview(blurEffect)
        self.addSubview(activityIndicator)
        self.addSubview(imageView)
        self.addSubview(labelTitle)
        self.addSubview(labeldescription)
        self.addSubview(buttonContinue)
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
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            labeldescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 16),
            labeldescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labeldescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            buttonContinue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            buttonContinue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            buttonContinue.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            buttonContinue.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupCustomConfiguration() {
        self.backgroundColor = .white
        activityIndicator.startAnimating()
    }
}
