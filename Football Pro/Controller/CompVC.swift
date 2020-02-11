//
//  CompVC.swift
//  Football Pro
//
//  Created by tarek bahie on 5/31/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
import SVProgressHUD

class CompVC : UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.delegate = self
        cView.dataSource = self
        cView.setupBgColor()
        
        return cView
    }()
    
    let postitionLbl1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.setupBasicAttributes()
        lbl.text = "Pos"
        return lbl
    }()
    let teamNameLbl1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.setupBasicAttributes()
        lbl.text = "Name"
        return lbl
    }()
    let gamesPlayedLbl1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.setupBasicAttributes()
        lbl.text = "Played"
        return lbl
    }()
    let goalDiffLbl1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.setupBasicAttributes()
        lbl.text = "+ / -"
        return lbl
    }()
    let pointsLbl1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.setupBasicAttributes()
        lbl.text = "Pts"
        return lbl
    }()
    var league : String?{
        didSet{
           getStandings(i: league!)
        }
    }
    let noConnectionLbl : UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    var teams = [Team](){
        didSet{
            collectionView.reloadData()
        }
    }
    var canAddTeamToFavs : Bool = false
    var fontSize:CGFloat?{
        didSet{
            if let fS = fontSize{
                setupFonts(size: fS)
            }
        }
    }
    var posHeighConst:NSLayoutConstraint?
    var teamNameHeightConst:NSLayoutConstraint?
    var gamesPlayedHeightConst:NSLayoutConstraint?
    var diffHeighConst:NSLayoutConstraint?
    var pointsHeighConst:NSLayoutConstraint?
    
    
    fileprivate func setupFonts(size:CGFloat){
        postitionLbl1.font = UIFont.systemFont(ofSize: size)
        teamNameLbl1.font = UIFont.systemFont(ofSize: size)
        gamesPlayedLbl1.font = UIFont.systemFont(ofSize: size)
        goalDiffLbl1.font = UIFont.systemFont(ofSize: size)
        pointsLbl1.font = UIFont.systemFont(ofSize: size)
        
    }
    fileprivate func getStandings(i : String){
        SVProgressHUD.show()
        DataService.instance.getLeagueStandingsWith(id: i) { (returnedTeam, limit,conn,connDesc ) in
            if let _ = conn, let desc = connDesc{
                self.setupNoConnectionView(description: desc)
            }else{
                if limit{
                    self.teams = returnedTeam
                    SVProgressHUD.dismiss()
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now()+10, execute: {
                        self.getStandings(i: i)
                    })
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        collectionView.register(CompCell.self, forCellWithReuseIdentifier: "compId")
        view.setupBgColor()
    }
    fileprivate func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(postitionLbl1)
        view.addSubview(teamNameLbl1)
        view.addSubview(gamesPlayedLbl1)
        view.addSubview(goalDiffLbl1)
        view.addSubview(pointsLbl1)
    }
    
    fileprivate func setupPosLblConstraints(_ width: CGFloat) {
        postitionLbl1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        postitionLbl1.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant : 5).isActive = true
        postitionLbl1.widthAnchor.constraint(equalToConstant: width/10).isActive = true
        postitionLbl1.heightAnchor.constraint(equalToConstant: fontSize! + 33).isActive = true
    }
    
    fileprivate func setupTeamNameLblConstraints(_ width: CGFloat) {
        teamNameLbl1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        teamNameLbl1.leadingAnchor.constraint(equalTo: postitionLbl1.trailingAnchor,constant : 5).isActive = true
        teamNameLbl1.widthAnchor.constraint(equalToConstant: (width * 2)/5).isActive = true
        teamNameLbl1.heightAnchor.constraint(equalToConstant: fontSize! + 33).isActive = true
    }
    
    fileprivate func setupGamesPlayedLblConstraints(_ width: CGFloat) {
        gamesPlayedLbl1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gamesPlayedLbl1.leadingAnchor.constraint(equalTo: teamNameLbl1.trailingAnchor,constant : 5).isActive = true
        gamesPlayedLbl1.widthAnchor.constraint(equalToConstant: width/5).isActive = true
        gamesPlayedLbl1.heightAnchor.constraint(equalToConstant: fontSize! + 33).isActive = true
    }
    
    fileprivate func setupGoalDiffLblConstraints(_ width: CGFloat) {
        goalDiffLbl1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        goalDiffLbl1.leadingAnchor.constraint(equalTo: gamesPlayedLbl1.trailingAnchor,constant : 5).isActive = true
        goalDiffLbl1.widthAnchor.constraint(equalToConstant: width/5).isActive = true
        goalDiffLbl1.heightAnchor.constraint(equalToConstant: fontSize! + 33).isActive = true
    }
    
    fileprivate func setupPointsLblConstraints(_ width: CGFloat) {
        pointsLbl1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pointsLbl1.leadingAnchor.constraint(equalTo: goalDiffLbl1.trailingAnchor,constant : 5).isActive = true
        pointsLbl1.widthAnchor.constraint(equalToConstant: width/10).isActive = true
        pointsLbl1.heightAnchor.constraint(equalToConstant: fontSize! + 33).isActive = true
    }
    
    fileprivate func setupColViewConstraints() {
        collectionView.topAnchor.constraint(equalTo: postitionLbl1.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    fileprivate func setupViews(){
        let width = UIScreen.main.bounds.width - 25
        addSubviews()
        setupPosLblConstraints(width)
        setupTeamNameLblConstraints(width)
        setupGamesPlayedLblConstraints(width)
        setupGoalDiffLblConstraints(width)
        setupPointsLblConstraints(width)
        setupColViewConstraints()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "compId", for: indexPath) as! CompCell
        let t = teams[indexPath.item]
        cell.configureCell(team: t, fSize: fontSize!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamId = teams[indexPath.item].id
        let leagueId = league
        if Connectivity.isConnected{
            let teamDVC = TeamDetailVC()
            teamDVC.teamId = teamId
            teamDVC.leagueId = leagueId
            teamDVC.canAddFav = self.canAddTeamToFavs
            teamDVC.fontSize = self.fontSize!
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.navigationController?.pushViewController(teamDVC, animated: true)
            }, completion: nil)
        }else{
            setupNoConnectionView(description: "Check internet connection")
        }
    }
    fileprivate func setupNoConnectionView(description : String){
        view.addSubview(noConnectionLbl)
        noConnectionLbl.text = description
        noConnectionLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        noConnectionLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        noConnectionLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        noConnectionLbl.heightAnchor.constraint(equalToConstant: 15).isActive = true
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.noConnectionLbl.removeFromSuperview()
        }
    }
}
