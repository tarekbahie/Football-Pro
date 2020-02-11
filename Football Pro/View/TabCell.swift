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
        tImage.setupTabImageTint()
        tImage.contentMode = .scaleAspectFill
        return tImage
    }()
    let tabName : UILabel = {
        let tName = UILabel()
        tName.translatesAutoresizingMaskIntoConstraints = false
        tName.setupGrayColor()
        return tName
    }()
    var imgHeightConst:NSLayoutConstraint?
    var imgWidthConst:NSLayoutConstraint?
    var lblHeightConst:NSLayoutConstraint?
    var lblWidthConst:NSLayoutConstraint?
    var lblCenterYConst:NSLayoutConstraint?
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
        imgWidthConst = tabImage.widthAnchor.constraint(equalToConstant: 0)
        imgWidthConst?.isActive = true
        imgHeightConst = tabImage.heightAnchor.constraint(equalToConstant: 0)
        imgHeightConst?.isActive = true
        
        tabName.centerXAnchor.constraint(equalTo: tabImage.centerXAnchor).isActive = true
        lblCenterYConst = tabName.centerYAnchor.constraint(equalTo: tabImage.centerYAnchor, constant : 0)
        lblCenterYConst?.isActive = true
        lblWidthConst = tabName.widthAnchor.constraint(equalToConstant: 0)
        lblWidthConst?.isActive = true
        lblHeightConst = tabName.heightAnchor.constraint(equalToConstant: 0)
        lblHeightConst?.isActive = true
    }
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                if #available(iOS 13.0, *){
                    self.tabImage.tintColor =  self.isSelected ? UIColor.systemIndigo : UIColor.systemGray2
                    self.tabName.textColor = self.isSelected ? UIColor.systemIndigo : UIColor.systemGray2
                }else{
                    self.tabImage.tintColor =  self.isSelected ? #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1) : #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
                    self.tabName.textColor = self.isSelected ? #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1) : #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
                }
            }, completion: nil)
            
        }
    }
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                if #available(iOS 13.0, *){
                    self.tabImage.tintColor =  self.isHighlighted ? UIColor.systemIndigo : UIColor.systemGray2
                    self.tabName.textColor = self.isHighlighted ? UIColor.systemIndigo : UIColor.systemGray2
                }else{
                    self.tabImage.tintColor =  self.isHighlighted ? #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1) : #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
                    self.tabName.textColor = self.isHighlighted ? #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1) : #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
                }
            }, completion: nil)
        }
    }
    func configureCell(imgName:String,title:String,size:CGFloat,size2:CGFloat){
        tabImage.image = UIImage(named: imgName)?.withRenderingMode(.alwaysTemplate)
        tabName.text = title
        imgHeightConst?.constant = size
        imgWidthConst?.constant = size
        lblHeightConst?.constant = size / 3
        lblWidthConst?.constant = size
        tabName.font = UIFont.systemFont(ofSize: size / 3)
        if size2 > 100{
        lblCenterYConst?.constant = size2 / 3
        }else{
        lblCenterYConst?.constant = size2 / 3
        }
    }
}
