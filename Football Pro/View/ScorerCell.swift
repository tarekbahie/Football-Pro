//
//  ScorerCell.swift
//  Football Pro
//
//  Created by tarek bahie on 6/1/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class ScorerCell : UICollectionViewCell{
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let posLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let goalsLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    func setupViews(){
        addSubview(nameLbl)
        addSubview(posLbl)
        addSubview(goalsLbl)
        
        nameLbl.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        nameLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5).isActive = true
        nameLbl.widthAnchor.constraint(equalToConstant: frame.width/3).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        posLbl.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        posLbl.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor).isActive = true
        posLbl.widthAnchor.constraint(equalToConstant: frame.width/3).isActive = true
        posLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        goalsLbl.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        goalsLbl.leadingAnchor.constraint(equalTo: posLbl.trailingAnchor).isActive = true
        goalsLbl.widthAnchor.constraint(equalToConstant: frame.width/3).isActive = true
        goalsLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(scorer : Scorer){
        self.nameLbl.text = scorer.Name
        self.posLbl.text = scorer.position
        self.goalsLbl.text = scorer.goals
    }
}
