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
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let posLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let ageLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let nationalityLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.setupBasicAttributes()
        return lbl
    }()
    fileprivate func addCellSubviews() {
        addSubview(nameLbl)
        addSubview(posLbl)
        addSubview(ageLbl)
        addSubview(nationalityLbl)
    }
    
    fileprivate func setupNameLblConstraints() {
        nameLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5).isActive = true
        nameLbl.widthAnchor.constraint(equalToConstant: frame.width/4).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupPosLblConstraints() {
        posLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        posLbl.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor).isActive = true
        posLbl.widthAnchor.constraint(equalToConstant: frame.width/4).isActive = true
        posLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupAgeLblConstraints() {
        ageLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ageLbl.leadingAnchor.constraint(equalTo: posLbl.trailingAnchor).isActive = true
        ageLbl.widthAnchor.constraint(equalToConstant: frame.width/4).isActive = true
        ageLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupNationalityLblConstraints() {
        nationalityLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nationalityLbl.leadingAnchor.constraint(equalTo: ageLbl.trailingAnchor).isActive = true
        nationalityLbl.widthAnchor.constraint(equalToConstant: frame.width/4).isActive = true
        nationalityLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupViews(){
        addCellSubviews()
        setupNameLblConstraints()
        setupPosLblConstraints()
        setupAgeLblConstraints()
        setupNationalityLblConstraints()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackGroundColor()
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupCellFont(_ fSize: CGFloat) {
        self.nameLbl.font = UIFont.systemFont(ofSize: fSize)
        self.posLbl.font = UIFont.systemFont(ofSize: fSize)
        self.ageLbl.font = UIFont.systemFont(ofSize: fSize)
        self.nationalityLbl.font = UIFont.systemFont(ofSize: fSize)
    }
    
    fileprivate func setupCellTxt(_ player: Player) {
        self.nameLbl.text = player.name
        self.posLbl.text = player.position
        self.ageLbl.text = player.age
        self.nationalityLbl.text = player.nationality
    }
    
    func configureCell(player : Player,fSize:CGFloat){
        setupCellTxt(player)
        setupCellFont(fSize)
    }
}
