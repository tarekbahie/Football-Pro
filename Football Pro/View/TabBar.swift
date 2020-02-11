//
//  TabBar.swift
//  Football Pro
//
//  Created by tarek bahie on 5/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class TabBar : UIView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.delegate = self
        cView.dataSource = self
        cView.setupBgColor()
        cView.isScrollEnabled = false
        return cView
    }()
    var names : [String]?{
        didSet{
            collectionView.reloadData()
            let selectedIndex = IndexPath(item: 0, section: 0)
            collectionView.selectItem(at: selectedIndex, animated: false, scrollPosition: .top)
        }
    }
    weak var home : HomeVC?
    weak var mDetails : MatchDetailsVC?
    var size : CGFloat?
    var imageHeight:CGFloat?
    
    weak var calBar : CalendarBar?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        addSubview(collectionView)
        collectionView.register(TabCell.self, forCellWithReuseIdentifier: "tabId")
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabId", for: indexPath) as! TabCell
        cell.configureCell(imgName: names?[indexPath.item] ?? "", title: names?[indexPath.item] ?? "", size: imageHeight ?? 0, size2: size ?? 20 - 20)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let h = size, let d = names?.count else{
            return CGSize(width: frame.width / 5, height: 50)
            
        }
        return CGSize(width: frame.width / (CGFloat(d) + 1), height: h - 20)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let h = home{
            h.tabName = names?[indexPath.item]
        }else if let mD = mDetails{
            mD.tabName = names?[indexPath.item]
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
