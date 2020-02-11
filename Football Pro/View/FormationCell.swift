//
//  FormationCell.swift
//  Football Pro
//
//  Created by tarek bahie on 11/2/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class FormationCell:UICollectionViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
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
    lazy var collectionViewHome : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .vertical
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.setupBgColor()
        cView.isScrollEnabled = true
        cView.delegate = self
        cView.dataSource = self
        return cView
    }()
    lazy var collectionViewAway : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .vertical
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.setupBgColor()
        cView.isScrollEnabled = true
        cView.delegate = self
        cView.dataSource = self
        return cView
    }()
    var subH:[String]?
    var subHPos:[String]?
    var subA:[String]?
    var subAPos:[String]?
    var keeperH:[String]?
    var keeperA:[String]?
    var defH:[String]?
    var defA:[String]?
    var midH:[String]?
    var midA:[String]?
    var attH:[String]?
    var attA:[String]?{
        didSet{
            if !attA!.isEmpty{
                collectionViewAway.reloadData()
                collectionViewHome.reloadData()
                collectionViewAway.flashScrollIndicators()
                collectionViewHome.flashScrollIndicators()
            }
        }
    }
    var fontSize:CGFloat?{
        didSet{
            if fontSize! > 0{
                setupFontSizes()
            }
        }
    }
    var homeVC:MatchDetailsVC?
    fileprivate func setupViews(){
        
        addSubview(teamOneLbl)
        addSubview(teamTwoLbl)
        addSubview(collectionViewHome)
        addSubview(collectionViewAway)
        
        teamOneLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        teamOneLbl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        teamOneLbl.widthAnchor.constraint(equalToConstant: (safeAreaLayoutGuide.layoutFrame.width / 2) - 10).isActive = true
        teamOneLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        collectionViewHome.topAnchor.constraint(equalTo: teamOneLbl.bottomAnchor).isActive = true
        collectionViewHome.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionViewHome.widthAnchor.constraint(equalToConstant: (safeAreaLayoutGuide.layoutFrame.width / 2) - 10).isActive = true
        collectionViewHome.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        teamTwoLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        teamTwoLbl.leadingAnchor.constraint(equalTo: teamOneLbl.trailingAnchor,constant: 20).isActive = true
        teamTwoLbl.widthAnchor.constraint(equalToConstant: (safeAreaLayoutGuide.layoutFrame.width / 2) - 10).isActive = true
        teamTwoLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        collectionViewAway.topAnchor.constraint(equalTo: teamTwoLbl.bottomAnchor).isActive = true
        collectionViewAway.leadingAnchor.constraint(equalTo: teamTwoLbl.leadingAnchor).isActive = true
        collectionViewAway.widthAnchor.constraint(equalToConstant: (safeAreaLayoutGuide.layoutFrame.width / 2) - 10).isActive = true
        collectionViewAway.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionViewHome.flashScrollIndicators()
        collectionViewAway.flashScrollIndicators()
        collectionViewHome.register(FormationPlayerCell.self, forCellWithReuseIdentifier: "playerCellH")
        collectionViewAway.register(FormationPlayerCell.self, forCellWithReuseIdentifier: "playerCellA")
        collectionViewHome.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellH")
        collectionViewAway.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellA")
        
        collectionViewHome.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerHCell")
        collectionViewHome.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerCellH")
        collectionViewAway.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerACell")
        collectionViewAway.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerACell")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewHome{
            guard let def = defH, let mid = midH, let att = attH,let keeper = keeperH,let sub = subH else{
                return 0
            }
            if section == 0 {
                return keeper.count
            }else if section == 1{
                return def.count
            } else if section == 2{
                return mid.count
            }else if section == 3{
                return att.count
            }else{
                return sub.count
            }
        }else{
            guard let def = defA, let mid = midA, let att = attA, let keeper = keeperA,let sub = subA else{
                return 0
            }
            if section == 0 {
                return keeper.count
            }else if section == 1{
                return def.count
            } else if section == 2{
                return mid.count
            }else if section == 3 {
                return att.count
            }else{
                return sub.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewHome{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCellH", for: indexPath) as! FormationPlayerCell
            guard let fS = fontSize else{
                return UICollectionViewCell()
            }
            cell.fontSize = fS
            guard let def = defH, let mid = midH, let att = attH,let keeper = keeperH,let sub = subH,let subPos = subHPos else{
                return UICollectionViewCell()
            }
            if indexPath.section == 0{
                cell.configCell(name: keeper[indexPath.item], pos: "G")
                return cell
            }else if indexPath.section == 1{
                cell.configCell(name: def[indexPath.item], pos: "D")
                return cell
            }else if indexPath.section == 2{
                cell.configCell(name: mid[indexPath.item], pos: "M")
                return cell
            }else if indexPath.section == 3{
                cell.configCell(name: att[indexPath.item], pos: "A")
                return cell
            }else{
                cell.configCell(name: sub[indexPath.item], pos: subPos[indexPath.item])
                return cell
            }
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCellA", for: indexPath) as! FormationPlayerCell
            guard let fS = fontSize else{
                return UICollectionViewCell()
            }
            cell.fontSize = fS
            guard let def = defA, let mid = midA, let att = attA,let keeper = keeperA,let sub = subA,let subPos = subAPos else{
                return UICollectionViewCell()
            }
            if indexPath.section == 0{
                cell.configCell(name: keeper[indexPath.item], pos: "G")
                return cell
            }else if indexPath.section == 1{
                cell.configCell(name: def[indexPath.item], pos: "D")
                return cell
            }else if indexPath.section == 2{
                cell.configCell(name: mid[indexPath.item], pos: "M")
                return cell
            }else if indexPath.section == 3{
                cell.configCell(name: att[indexPath.item], pos: "A")
                return cell
            }else{
                cell.configCell(name: sub[indexPath.item], pos: subPos[indexPath.item])
                return cell
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if collectionView == collectionViewHome{
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerHCell", for: indexPath) as! HeaderCell
                header.fontSize = fontSize ?? 14.0
                if indexPath.section == 0 {
                    header.posLbl.text = "Goalkeeper"
                    return header
                }else if indexPath.section == 1{
                    header.posLbl.text = "Defence"
                    return header
                }else if indexPath.section == 2{
                    header.posLbl.text = "Midfield"
                    return header
                }else if indexPath.section == 3{
                    header.posLbl.text = "Attack"
                    return header
                }else{
                    header.posLbl.text = "Subs"
                    return header
                }
            }else{
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerACell", for: indexPath) as! HeaderCell
                header.fontSize = fontSize ?? 14.0
                if indexPath.section == 0 {
                    header.posLbl.text = "Goalkeeper"
                    return header
                }else if indexPath.section == 1{
                    header.posLbl.text = "Defence"
                    return header
                }else if indexPath.section == 2{
                    header.posLbl.text = "Midfield"
                    return header
                }else if indexPath.section == 3{
                    header.posLbl.text = "Attack"
                    return header
                }else{
                    header.posLbl.text = "Subs"
                    return header
                }
            }
        case UICollectionView.elementKindSectionFooter:
            if collectionView == collectionViewHome{
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerCellH", for: indexPath) as! HeaderCell
                footer.fontSize = fontSize ?? 14.0
                footer.backgroundColor = .lightGray
                return footer
            }else{
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerACell", for: indexPath) as! HeaderCell
                footer.fontSize = fontSize ?? 14.0
                footer.backgroundColor = .lightGray
                return footer
            }
        default:
            assert(false, "Unexpected element kind")
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerACell", for: indexPath) as! HeaderCell
            return footer
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 30)
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            if section == 4{
                return CGSize(width: collectionView.frame.width, height: 30)
            }else{
                return CGSize(width: collectionView.frame.width, height: 0)
            }
            
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewHome{
            guard let def = defH, let mid = midH, let att = attH,let keeper = keeperH,let sub = subH else{return}
            if indexPath.section == 0{
                homeVC?.playerToShow = keeper[indexPath.item]
            }else if indexPath.section == 1{
                homeVC?.playerToShow = def[indexPath.item]
            }else if indexPath.section == 2{
                homeVC?.playerToShow = mid[indexPath.item]
            }else if indexPath.section == 3{
                homeVC?.playerToShow = att[indexPath.item]
            }else{
                homeVC?.playerToShow = sub[indexPath.item]
            }
        }else{
            guard let def = defA, let mid = midA, let att = attA,let keeper = keeperA,let sub = subA else{return}
            if indexPath.section == 0{
                homeVC?.playerToShow = keeper[indexPath.item]
            }else if indexPath.section == 1{
                homeVC?.playerToShow = def[indexPath.item]
            }else if indexPath.section == 2{
                homeVC?.playerToShow = mid[indexPath.item]
            }else if indexPath.section == 3{
                homeVC?.playerToShow = att[indexPath.item]
            }else{
                homeVC?.playerToShow = sub[indexPath.item]
            }
        }
        
    }
    
    func configCell(keeperH:[String],keeperA:[String],defH:[String],midH:[String],attH:[String],defA:[String],midA:[String],attA:[String],teamH:String,teamA:String,subH:[String],subHPos:[String],subA:[String],subAPos:[String]){
        self.subH = subH
        self.subHPos = subHPos
        self.subA = subA
        self.subAPos = subAPos
        self.keeperH = keeperH
        self.keeperA = keeperA
        self.defH = defH
        self.defA = defA
        self.midH = midH
        self.midA = midA
        self.attH = attH
        self.attA = attA
        teamOneLbl.text = teamH
        teamTwoLbl.text = teamA
    }
    func setupFontSizes(){
        guard let fS = fontSize else{return}
        teamOneLbl.font = UIFont.systemFont(ofSize: fS)
        teamTwoLbl.font = UIFont.systemFont(ofSize: fS)
    }
}
