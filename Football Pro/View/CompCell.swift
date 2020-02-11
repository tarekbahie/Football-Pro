//
//  CompCell.swift
//  Football Pro
//
//  Created by tarek bahie on 5/31/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class CompCell : UICollectionViewCell{
    let postitionLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 9)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let teamNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 9)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let gamesPlayedLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 9)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let goalDiffLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 9)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let pointsLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 9)
        lbl.setupBasicAttributes()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupBackGroundColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func addCellSubviews() {
        addSubview(postitionLbl)
        addSubview(teamNameLbl)
        addSubview(gamesPlayedLbl)
        addSubview(goalDiffLbl)
        addSubview(pointsLbl)
    }
    
    fileprivate func setupPosLblConstraints(_ width: CGFloat) {
        postitionLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        postitionLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant : 5).isActive = true
        postitionLbl.widthAnchor.constraint(equalToConstant: width/10).isActive = true
        postitionLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    fileprivate func setupTeamNameLblConstraints(_ width: CGFloat) {
        teamNameLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        teamNameLbl.leadingAnchor.constraint(equalTo: postitionLbl.trailingAnchor,constant : 5).isActive = true
        teamNameLbl.widthAnchor.constraint(equalToConstant: (width * 2)/5).isActive = true
        teamNameLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    fileprivate func setupGamesPlydLblConstraints(_ width: CGFloat) {
        gamesPlayedLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        gamesPlayedLbl.leadingAnchor.constraint(equalTo: teamNameLbl.trailingAnchor,constant : 5).isActive = true
        gamesPlayedLbl.widthAnchor.constraint(equalToConstant: width/5).isActive = true
        gamesPlayedLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    fileprivate func setupGoalDiffLblConstraints(_ width: CGFloat) {
        goalDiffLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        goalDiffLbl.leadingAnchor.constraint(equalTo: gamesPlayedLbl.trailingAnchor,constant : 5).isActive = true
        goalDiffLbl.widthAnchor.constraint(equalToConstant: width/5).isActive = true
        goalDiffLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    fileprivate func setupPointsLblConstraints(_ width: CGFloat) {
        pointsLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pointsLbl.leadingAnchor.constraint(equalTo: goalDiffLbl.trailingAnchor,constant : 5).isActive = true
        pointsLbl.widthAnchor.constraint(equalToConstant: width/10).isActive = true
        pointsLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupViews(){
        let width = UIScreen.main.bounds.width - 25
        addCellSubviews()
        setupPosLblConstraints(width)
        setupTeamNameLblConstraints(width)
        setupGamesPlydLblConstraints(width)
        setupGoalDiffLblConstraints(width)
        setupPointsLblConstraints(width)
    }
    fileprivate func setupCellTxt(_ team: Team) {
        gamesPlayedLbl.text = team.gamesPlayed
        goalDiffLbl.text = team.goalDifference
        pointsLbl.text = team.totalPoints
        postitionLbl.text = team.position
        teamNameLbl.text = team.name
    }
    
    fileprivate func setupCellFont(_ fSize: CGFloat) {
        gamesPlayedLbl.font = UIFont.systemFont(ofSize: fSize)
        goalDiffLbl.font = UIFont.systemFont(ofSize: fSize)
        pointsLbl.font = UIFont.systemFont(ofSize: fSize)
        postitionLbl.font = UIFont.systemFont(ofSize: fSize)
        teamNameLbl.font = UIFont.systemFont(ofSize: fSize)
    }
    
    func configureCell(team : Team,fSize:CGFloat){
        setupCellTxt(team)
        setupCellFont(fSize)
    }
}
