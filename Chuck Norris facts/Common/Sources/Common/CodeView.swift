//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

public protocol CodeView {
    func buildViewHierarchy()
    func buildConstraints()
    func setupCustomConfiguration()
    func setupView()
}

extension CodeView {
     public func setupView() {
        buildViewHierarchy()
        buildConstraints()
        setupCustomConfiguration()
    }
    
    public func setupCustomConfiguration() {}
}
