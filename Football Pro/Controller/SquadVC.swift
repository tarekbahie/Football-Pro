//
//  SquadVC.swift
//  Football Pro
//
//  Created by tarek bahie on 6/1/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class SquadVC : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    let teamNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Team Name"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let playerNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Name"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        return lbl
    }()
    let posLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Pos"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        return lbl
    }()
    let ageLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Age"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        return lbl
    }()
    let nationalityLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Country"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        return lbl
    }()
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .vertical
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.delegate = self
        cView.dataSource = self
        cView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return cView
    }()
    
    var teamN : String?{
        didSet{
            self.teamNameLbl.text = teamN!
        }
    }
    var teamSquad : [Player]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamSquad?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "squadId", for: indexPath) as! SquadCell
        cell.configureCell(player: teamSquad?[indexPath.item] ?? Player(n: "none", p: "none", a: "none", nat: "none", g: nil))
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let player = teamSquad?[indexPath.item]
        let playerVC = PlayerVC()
        playerVC.playerToShow = player
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.navigationController?.pushViewController(playerVC, animated: true)
        }, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        setupViews()
        setupCollectionView()
    }
    func setupViews(){
        view.addSubview(teamNameLbl)
        view.addSubview(posLbl)
        view.addSubview(ageLbl)
        view.addSubview(nationalityLbl)
        view.addSubview(playerNameLbl)
        
        teamNameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        teamNameLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        teamNameLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        teamNameLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        playerNameLbl.topAnchor.constraint(equalTo: teamNameLbl.bottomAnchor,constant : 10).isActive = true
        playerNameLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        playerNameLbl.widthAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        playerNameLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        posLbl.topAnchor.constraint(equalTo: teamNameLbl.bottomAnchor,constant: 10).isActive = true
        posLbl.leadingAnchor.constraint(equalTo: playerNameLbl.trailingAnchor).isActive = true
        posLbl.widthAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        posLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        ageLbl.topAnchor.constraint(equalTo: teamNameLbl.bottomAnchor,constant: 10).isActive = true
        ageLbl.leadingAnchor.constraint(equalTo: posLbl.trailingAnchor).isActive = true
        ageLbl.widthAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        ageLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nationalityLbl.topAnchor.constraint(equalTo: teamNameLbl.bottomAnchor,constant: 10).isActive = true
        nationalityLbl.leadingAnchor.constraint(equalTo: ageLbl.trailingAnchor).isActive = true
        nationalityLbl.widthAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        nationalityLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    func setupCollectionView(){
        collectionView.register(SquadCell.self, forCellWithReuseIdentifier: "squadId")
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: playerNameLbl.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:-5).isActive = true
    }
}
