//
//  TeamDetailVC.swift
//  Football Pro
//
//  Created by tarek bahie on 6/1/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
import SDWebImage

class TeamDetailVC : UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    let teamNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.text = "bala2seyo"
        return lbl
    }()
    let teamCompLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.text = "Champions league  serie A  coppa italia"
        return lbl
    }()
    let teamCrestImg : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "default")
        img.tintColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        img.contentMode = .scaleToFill
        return img
    }()
    let teamColorLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.text = "Red / Black"
        return lbl
    }()
    let coachNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.text = "Ace Ventura"
        return lbl
    }()
    let topScorerLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.text = "Top Scorer"
        return lbl
    }()
    lazy var squadLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.layer.cornerRadius = 8
        lbl.layer.masksToBounds = true
        lbl.layer.borderWidth = 1.0
        lbl.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.text = "Squad"
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSquad)))
        return lbl
    }()
    let arrowLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.text = ">"
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSquad)))
        return lbl
    }()
    
    
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Name"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let posLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "position"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let goalsLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "goals"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .vertical
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.delegate = self
        cView.dataSource = self
        cView.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        cView.isScrollEnabled = false
        return cView
    }()
    var stringCrestUrl = ""{
        didSet{
            if let u = URL(string: stringCrestUrl){
                self.teamCrestImg.sd_setImage(with: u, placeholderImage: UIImage(named: "default")?.withRenderingMode(.alwaysTemplate), options: .continueInBackground, completed: nil)
            }
        }
    }
    var teamId : String?{
        didSet{
            DataService.instance.getTeamDetail(teamId: teamId!) { (comp, crest, name, colours, coach, squad, limit) in
                if limit{
                    self.stringCrestUrl = crest
                    self.teamName = name
                    self.squadNames = squad
                    DispatchQueue.main.async {
                        self.teamNameLbl.text = name
                        self.teamColorLbl.text = colours
                        self.teamCompLbl.text = "\(comp)"
                        self.coachNameLbl.text = coach
                    }
                }else{
                    print("limit exceeded")
                }
            }
        }
    }
    var squadNames : [Player]?{
        didSet{
            self.squadLbl.isUserInteractionEnabled = true
        }
    }
    var leagueId : String?
    var teamName : String?{
        didSet{
            if let lId = leagueId{
                DataService.instance.getTopScorersFor(leagueCode: lId, teamName: teamName!) { (returnedScorers, limit) in
                    if limit{
                        self.topScorer = returnedScorers
                    } else{
                        print("limit exceeded")
                    }
                }
            }
        }
    }
    var topScorer : [Scorer]?{
        didSet{
          collectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topScorer?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ScorerCell
        cell.configureCell(scorer: topScorer?[indexPath.item] ?? Scorer(n: "none", p: "none", g: "0"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        setupViews()
        setupCollectionView()
    }
    func setupViews(){
        view.addSubview(teamNameLbl)
        view.addSubview(teamCompLbl)
        view.addSubview(teamCrestImg)
        view.addSubview(teamColorLbl)
        view.addSubview(coachNameLbl)
        view.addSubview(topScorerLbl)
        view.addSubview(squadLbl)
        view.addSubview(arrowLbl)
        
        teamNameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant:5).isActive = true
        teamNameLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        teamNameLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        teamNameLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        teamCompLbl.topAnchor.constraint(equalTo: teamNameLbl.bottomAnchor,constant: 30).isActive = true
        teamCompLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        teamCompLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        teamCompLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        teamCrestImg.topAnchor.constraint(equalTo: teamCompLbl.bottomAnchor,constant: 30).isActive = true
        teamCrestImg.widthAnchor.constraint(equalToConstant: 150).isActive = true
        teamCrestImg.heightAnchor.constraint(equalToConstant: 150).isActive = true
        teamCrestImg.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        teamColorLbl.topAnchor.constraint(equalTo: teamCrestImg.bottomAnchor,constant: 30).isActive = true
        teamColorLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        teamColorLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        teamColorLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        coachNameLbl.topAnchor.constraint(equalTo: teamColorLbl.bottomAnchor,constant: 30).isActive = true
        coachNameLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        coachNameLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        coachNameLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        topScorerLbl.topAnchor.constraint(equalTo: coachNameLbl.bottomAnchor,constant: 30).isActive = true
        topScorerLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        topScorerLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        topScorerLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        squadLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:-5).isActive = true
        squadLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        squadLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        squadLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        arrowLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:-5).isActive = true
        arrowLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -5).isActive = true
        arrowLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        arrowLbl.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
    func setupCollectionView(){
        collectionView.register(ScorerCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(collectionView)
        view.addSubview(nameLbl)
        view.addSubview(posLbl)
        view.addSubview(goalsLbl)
        
        nameLbl.topAnchor.constraint(equalTo: topScorerLbl.bottomAnchor,constant: 5).isActive = true
        nameLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5).isActive = true
        nameLbl.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        posLbl.topAnchor.constraint(equalTo: topScorerLbl.bottomAnchor,constant: 5).isActive = true
        posLbl.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor).isActive = true
        posLbl.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        posLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        goalsLbl.topAnchor.constraint(equalTo: topScorerLbl.bottomAnchor,constant: 5).isActive = true
        goalsLbl.leadingAnchor.constraint(equalTo: posLbl.trailingAnchor).isActive = true
        goalsLbl.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        goalsLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: nameLbl.bottomAnchor,constant:5).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: squadLbl.topAnchor,constant:-5).isActive = true
    }
    @objc func handleSquad(){
        let squadVC = SquadVC()
        squadVC.teamN = self.teamName
        squadVC.teamSquad = self.squadNames
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.navigationController?.pushViewController(squadVC, animated: true)
        }, completion: nil)
    }
}
