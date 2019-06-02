//
//  LiveMatchCell.swift
//  Football Pro
//
//  Created by tarek bahie on 5/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class LiveMatchCell : UICollectionViewCell {
    let compLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let teamOnelbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let teamTwoLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let statusLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let halfHomeLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let halfAwayLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let fullHomeLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let fullAwayLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let refreeLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    let matchdayLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    let vsLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.text = "VS"
        return lbl
    }()
    let htLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.text = "HT"
        return lbl
    }()
    let ftLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.text = "FT"
        return lbl
    }()
    let countLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.numberOfLines = 0
        lbl.text = "There are currently no live matches"
        return lbl
    }()
    var count : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
            addSubview(compLbl)
            addSubview(teamOnelbl)
            addSubview(teamTwoLbl)
            addSubview(statusLbl)
            addSubview(matchdayLbl)
            addSubview(halfHomeLbl)
            addSubview(halfAwayLbl)
            addSubview(fullHomeLbl)
            addSubview(fullAwayLbl)
            addSubview(refreeLbl)
            addSubview(vsLbl)
            addSubview(htLbl)
            addSubview(ftLbl)
            
            makeConstraints(view: compLbl, top: 5, leading: nil, trailing: nil, bottom: nil, height: 20, width: 200, centerX: 0, centerY: nil)
            makeConstraints(view: teamOnelbl, view2: compLbl, top: 10, topRelation: "below", leading: 20, leadRelation: nil, trailing: nil, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 50, width: 100, centerX: nil, centerY: nil)
            makeConstraints(view: vsLbl, view2: compLbl, top: 10, topRelation: "below", leading: nil, leadRelation: nil, trailing: nil, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 30, width: 40, centerX: 0, centerY: nil)
            makeConstraints(view: teamTwoLbl, view2: compLbl, top: 10, topRelation: "below", leading: nil, leadRelation: nil, trailing: -30, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 50, width: 100, centerX: nil, centerY: nil)
            makeConstraints(view: htLbl, view2: vsLbl, top: 10, topRelation: "below", leading: nil, leadRelation: nil, trailing: nil, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 30, width: 40, centerX: 0, centerY: nil)
            makeConstraints(view: ftLbl, view2: htLbl, top: 10, topRelation: "below", leading: nil, leadRelation: nil, trailing: nil, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 30, width: 40, centerX: 0, centerY: nil)
            makeConstraints(view: halfHomeLbl, view2: vsLbl, top: 10, topRelation: "below", leading: 20, leadRelation: nil, trailing: nil, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 30, width: 100, centerX: nil, centerY: nil)
            makeConstraints(view: halfAwayLbl, view2: vsLbl, top: 10, topRelation: "below", leading: nil, leadRelation: nil, trailing: -30, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 30, width: 100, centerX: nil, centerY: nil)
            makeConstraints(view: fullHomeLbl, view2: htLbl, top: 10, topRelation: "below", leading: 20, leadRelation: nil, trailing: nil, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 30, width: 100, centerX: nil, centerY: nil)
            makeConstraints(view: fullAwayLbl, view2: htLbl, top: 10, topRelation: "below", leading: nil, leadRelation: nil, trailing: -30, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 30, width: 100, centerX: nil, centerY: nil)
            makeConstraints(view: matchdayLbl, view2: ftLbl, top: 10, topRelation: "below", leading: nil, leadRelation: nil, trailing: nil, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 20, width: 200, centerX: 0, centerY: nil)
            makeConstraints(view: statusLbl, view2: matchdayLbl, top: 10, topRelation: "below", leading: nil, leadRelation: nil, trailing: nil, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 20, width: 200, centerX: 0, centerY: nil)
            makeConstraints(view: refreeLbl, view2: statusLbl, top: 10, topRelation: "below", leading: nil, leadRelation: nil, trailing: nil, trailRelation: nil, bottom: nil, bottomRelation: nil, height: 20, width: 200, centerX: 0, centerY: nil)
        
