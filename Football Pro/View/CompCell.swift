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
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let teamNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 9)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let gamesPlayedLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 9)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let goalDiffLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 9)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let pointsLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 9)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        addSubview(postitionLbl)
        addSubview(teamNameLbl)
        addSubview(gamesPlayedLbl)
        addSubview(goalDiffLbl)
        addSubview(pointsLbl)
//        addSubview(postitionLbl1)
//        addSubview(teamNameLbl1)
//        addSubview(gamesPlayedLbl1)
//        addSubview(goalDiffLbl1)
//        addSubview(pointsLbl1)
        postitionLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        postitionLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant : 20).isActive = true
        postitionLbl.widthAnchor.constraint(equalToConstant: 50).isActive = true
        postitionLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        teamNameLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        teamNameLbl.leadingAnchor.constraint(equalTo: postitionLbl.trailingAnchor,constant : 5).isActive = true
        teamNameLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        teamNameLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        gamesPlayedLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gamesPlayedLbl.leadingAnchor.constraint(equalTo: teamNameLbl.trailingAnchor,constant : 5).isActive = true
        gamesPlayedLbl.widthAnchor.constraint(equalToConstant: 50).isActive = true
        gamesPlayedLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        goalDiffLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        goalDiffLbl.leadingAnchor.constraint(equalTo: gamesPlayedLbl.trailingAnchor,constant : 5).isActive = true
        goalDiffLbl.widthAnchor.constraint(equalToConstant: 50).isActive = true
        goalDiffLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        pointsLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pointsLbl.leadingAnchor.constraint(equalTo: goalDiffLbl.trailingAnchor,constant : 5).isActive = true
        pointsLbl.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pointsLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    func configureCell(team : Team){
        self.gamesPlayedLbl.text = team.gamesPlayed
        self.goalDiffLbl.text = team.goalDifference
        self.pointsLbl.text = team.totalPoints
        self.postitionLbl.text = team.position
        self.teamNameLbl.text = team.name
    }
}
