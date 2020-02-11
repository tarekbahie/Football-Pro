//
//  SquadVC.swift
//  Football Pro
//
//  Created by tarek bahie on 6/1/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class SquadVC : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    let playerNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Name"
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.setupBasicAttributes()
        lbl.setupBgColor()
        return lbl
    }()
    let posLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Pos"
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.setupBasicAttributes()
        lbl.setupBgColor()
        return lbl
    }()
    let ageLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Age"
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.setupBasicAttributes()
        lbl.setupBgColor()
        return lbl
    }()
    let nationalityLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Country"
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.setupBasicAttributes()
        lbl.setupBgColor()
        return lbl
    }()
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .vertical
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.delegate = self
        cView.dataSource = self
        cView.setupBgColor()
        return cView
    }()
    
    var teamN : String?
    var teamSquad : [Player]?{
        didSet{
            collectionView.reloadData()
        }
    }
    var fontSize:CGFloat?{
        didSet{
            if let fS = fontSize{
                setupFonts(size: fS)
            }
        }
    }
    fileprivate func setupFonts(size:CGFloat){
        playerNameLbl.font = UIFont.systemFont(ofSize: size)
        posLbl.font = UIFont.systemFont(ofSize: size)
        ageLbl.font = UIFont.systemFont(ofSize: size)
        nationalityLbl.font = UIFont.systemFont(ofSize: size)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamSquad?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "squadId", for: indexPath) as! SquadCell
        cell.configureCell(player: teamSquad?[indexPath.item] ?? Player(n: "none", p: "none", a: "none", nat: "none", g: nil), fSize: fontSize!)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showPlayer(indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    fileprivate func showPlayer(_ indexPath: IndexPath) {
        let player = teamSquad?[indexPath.item]
        let playerVC = PlayerVC()
        playerVC.playerToShow = player?.name
        playerVC.fontSize = self.fontSize!
        if player != nil{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.navigationController?.pushViewController(playerVC, animated: true)
            }, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setupBgColor()
        setupViews()
        setupCollectionView()
    }
    fileprivate func setupViews(){
        view.addSubview(posLbl)
        view.addSubview(ageLbl)
        view.addSubview(nationalityLbl)
        view.addSubview(playerNameLbl)
        
        playerNameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        playerNameLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        playerNameLbl.widthAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        playerNameLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        posLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        posLbl.leadingAnchor.constraint(equalTo: playerNameLbl.trailingAnchor).isActive = true
        posLbl.widthAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        posLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        ageLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        ageLbl.leadingAnchor.constraint(equalTo: posLbl.trailingAnchor).isActive = true
        ageLbl.widthAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        ageLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nationalityLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nationalityLbl.leadingAnchor.constraint(equalTo: ageLbl.trailingAnchor).isActive = true
        nationalityLbl.widthAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        nationalityLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    fileprivate func setupCollectionView(){
        collectionView.register(SquadCell.self, forCellWithReuseIdentifier: "squadId")
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: playerNameLbl.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:-5).isActive = true
    }
}
