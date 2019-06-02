//
//  MatchCell.swift
//  Football Pro
//
//  Created by tarek bahie on 5/30/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class MatchCell : UICollectionViewCell {
    let matchDate : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let vsLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let teamOneLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.numberOfLines = 0
        return lbl
    }()
    let teamTwoLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.numberOfLines = 0
        return lbl
    }()
    let CompName : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(matchDate)
        addSubview(teamOneLbl)
        addSubview(vsLbl)
        addSubview(teamTwoLbl)
        addSubview(CompName)
        
        teamOneLbl.topAnchor.constraint(equalTo: topAnchor,constant: 10).isActive = true
        teamOneLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 40).isActive = true
        teamOneLbl.widthAnchor.constraint(equalToConstant: 120).isActive = true
        teamOneLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        vsLbl.topAnchor.constraint(equalTo: teamOneLbl.topAnchor).isActive = true
        vsLbl.leadingAnchor.constraint(equalTo: teamOneLbl.trailingAnchor, constant: 10).isActive = true
        vsLbl.widthAnchor.constraint(equalToConstant: 30).isActive = true
        vsLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        teamTwoLbl.topAnchor.constraint(equalTo: vsLbl.topAnchor).isActive = true
        teamTwoLbl.leadingAnchor.constraint(equalTo: vsLbl.trailingAnchor,constant: 10).isActive = true
        teamTwoLbl.widthAnchor.constraint(equalToConstant: 120).isActive = true
        teamTwoLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        matchDate.topAnchor.constraint(equalTo: vsLbl.bottomAnchor,constant : 20).isActive = true
        matchDate.widthAnchor.constraint(equalToConstant: 200).isActive = true
        matchDate.heightAnchor.constraint(equalToConstant: 50).isActive = true
        matchDate.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        CompName.topAnchor.constraint(equalTo: matchDate.bottomAnchor,constant : 20).isActive = true
        CompName.widthAnchor.constraint(equalToConstant: 200).isActive = true
        CompName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        CompName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    func configureCell(match : Match,compName : String){
        self.teamOneLbl.text = match.homeName
        self.teamTwoLbl.text = match.awayName
        self.CompName.text = compName
        let finalDate1 = match.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY (hh:mm)"
        let fD1 = dateFormatter.string(from: finalDate1)
        self.matchDate.text = fD1
    }
}