//            addSubview(countLbl)
        
    }
    func makeConstraints(view : UIView,view2 : UIView? = nil, top : CGFloat? = nil,topRelation : String? = nil,leading : CGFloat? = nil,leadRelation : String? = nil,trailing : CGFloat? = nil,trailRelation : String? = nil,bottom : CGFloat? = nil,bottomRelation : String? = nil,height : CGFloat? = nil,width : CGFloat? = nil,centerX : CGFloat? = nil,centerY : CGFloat? = nil) {
        if let v2 = view2{
            if let t = top{
                if topRelation == "below"{
                    view.topAnchor.constraint(equalTo: v2.bottomAnchor,constant : t).isActive = true
                } else if topRelation == "above"{
                    view.topAnchor.constraint(equalTo: v2.topAnchor,constant : t).isActive = true
                } else{
                    view.topAnchor.constraint(equalTo: topAnchor,constant : t).isActive = true
                }
            }
            if let l = leading{
                if leadRelation == "before"{
                    view.leadingAnchor.constraint(equalTo: v2.leadingAnchor,constant : l).isActive = true
                } else if leadRelation == "after"{
                    view.leadingAnchor.constraint(equalTo: v2.trailingAnchor,constant : l).isActive = true
                } else {
                    view.leadingAnchor.constraint(equalTo: leadingAnchor,constant : l).isActive = true
                }
            }
            if let tr = trailing{
                if trailRelation == "after"{
                    view.trailingAnchor.constraint(equalTo: v2.trailingAnchor,constant : tr).isActive = true
                } else if trailRelation == "before"{
                    view.trailingAnchor.constraint(equalTo: v2.leadingAnchor,constant : tr).isActive = true
                } else {
                    view.trailingAnchor.constraint(equalTo: trailingAnchor,constant : tr).isActive = true
                }
            }
            if let b = bottom{
                if bottomRelation == "below"{
                    view.bottomAnchor.constraint(equalTo: v2.bottomAnchor,constant : b).isActive = true
                }else if bottomRelation == "above"{
                    view.bottomAnchor.constraint(equalTo: v2.topAnchor,constant : b).isActive = true
                }else {
                    view.bottomAnchor.constraint(equalTo: bottomAnchor,constant : b).isActive = true
                }
            }
            if let h = height{
                view.heightAnchor.constraint(equalToConstant: h).isActive = true
            }
            if let w = width{
                view.widthAnchor.constraint(equalToConstant: w).isActive = true
            }
            if let cX = centerX{
                view.centerXAnchor.constraint(equalTo: v2.centerXAnchor,constant : cX).isActive = true
            }
            if let cY = centerY{
                view.centerYAnchor.constraint(equalTo: v2.centerYAnchor,constant: cY).isActive = true
            }
        } else{
            if let t = top{
                view.topAnchor.constraint(equalTo: topAnchor,constant : t).isActive = true
            }
            if let l = leading{
                view.leadingAnchor.constraint(equalTo: leadingAnchor,constant : l).isActive = true
            }
            if let tr = trailing{
                view.trailingAnchor.constraint(equalTo: trailingAnchor,constant : tr).isActive = true
            }
            if let b = bottom{
                view.bottomAnchor.constraint(equalTo: bottomAnchor,constant : b).isActive = true
            }
            if let h = height{
                view.heightAnchor.constraint(equalToConstant: h).isActive = true
            }
            if let w = width{
                view.widthAnchor.constraint(equalToConstant: w).isActive = true
            }
            if let cX = centerX{
                view.centerXAnchor.constraint(equalTo: centerXAnchor,constant : cX).isActive = true
            }
            if let cY = centerY{
                view.centerYAnchor.constraint(equalTo: centerYAnchor,constant: cY).isActive = true
            }
        }
    }
    func configureCell(match : LiveMatch){
        self.compLbl.text = match.competition
        self.teamOnelbl.text = match.homeName
        self.teamTwoLbl.text = match.awayName
        self.statusLbl.text = match.status
        self.halfHomeLbl.text = "\(match.halfTimeHome)"
        self.halfAwayLbl.text = "\(match.halfTimeAway)"
        self.fullHomeLbl.text = "\(match.fullTimeHome)"
        self.fullAwayLbl.text = "\(match.fullTimeAway)"
        self.refreeLbl.text = match.refreeName
        self.matchdayLbl.text = "Matchday : \(match.matchDay)"
    }
}
