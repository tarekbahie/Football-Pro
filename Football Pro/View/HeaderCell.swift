//
//  HeaderCell.swift
//  Football Pro
//
//  Created by tarek bahie on 11/9/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionReusableView {

    let posLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()
    var fontSize:CGFloat?{
        didSet{
            if fontSize! > 0{
                setupFontSizes()
            }
        }
    }
    
 override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.5058823529, blue: 0.2901960784, alpha: 1)
    addSubview(posLbl)
    posLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    posLbl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    posLbl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    posLbl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true

 }
 required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

 }
    func setupFontSizes(){
        guard let fS = fontSize else{return}
        posLbl.font = UIFont.systemFont(ofSize: fS)
    }
}
