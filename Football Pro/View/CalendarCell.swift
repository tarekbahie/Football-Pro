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
        tName.setupGrayColor()
        return tName
    }()
    let dayNumber : UILabel = {
        let tName = UILabel()
        tName.translatesAutoresizingMaskIntoConstraints = false
        tName.font = UIFont.systemFont(ofSize: 12)
        tName.setupGrayColor()
        return tName
    }()
    let monthName : UILabel = {
        let tName = UILabel()
        tName.translatesAutoresizingMaskIntoConstraints = false
        tName.font = UIFont.systemFont(ofSize: 12)
        tName.setupGrayColor()
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
        let stack = UIStackView(arrangedSubviews: [monthName,dayName,dayNumber])
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 1.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 5).isActive = true
        stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 5).isActive = true
        stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -5).isActive = true
        stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -5).isActive = true
        
    }
    override var isSelected: Bool {
        didSet {
            monthName.textColor =  isSelected ? monthName.setupSelectedColor() : monthName.setupUnselectedColor()
            dayName.textColor =  isSelected ? dayName.setupSelectedColor() : dayName.setupUnselectedColor()
            dayNumber.textColor =  isSelected ? dayNumber.setupSelectedColor() : dayNumber.setupUnselectedColor()
        }
    }
    override var isHighlighted: Bool {
        didSet {
            monthName.textColor =  isSelected ? monthName.setupSelectedColor() : monthName.setupUnselectedColor()
            dayName.textColor =  isSelected ? dayName.setupSelectedColor() : dayName.setupUnselectedColor()
            dayNumber.textColor =  isSelected ? dayNumber.setupSelectedColor() : dayNumber.setupUnselectedColor()
        }
    }
}
