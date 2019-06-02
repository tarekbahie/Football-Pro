//
//  CompVC.swift
//  Football Pro
//
//  Created by tarek bahie on 5/31/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class CompVC : UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.delegate = self
        cView.dataSource = self
        cView.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        
        return cView
    }()
    
    let postitionLbl1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        lbl.text = "Pos"
        return lbl
    }()
    let teamNameLbl1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        lbl.text = "Name"
        return lbl
    }()
    let gamesPlayedLbl1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        lbl.text = "Played"
        return lbl
    }()
    let goalDiffLbl1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        lbl.text = "Goal Diff"
        return lbl
    }()
    let pointsLbl1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.textAlignment = .center
        lbl.text = "Pts"
        return lbl
    }()
    
    var league : String?{
        didSet{
            DataService.instance.getLeagueStandingsWith(id: league!) { (returnedTeam, limit) in
                if limit{
                    self.teams = returnedTeam
                }else{
                    print("limit reached")
                }
            }
        }
    }
    var teams = [Team](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        collectionView.register(CompCell.self, forCellWithReuseIdentifier: "compId")
    }
    func setupViews(){
        view.addSubview(collectionView)
        view.addSubview(postitionLbl1)
        view.addSubview(teamNameLbl1)
        view.addSubview(gamesPlayedLbl1)
        view.addSubview(goalDiffLbl1)
        view.addSubview(pointsLbl1)
        
        postitionLbl1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        postitionLbl1.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant : 20).isActive = true
        postitionLbl1.widthAnchor.constraint(equalToConstant: 50).isActive = true
        postitionLbl1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        teamNameLbl1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        teamNameLbl1.leadingAnchor.constraint(equalTo: postitionLbl1.trailingAnchor,constant : 5).isActive = true
        teamNameLbl1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        teamNameLbl1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        gamesPlayedLbl1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gamesPlayedLbl1.leadingAnchor.constraint(equalTo: teamNameLbl1.trailingAnchor,constant : 5).isActive = true
        gamesPlayedLbl1.widthAnchor.constraint(equalToConstant: 50).isActive = true
        gamesPlayedLbl1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        goalDiffLbl1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        goalDiffLbl1.leadingAnchor.constraint(equalTo: gamesPlayedLbl1.trailingAnchor,constant : 5).isActive = true
        goalDiffLbl1.widthAnchor.constraint(equalToConstant: 50).isActive = true
        goalDiffLbl1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        pointsLbl1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pointsLbl1.leadingAnchor.constraint(equalTo: goalDiffLbl1.trailingAnchor,constant : 5).isActive = true
        pointsLbl1.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pointsLbl1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: postitionLbl1.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "compId", for: indexPath) as! CompCell
        let t = teams[indexPath.item]
        cell.configureCell(team: t)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
}
