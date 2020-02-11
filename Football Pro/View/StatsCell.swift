//
//  EventsCell.swift
//  Football Pro
//
//  Created by tarek bahie on 11/7/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class StatsCell:UICollectionViewCell{
    let shotsOnGoalLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = "On Target"
        return lbl
    }()
    let totalShotsLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = "Shots"
        return lbl
    }()
    let foulsLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = "Fouls"
        return lbl
    }()
    let cornersLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = "Corners"
        return lbl
    }()
    let yellowCardsLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = "Yellow Cards"
        return lbl
    }()
    let redCardsLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = "Red Cards"
        return lbl
    }()
    let totalPassesLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = "Total Passes"
        return lbl
    }()
    let ballPossessionLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = "Possession"
        return lbl
    }()
    let shotsOnGoalHLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let totalShotsHLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let foulsHLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let cornersHLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let yellowCardsHLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let redCardsHLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let totalPassesHLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let ballPossHLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let shotsOnGoalALbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let totalShotsALbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let foulsALbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let cornersALbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let yellowCardsALbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let redCardsALbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let totalPassesALbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let ballPossALbl : UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14)
    lbl.setupBasicAttributes()
    return lbl
    }()
    let homeNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let awayNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    var fontSize:CGFloat?{
        didSet{
            if fontSize! > 0{
                setupFontSizes()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        let stack1 = UIStackView(arrangedSubviews: [totalShotsHLbl,shotsOnGoalHLbl,foulsHLbl,cornersHLbl,yellowCardsHLbl,redCardsHLbl,totalPassesHLbl,ballPossHLbl])
        stack1.axis = .vertical
        stack1.distribution = .equalCentering
        stack1.translatesAutoresizingMaskIntoConstraints = false
        let stack2 = UIStackView(arrangedSubviews: [totalShotsALbl,shotsOnGoalALbl,foulsALbl,cornersALbl,yellowCardsALbl,redCardsALbl,totalPassesALbl,ballPossALbl])
        stack2.axis = .vertical
        stack2.distribution = .equalCentering
        stack2.translatesAutoresizingMaskIntoConstraints = false
        let stack3 = UIStackView(arrangedSubviews: [totalShotsLbl,shotsOnGoalLbl,foulsLbl,cornersLbl,yellowCardsLbl,redCardsLbl,totalPassesLbl,ballPossessionLbl])
        stack3.axis = .vertical
        stack3.distribution = .equalCentering
        stack3.translatesAutoresizingMaskIntoConstraints = false
        addSubview(homeNameLbl)
        addSubview(awayNameLbl)
        addSubview(stack1)
        addSubview(stack2)
        addSubview(stack3)
        
        homeNameLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        homeNameLbl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        homeNameLbl.widthAnchor.constraint(equalToConstant: frame.width / 3).isActive = true
        homeNameLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        awayNameLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        awayNameLbl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        awayNameLbl.widthAnchor.constraint(equalToConstant: frame.width / 3).isActive = true
        awayNameLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        stack1.topAnchor.constraint(equalTo: homeNameLbl.bottomAnchor,constant: 10).isActive = true
        stack1.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack1.widthAnchor.constraint(equalToConstant: frame.width / 3).isActive = true
        stack1.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stack3.topAnchor.constraint(equalTo: stack1.topAnchor).isActive = true
        stack3.leadingAnchor.constraint(equalTo: stack1.trailingAnchor).isActive = true
        stack3.widthAnchor.constraint(equalToConstant: frame.width / 3).isActive = true
        stack3.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stack2.topAnchor.constraint(equalTo: stack1.topAnchor).isActive = true
        stack2.leadingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
        stack2.widthAnchor.constraint(equalToConstant: frame.width / 3).isActive = true
        stack2.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    func configureCell(onTargetH:String,onTargetA:String,totalH:String,totalA:String,foulsH:String,foulsA:String,cornersH:String,cornersA:String,yellowH:String,yellowA:String,redH:String,redA:String,passesH:String,passesA:String,hName:String,aName:String,hBP:String,aBP:String){
        shotsOnGoalHLbl.text = onTargetH
        shotsOnGoalALbl.text = onTargetA
        totalShotsHLbl.text = totalH
        totalShotsALbl.text = totalA
        foulsHLbl.text = foulsH
        foulsALbl.text = foulsA
        cornersHLbl.text = cornersH
        cornersALbl.text = cornersA
        yellowCardsHLbl.text = yellowH
        yellowCardsALbl.text = yellowA
        redCardsHLbl.text = redH
        redCardsALbl.text = redA
        totalPassesHLbl.text = passesH
        totalPassesALbl.text = passesA
        homeNameLbl.text = hName
        awayNameLbl.text = aName
        ballPossHLbl.text = hBP
        ballPossALbl.text = aBP
        
    }
    func setupFontSizes(){
        guard let fS = fontSize else{return}
        shotsOnGoalLbl.font = UIFont.systemFont(ofSize: fS)
        totalShotsLbl.font = UIFont.systemFont(ofSize: fS)
        foulsLbl.font = UIFont.systemFont(ofSize: fS)
        cornersLbl.font = UIFont.systemFont(ofSize: fS)
        yellowCardsLbl.font = UIFont.systemFont(ofSize: fS)
        redCardsLbl.font = UIFont.systemFont(ofSize: fS)
        totalPassesLbl.font = UIFont.systemFont(ofSize: fS)
        ballPossessionLbl.font = UIFont.systemFont(ofSize: fS)
        shotsOnGoalHLbl.font = UIFont.systemFont(ofSize: fS)
        totalShotsHLbl.font = UIFont.systemFont(ofSize: fS)
        foulsHLbl.font = UIFont.systemFont(ofSize: fS)
        cornersHLbl.font = UIFont.systemFont(ofSize: fS)
        yellowCardsHLbl.font = UIFont.systemFont(ofSize: fS)
        redCardsHLbl.font = UIFont.systemFont(ofSize: fS)
        totalPassesHLbl.font = UIFont.systemFont(ofSize: fS)
        ballPossHLbl.font = UIFont.systemFont(ofSize: fS)
        shotsOnGoalALbl.font = UIFont.systemFont(ofSize: fS)
        totalShotsALbl.font = UIFont.systemFont(ofSize: fS)
        foulsALbl.font = UIFont.systemFont(ofSize: fS)
        cornersALbl.font = UIFont.systemFont(ofSize: fS)
        yellowCardsALbl.font = UIFont.systemFont(ofSize: fS)
        redCardsALbl.font = UIFont.systemFont(ofSize: fS)
        totalPassesALbl.font = UIFont.systemFont(ofSize: fS)
        ballPossALbl.font = UIFont.systemFont(ofSize: fS)
        homeNameLbl.font = UIFont.systemFont(ofSize: fS)
        awayNameLbl.font = UIFont.systemFont(ofSize: fS)
    }
}
protocol playerName {
    func userDidChoose(name:String)
}
