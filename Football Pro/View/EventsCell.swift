//
//  EventsCell.swift
//  Football Pro
//
//  Created by tarek bahie on 11/7/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class EventsCell:UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    let homeNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let awayNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.setupBasicAttributes()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
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
    let dividerLbl:UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .black
        return lbl
    }()
    var homeEvTime : [String]?
    var homeEvPlayer : [String]?
    var homeEvType : [String]?
    var homeEvDetail : [String]?
    var homeEvAssist : [String]?
    
    var awayEvTime : [String]?
    var awayEvPlayer : [String]?
    var awayEvType : [String]?
    var awayEvDetail : [String]?
    var awayEvAssist : [String]?
    var fontSize:CGFloat?{
        didSet{
            if fontSize! > 0{
                setupFontSizes()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        collectionViewHome.register(TeamEventsCell.self, forCellWithReuseIdentifier: "homeTeamEventsCell")
        collectionViewAway.register(TeamEventsCell.self, forCellWithReuseIdentifier: "awayTeamEventsCell")
        
        collectionViewHome.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        collectionViewAway.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        addSubview(homeNameLbl)
        addSubview(awayNameLbl)
        addSubview(collectionViewHome)
        addSubview(collectionViewAway)
        addSubview(dividerLbl)
        
        homeNameLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        homeNameLbl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        homeNameLbl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        homeNameLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dividerLbl.topAnchor.constraint(equalTo: collectionViewHome.bottomAnchor).isActive = true
        dividerLbl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        dividerLbl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        dividerLbl.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        awayNameLbl.topAnchor.constraint(equalTo: dividerLbl.bottomAnchor).isActive = true
        awayNameLbl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        awayNameLbl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        awayNameLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        collectionViewHome.topAnchor.constraint(equalTo: homeNameLbl.bottomAnchor).isActive = true
        collectionViewHome.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionViewHome.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionViewHome.heightAnchor.constraint(equalToConstant: (safeAreaLayoutGuide.layoutFrame.height / 2) - 35).isActive = true
        
        collectionViewAway.topAnchor.constraint(equalTo: awayNameLbl.bottomAnchor).isActive = true
        collectionViewAway.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionViewAway.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionViewAway.heightAnchor.constraint(equalToConstant: (safeAreaLayoutGuide.layoutFrame.height / 2) - 35).isActive = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewHome{
            return homeEvTime?.count ?? 0
        }else{
            return awayEvTime?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewHome{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeTeamEventsCell", for: indexPath) as! TeamEventsCell
            guard let fS = fontSize else{
                return UICollectionViewCell()
            }
            cell.fontSize = fS
            cell.configureCell(time: homeEvTime?[indexPath.item] ?? "", playerN: homeEvPlayer?[indexPath.item] ?? "", type: homeEvType?[indexPath.item] ?? "", detail: homeEvDetail?[indexPath.item] ?? "", assist: homeEvAssist?[indexPath.item] ?? "")
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "awayTeamEventsCell", for: indexPath) as! TeamEventsCell
            guard let fS = fontSize else{
                return UICollectionViewCell()
            }
            cell.fontSize = fS
            cell.configureCell(time: awayEvTime?[indexPath.item] ?? "", playerN: awayEvPlayer?[indexPath.item] ?? "", type: awayEvType?[indexPath.item] ?? "", detail: awayEvDetail?[indexPath.item] ?? "", assist: awayEvAssist?[indexPath.item] ?? "")
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewHome{
            return CGSize(width: collectionViewHome.frame.width, height: 40)
        }else{
            return CGSize(width: collectionViewAway.frame.width, height: 40)
        }
    }
    
    func configureCell(homeTime:[String],homePlayer:[String],homeType:[String],homeDetail:[String],homeAssist:[String],awayTime:[String],awayPlayer:[String],awayType:[String],awayDetail:[String],awayAssist:[String],hName:String,aName:String){
        homeNameLbl.text = hName
        awayNameLbl.text = aName
        self.homeEvTime = homeTime
        self.homeEvPlayer = homePlayer
        self.homeEvType = homeType
        self.homeEvDetail = homeDetail
        self.homeEvAssist = homeAssist
        
        self.awayEvTime = awayTime
        self.awayEvPlayer = awayPlayer
        self.awayEvType = awayType
        self.awayEvDetail = awayDetail
        self.awayEvAssist = awayAssist
        collectionViewHome.reloadData()
        collectionViewAway.reloadData()
        collectionViewHome.flashScrollIndicators()
        collectionViewAway.flashScrollIndicators()
        
    }
    func setupFontSizes(){
        guard let fS = fontSize else{return}
        homeNameLbl.font = UIFont.systemFont(ofSize: fS)
        awayNameLbl.font = UIFont.systemFont(ofSize: fS)
    }
    
}
