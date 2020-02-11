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
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.setupBasicAttributes()
        lbl.text = nil
        return lbl
    }()
    let teamOnelbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = nil
        return lbl
    }()
    let teamTwoLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = nil
        return lbl
    }()
    let statusLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = nil
        return lbl
    }()
    let fullHomeLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = nil
        return lbl
    }()
    let fullAwayLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = nil
        return lbl
    }()
    let refreeLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.text = nil
        return lbl
    }()
    let matchdayLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = nil
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
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.text = nil
        return lbl
    }()
    let countLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.text = "There are currently no live matches"
        return lbl
    }()
    var count : Int = 0
    
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
    func setupViews(){
            let stack1 = UIStackView(arrangedSubviews: [teamOnelbl,vsLbl,teamTwoLbl])
        stack1.axis = .horizontal
        stack1.distribution = .equalCentering
        let stack3 = UIStackView(arrangedSubviews: [fullHomeLbl,ftLbl,fullAwayLbl])
        stack3.axis = .horizontal
        stack3.distribution = .equalCentering
        let stack = UIStackView(arrangedSubviews: [compLbl,stack1,stack3,matchdayLbl,refreeLbl])
        stack.distribution = .equalCentering
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        fullHomeLbl.centerXAnchor.constraint(equalTo: teamOnelbl.centerXAnchor).isActive = true
        fullAwayLbl.centerXAnchor.constraint(equalTo: teamTwoLbl.centerXAnchor).isActive = true
        ftLbl.centerXAnchor.constraint(equalTo: vsLbl.centerXAnchor).isActive = true
        
    }
    fileprivate func setupCellFont(_ fSize: CGFloat) {
        compLbl.font = UIFont.systemFont(ofSize: fSize)
        teamOnelbl.font = UIFont.systemFont(ofSize: fSize)
        teamTwoLbl.font = UIFont.systemFont(ofSize: fSize)
        statusLbl.font = UIFont.systemFont(ofSize: fSize)
        fullHomeLbl.font = UIFont.systemFont(ofSize: fSize)
        fullAwayLbl.font = UIFont.systemFont(ofSize: fSize)
        refreeLbl.font = UIFont.systemFont(ofSize: fSize)
        matchdayLbl.font = UIFont.systemFont(ofSize: fSize)
        vsLbl.font = UIFont.systemFont(ofSize: fSize)
        ftLbl.font = UIFont.systemFont(ofSize: fSize)
        teamOnelbl.adjustsFontSizeToFitWidth = true
        teamTwoLbl.adjustsFontSizeToFitWidth = true
    }
    
    fileprivate func initializeCellTxt() {
        compLbl.text = nil
        teamOnelbl.text = nil
        teamTwoLbl.text = nil
        statusLbl.text = nil
        fullHomeLbl.text = nil
        fullAwayLbl.text = nil
        refreeLbl.text = nil
        matchdayLbl.text = nil
        ftLbl.text = nil
    }
    fileprivate func setupRemainingTimeToDate(_ myDate: Date) {
        fullAwayLbl.isHidden = true
        fullHomeLbl.isHidden = true
        let components = Calendar.current.dateComponents([.day,.hour,.minute], from: Date(), to: myDate)
        if let day = components.day,let hour = components.hour,let min = components.minute{
            var dText = ""
            var hText = ""
            var mText = ""
            if day == 0{
                dText = ""
            }else if day == 1{
                dText = "Day:"
            }else{
                dText = "Days:"
            }
            if hour == 0{
                hText = ""
            }else if hour == 1{
                hText = "Hr:"
            }else{
                hText = "Hrs:"
            }
            if min == 0{
                mText = ""
            }else if min == 1{
                mText = "Min"
            }else{
                mText = "Mins"
            }
            ftLbl.text = "\(day) \(dText)\(hour) \(hText)\(min) \(mText)"
        }else{
            ftLbl.text = ""
        }
    }
    fileprivate func setupDates(match:LiveMatch){
        var d = ""
        if let finalDate1 = match.date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let myDate = dateFormatter.date(from: finalDate1)!
        let now = Date()
            if now < myDate{
                setupRemainingTimeToDate(myDate)
                
            }else{
                fullAwayLbl.isHidden = false
                fullHomeLbl.isHidden = false
                ftLbl.text = "Score"
            }

        dateFormatter.dateFormat = "dd/MM/yyyy-HH:mm"
        let dateAsString = dateFormatter.string(from: myDate)
            d = dateAsString
        }else{
            fullAwayLbl.isHidden = false
            fullHomeLbl.isHidden = false
            ftLbl.text = "Score"
        }
        if match.competition != nil {
            self.compLbl.text = match.competition
        }else{
            self.compLbl.text = d
        }
    }
    func configureCell(match : LiveMatch,fSize:CGFloat){
        setupCellFont(fSize)
        initializeCellTxt()
        setupDates(match: match)
        self.teamOnelbl.text = match.homeName
        self.teamTwoLbl.text = match.awayName
        self.statusLbl.text = match.status
        self.fullHomeLbl.text = "\(match.fullTimeHome)"
        self.fullAwayLbl.text = "\(match.fullTimeAway)"
        self.refreeLbl.text = match.refreeName
        self.matchdayLbl.text = "Matchday : \(match.matchDay)"
        
    }
}
