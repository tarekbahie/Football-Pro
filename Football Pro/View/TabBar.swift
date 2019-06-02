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
        cView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cView.isScrollEnabled = false
        return cView
    }()
    let names = ["home","live","all","club"]
    var home : HomeVC?
    
    var calBar : CalendarBar?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        let selectedIndex = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndex, animated: false, scrollPosition: .top)
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabId", for: indexPath) as! TabCell
        cell.tabImage.image = UIImage(named: names[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tabName.text = names[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 5, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        home?.tabName = names[indexPath.item]
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
