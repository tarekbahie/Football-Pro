//
//  TabCell.swift
//  Football Pro
//
//  Created by tarek bahie on 5/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class CalendarCell: UICollectionViewCell {
    let dayName  : UILabel = {
        let tName = UILabel()
        tName.translatesAutoresizingMaskIntoConstraints = false
        tName.font = UIFont.systemFont(ofSize: 9)
        
        tName.textAlignment = .center
        return tName
    }()
    let dayNumber : UILabel = {
        let tName = UILabel()
        tName.translatesAutoresizingMaskIntoConstraints = false
        tName.font = UIFont.systemFont(ofSize: 12)
        
        tName.textAlignment = .center
        return tName
    }()
    let monthName : UILabel = {
        let tName = UILabel()
        tName.translatesAutoresizingMaskIntoConstraints = false
        tName.font = UIFont.systemFont(ofSize: 12)
        
        tName.textAlignment = .center
        return tName
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        addSubview(dayName)
        addSubview(dayNumber)
        addSubview(monthName)
        
        monthName.topAnchor.constraint(equalTo: topAnchor,constant : 5).isActive = true
        monthName.widthAnchor.constraint(equalToConstant: 30).isActive = true
        monthName.heightAnchor.constraint(equalToConstant: 10).isActive = true
        monthName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        dayName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dayName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dayName.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dayName.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        dayNumber.centerXAnchor.constraint(equalTo: dayName.centerXAnchor).isActive = true
        dayNumber.centerYAnchor.constraint(equalTo: dayName.centerYAnchor, constant : 25).isActive = true
        dayNumber.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dayNumber.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
    }
    override var isSelected: Bool {
        didSet {
            dayNumber.textColor =  isSelected ? #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1) : #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        }
    }
    override var isHighlighted: Bool {
        didSet {
            dayNumber.textColor = isHighlighted ? #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1) : #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        }
    }
}
