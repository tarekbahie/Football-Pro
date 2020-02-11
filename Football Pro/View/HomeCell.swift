//
//  LeagueCell.swift
//  Football Pro
//
//  Created by tarek bahie on 5/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class HomeCell : UICollectionViewCell {
    let leagueName : UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.setupBasicAttributes()
        return name
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGradientLayer()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        addSubview(leagueName)
        leagueName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        leagueName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        leagueName.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        leagueName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}


