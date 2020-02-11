//
//  teamEventsCell.swift
//  Football Pro
//
//  Created by tarek bahie on 11/7/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class TeamEventsCell:UICollectionViewCell{
    let timeLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.numberOfLines = 0
        return lbl
    }()
    let playerNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.numberOfLines = 0
        return lbl
    }()
    let assistNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.numberOfLines = 0
        return lbl
    }()
    let eventImg:UIImageView={
        let img = UIImageView()
        img.image = nil
        return img
    }()
    let assistImg:UIImageView={
        let img = UIImageView()
        img.image = nil
        return img
    }()
    var fontSize:CGFloat?{
        didSet{
            if fontSize! > 0{
               setupFontSizes()
            }
        }
    }
    var delegate : playerName? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        let stack = UIStackView(arrangedSubviews: [timeLbl,playerNameLbl,eventImg,assistNameLbl,assistImg])
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        
        stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        eventImg.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    func configureCell(time:String,playerN:String,type:String,detail:String,assist:String){
        timeLbl.text = time
        playerNameLbl.text = playerN
        switch type {
        case "Card":
            eventImg.image = UIImage(named: detail)
            assistNameLbl.text = detail
            assistImg.image = nil
        case "subst":
            eventImg.image = UIImage(named: "subst")
            assistNameLbl.text = detail
            assistImg.image = nil
        case "Goal":
            if detail == "Penalty"{
                eventImg.image = UIImage(named: "goal")
                assistNameLbl.text = detail
                assistImg.image = nil
            }else{
                if assist != ""{
                    eventImg.image = UIImage(named: "goal")
                    assistNameLbl.text = assist
                    assistImg.image = UIImage(named: "assist")
                }else{
                    eventImg.image = UIImage(named: "goal")
                    assistNameLbl.text = "No assist"
                    assistImg.image = nil
                }
            }
        default:
            eventImg.image = nil
            assistImg.image = nil
            assistNameLbl.text = nil
        }
        
    }
    func setupFontSizes(){
        guard let fS = fontSize else{return}
        playerNameLbl.font = UIFont.systemFont(ofSize: fS)
        timeLbl.font = UIFont.systemFont(ofSize: fS)
        assistNameLbl.font = UIFont.systemFont(ofSize: fS)
    }
    
    
}
