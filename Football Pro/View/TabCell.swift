//
//  TabCell.swift
//  Football Pro
//
//  Created by tarek bahie on 5/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class TabCell: UICollectionViewCell {
    let tabImage : UIImageView = {
        let tImage = UIImageView()
        tImage.translatesAutoresizingMaskIntoConstraints = false
        tImage.tintColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        return tImage
    }()
    let tabName : UILabel = {
        let tName = UILabel()
        tName.translatesAutoresizingMaskIntoConstraints = false
        tName.font = UIFont.systemFont(ofSize: 11)
        tName.textColor = .lightGray
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
        addSubview(tabName)
        addSubview(tabImage)
        
        tabImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tabImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tabImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tabImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tabName.centerXAnchor.constraint(equalTo: tabImage.centerXAnchor).isActive = true
        tabName.centerYAnchor.constraint(equalTo: tabImage.centerYAnchor, constant : 25).isActive = true
        tabName.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tabName.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
    }
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                self.tabImage.tintColor =  self.isSelected ? #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1) : #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
                self.tabName.textColor = self.isSelected ? #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1) : #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
            }, completion: nil)
        }
    }
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                self.tabImage.tintColor = self.isHighlighted ? #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1) : #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
                self.tabName.textColor = self.isHighlighted ? #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1) : #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
            }, completion: nil)
            
        }
    }
}
