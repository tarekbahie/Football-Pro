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
        lbl.text = nil
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let posLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = nil
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let goalsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = nil
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let arrowLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.text = ">"
        return lbl
    }()
    fileprivate func addCellSubviews() {
        addSubview(nameLbl)
        addSubview(posLbl)
        addSubview(goalsLbl)
        addSubview(arrowLbl)
    }
    
    fileprivate func setupNameLblConstraints() {
        nameLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5).isActive = true
        nameLbl.widthAnchor.constraint(equalToConstant: frame.width/3).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    fileprivate func setupPosLblConstraints() {
        posLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        posLbl.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor).isActive = true
        posLbl.widthAnchor.constraint(equalToConstant: frame.width/3).isActive = true
        posLbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    fileprivate func setupGoalsLblConstraints() {
        goalsLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        goalsLbl.leadingAnchor.constraint(equalTo: posLbl.trailingAnchor).isActive = true
        goalsLbl.widthAnchor.constraint(equalToConstant: frame.width/3).isActive = true
        goalsLbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    fileprivate func setupArrowLblConstraints() {
        arrowLbl.centerYAnchor.constraint(equalTo: nameLbl.centerYAnchor).isActive = true
        arrowLbl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -5).isActive = true
        arrowLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        arrowLbl.widthAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    func setupViews(){
        addCellSubviews()
        setupNameLblConstraints()
        setupPosLblConstraints()
        setupGoalsLblConstraints()
        setupArrowLblConstraints()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupBackGroundColor()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupCellFont(_ fSize: CGFloat) {
        nameLbl.font = UIFont.systemFont(ofSize: fSize)
        posLbl.font = UIFont.systemFont(ofSize: fSize)
        goalsLbl.font = UIFont.systemFont(ofSize: fSize)
        arrowLbl.font = UIFont.systemFont(ofSize: fSize)
    }
    
    fileprivate func setupCellTxt(_ scorer: Scorer) {
        self.nameLbl.text = scorer.Name
        self.posLbl.text = scorer.position
        self.goalsLbl.text = scorer.goals
    }
    
    func configureCell(scorer : Scorer,fSize:CGFloat){
        setupCellTxt(scorer)
        setupCellFont(fSize)
    }
}
