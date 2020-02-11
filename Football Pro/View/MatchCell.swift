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
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let vsLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = "VS"
        return lbl
    }()
    let ftLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.text = "FT"
        return lbl
    }()
    let teamOneLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let teamTwoLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let CompName : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.setupBasicAttributes()
        return lbl
    }()
    let homeTeamScore:UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        return lbl
    }()
    let awayTeamScore:UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        return lbl
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
    fileprivate func setupStackConstraints(_ stack: UIStackView) {
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupViews() {
        let stack1 = UIStackView(arrangedSubviews: [teamOneLbl,vsLbl,teamTwoLbl])
        stack1.axis = .horizontal
        stack1.distribution = .equalSpacing
        let stack2 = UIStackView(arrangedSubviews: [homeTeamScore,ftLbl,awayTeamScore])
        stack2.axis = .horizontal
        stack2.distribution = .equalSpacing
        let stack = UIStackView(arrangedSubviews: [stack1,stack2,matchDate,CompName])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        setupStackConstraints(stack)
        teamOneLbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
        teamTwoLbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    fileprivate func setupCellFont(_ fSize: CGFloat) {
        matchDate.font = UIFont.systemFont(ofSize: fSize)
        vsLbl.font = UIFont.systemFont(ofSize: fSize)
        teamOneLbl.font = UIFont.systemFont(ofSize: fSize)
        teamTwoLbl.font = UIFont.systemFont(ofSize: fSize)
        CompName.font = UIFont.systemFont(ofSize: fSize)
        homeTeamScore.font = UIFont.systemFont(ofSize: fSize)
        awayTeamScore.font = UIFont.systemFont(ofSize: fSize)
        ftLbl.font = UIFont.systemFont(ofSize: fSize)
        teamOneLbl.adjustsFontSizeToFitWidth = true
        teamTwoLbl.adjustsFontSizeToFitWidth = true
    }
    
    fileprivate func setupDate(_ match: Match) {
        let finalDate1 = match.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let fD1 = dateFormatter.string(from: finalDate1)
        if match.status == "FINISHED"{
            self.matchDate.text = "Finished"
            homeTeamScore.text = match.hScore
            awayTeamScore.text = match.aScore
        }else{
            self.matchDate.text = fD1
            homeTeamScore.text = nil
            awayTeamScore.text = nil
            ftLbl.text = nil
        }
    }
    
    fileprivate func setupCellTxt(_ match: Match) {
        self.teamOneLbl.text = match.homeName
        self.teamTwoLbl.text = match.awayName
        self.CompName.text = match.compName
    }
    
    func configureCell(match : Match,fSize:CGFloat){
        setupCellFont(fSize)
        setupCellTxt(match)
        setupDate(match)
    }
}
