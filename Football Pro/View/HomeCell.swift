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
        name.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        name.textAlignment = .center
        return name
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        addSubview(leagueName)
        leagueName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        leagueName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        leagueName.widthAnchor.constraint(equalToConstant: 150).isActive = true
        leagueName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}


