//
//  SquadCell.swift
//  Football Pro
//
//  Created by tarek bahie on 6/1/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class SquadCell : UICollectionViewCell{
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.numberOfLines = 0
        return lbl
    }()
    let posLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let ageLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let nationalityLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    func setupViews(){
        addSubview(nameLbl)
        addSubview(posLbl)
        addSubview(ageLbl)
        addSubview(nationalityLbl)
        
        nameLbl.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        nameLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5).isActive = true
        nameLbl.widthAnchor.constraint(equalToConstant: frame.width/4).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        posLbl.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        posLbl.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor).isActive = true
        posLbl.widthAnchor.constraint(equalToConstant: frame.width/4).isActive = true
        posLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        ageLbl.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        ageLbl.leadingAnchor.constraint(equalTo: posLbl.trailingAnchor).isActive = true
        ageLbl.widthAnchor.constraint(equalToConstant: frame.width/4).isActive = true
        ageLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nationalityLbl.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        nationalityLbl.leadingAnchor.constraint(equalTo: ageLbl.trailingAnchor).isActive = true
        nationalityLbl.widthAnchor.constraint(equalToConstant: frame.width/4).isActive = true
        nationalityLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(player : Player){
        self.nameLbl.text = player.name
        self.posLbl.text = player.position
        self.ageLbl.text = player.age
        self.nationalityLbl.text = player.nationality
    }
}
