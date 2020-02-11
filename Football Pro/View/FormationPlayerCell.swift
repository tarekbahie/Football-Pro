//
//  FormationPlayerCell.swift
//  Football Pro
//
//  Created by tarek bahie on 11/9/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class FormationPlayerCell:UICollectionViewCell{
    let nameLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.numberOfLines = 0
        return lbl
    }()
    let posLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.numberOfLines = 0
        return lbl
    }()
    var fontSize:CGFloat?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
    let stack = UIStackView(arrangedSubviews: [nameLbl,posLbl])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func configCell(name:String,pos:String){
        guard let fS = fontSize else{return}
        nameLbl.attributedText = NSAttributedString(string: name, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,NSAttributedString.Key.font: UIFont.systemFont(ofSize: fS)])
        posLbl.attributedText = NSAttributedString(string: pos, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fS)])
    }
}
