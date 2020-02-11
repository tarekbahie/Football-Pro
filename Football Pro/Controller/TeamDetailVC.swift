//
//  TeamDetailVC.swift
//  Football Pro
//
//  Created by tarek bahie on 6/1/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import CoreData

class TeamDetailVC : UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    let teamCompLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = nil
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.text = nil
        return lbl
    }()
    let teamCrestImg : UIImageView = {
        let img = UIImageView()
        img.image = nil
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "default")
        img.setupTintColor()
        img.contentMode = .scaleAspectFit
        return img
    }()
    let teamColorLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = nil
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.text = "Red / Black"
        return lbl
    }()
    lazy var coachNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.text = nil
        lbl.setupOutline()
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCoach)))
        return lbl
    }()
    let topScorerLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.text = "Top Scorer"
        return lbl
    }()
    lazy var squadLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.setupOutline()
        lbl.text = "Squad"
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSquad)))
        return lbl
    }()
    let arrowLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.text = ">"
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSquad)))
        return lbl
    }()
    let arrowLbl2 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.text = ">"
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCoach)))
        return lbl
    }()
    
    
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Name"
        lbl.setupBasicAttributes()
        return lbl
    }()
    let posLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "position"
        lbl.setupBasicAttributes()
        return lbl
    }()
    let goalsLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "goals"
        lbl.setupBasicAttributes()
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
        cView.isScrollEnabled = true
        return cView
    }()
    var stringCrestUrl = ""{
        didSet{
            if let u = URL(string: stringCrestUrl),stringCrestUrl != "", stringCrestUrl != "http://upload.wikimedia.org/wikipedia/de/5/5c/Chelsea_crest.svg"{
                DispatchQueue.main.async {
                    self.teamCrestImg.sd_setImage(with: u, placeholderImage: UIImage(named: "default")?.withRenderingMode(.alwaysTemplate), options: [], completed: nil)
                }
            }else if stringCrestUrl == "http://upload.wikimedia.org/wikipedia/de/5/5c/Chelsea_crest.svg"
            {
                self.teamCrestImg.image = UIImage(named: "chelsea")
            }else{
                self.teamCrestImg.image = UIImage(named: "default")
            }
        }
    }
    var teamId : String?{
        didSet{
            getDetail(tID: teamId!)
        }
    }
    let noConnectionLbl : UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    var favTeamName = ""
    var favTeamId = ""
    var canAddFav : Bool = false
    var fontSize:CGFloat?{
        didSet{
            if let fS = fontSize{
                setupFonts(size: fS)
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
                getTopScorers(leagId: lId, tName: teamName!)
                navigationItem.title = teamName!
            }
        }
    }
    var topScorer : [Scorer]?{
        didSet{
          collectionView.reloadData()
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    fileprivate func setupFonts(size:CGFloat){
        teamCompLbl.font = UIFont.systemFont(ofSize: size)
        teamColorLbl.font = UIFont.systemFont(ofSize: size)
        coachNameLbl.font = UIFont.systemFont(ofSize: size)
        topScorerLbl.font = UIFont.systemFont(ofSize: size)
        squadLbl.font = UIFont.systemFont(ofSize: size)
        arrowLbl.font = UIFont.systemFont(ofSize: size)
        nameLbl.font = UIFont.systemFont(ofSize: size)
        posLbl.font = UIFont.systemFont(ofSize: size)
        goalsLbl.font = UIFont.systemFont(ofSize: size)
        
    }
    
    fileprivate func setupTeamDetailVariables(_ crest: String, _ name: String, _ squad: [Player], _ tID: String, _ colours: String, _ comp: [String], _ coach: String) {
        SVProgressHUD.dismiss()
        stringCrestUrl = crest
        teamName = name
        squadNames = squad
        favTeamName = name
        favTeamId = tID
        DispatchQueue.main.async {[weak self] in
            self?.teamColorLbl.text = colours
            var t = ""
            for com in comp{
                if com != comp[comp.count - 1]{
                    t += com + "-"
                }else{
                    t += com
                }
            }
            self?.teamCompLbl.text = t
            self?.coachNameLbl.text = coach
        }
    }
    
    fileprivate func setupTeamDetail(tID:String,_ limit: Bool, _ crest: String, _ name: String, _ squad: [Player], _ colours: String, _ comp: [String], _ coach: String) {
        if limit{
            setupTeamDetailVariables(crest, name, squad, tID, colours, comp, coach)
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+10, execute: {[weak self] in
                self?.getDetail(tID: self?.teamId! ?? "")
            })
        }
    }
    
    fileprivate func getDetail(tID : String){
        SVProgressHUD.show()
        DataService.instance.getTeamDetail(teamId: tID) { [weak self] (comp, crest, name, colours, coach, squad, limit,conn,connDesc) in
            if let _ = conn, let desc = connDesc{
                self?.setupNoConnectionView(description: desc)
            }else{
                self?.setupTeamDetail(tID: tID, limit, crest, name, squad, colours, comp, coach)
            }
        }
    }
    fileprivate func getTopScorers(leagId : String,tName : String){
        SVProgressHUD.show()
        DataService.instance.getTopScorersFor(leagueCode: leagId, teamName: tName) { [weak self] (returnedScorers, limit,conn2,connDesc2) in
            if let _ = conn2, let desc2 = connDesc2{
                self?.setupNoConnectionView(description: desc2)
            }else{
                if limit{
                    SVProgressHUD.dismiss()
                    self?.topScorer = returnedScorers
                } else{
                    DispatchQueue.main.asyncAfter(deadline: .now()+10, execute: {
                        self?.getTopScorers(leagId: leagId, tName: tName)
                    })
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topScorer?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ScorerCell
        cell.configureCell(scorer: topScorer?[indexPath.item] ?? Scorer(n: "none", p: "none", g: "0", a: "none", nat: "none"), fSize: fontSize!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let scorer = topScorer?[indexPath.item] else{return}
        let player = Player(n: scorer.Name, p: scorer.position, a: scorer.age, nat: scorer.nationality, g: scorer.goals)
        let playerVC = PlayerVC()
        playerVC.playerToShow = player.name
        playerVC.fontSize = self.fontSize!
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.navigationController?.pushViewController(playerVC, animated: true)
            }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setupBgColor()
        setupViews()
        setupCollectionView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddFavs))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    fileprivate func setupTeamCompConstraints(_ fS: CGFloat) {
        teamCompLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant:5).isActive = true
        teamCompLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        teamCompLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        teamCompLbl.heightAnchor.constraint(equalToConstant: fS * 3).isActive = true
    }
    
    fileprivate func setupTeamCrestConstraints(_ constant: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        teamCrestImg.topAnchor.constraint(equalTo: teamCompLbl.bottomAnchor,constant: constant).isActive = true
        teamCrestImg.widthAnchor.constraint(equalToConstant: width).isActive = true
        teamCrestImg.heightAnchor.constraint(equalToConstant: height).isActive = true
        teamCrestImg.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    fileprivate func setupTeamColorConstraints(_ constant: CGFloat, _ fS: CGFloat) {
        teamColorLbl.topAnchor.constraint(equalTo: teamCrestImg.bottomAnchor,constant: constant + 10).isActive = true
        teamColorLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        teamColorLbl.heightAnchor.constraint(equalToConstant: fS + 3).isActive = true
        teamColorLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    fileprivate func addArrowToCoach(_ fS: CGFloat) {
        arrowLbl2.centerYAnchor.constraint(equalTo: coachNameLbl.centerYAnchor).isActive = true
        arrowLbl2.trailingAnchor.constraint(equalTo: coachNameLbl.trailingAnchor).isActive = true
        arrowLbl2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        arrowLbl2.widthAnchor.constraint(equalToConstant: fS + 13).isActive = true
    }
    
    fileprivate func setupCoachLblConstraints(_ fS: CGFloat) {
        coachNameLbl.topAnchor.constraint(equalTo: teamColorLbl.bottomAnchor,constant: 10).isActive = true
        coachNameLbl.widthAnchor.constraint(equalToConstant: (fS + 3) * 10).isActive = true
        coachNameLbl.heightAnchor.constraint(equalToConstant: fS + 3).isActive = true
        coachNameLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    fileprivate func setupTopScorerLblConstraints(_ fS: CGFloat) {
        topScorerLbl.topAnchor.constraint(equalTo: coachNameLbl.bottomAnchor,constant: 10).isActive = true
        topScorerLbl.widthAnchor.constraint(equalToConstant: 300).isActive = true
        topScorerLbl.heightAnchor.constraint(equalToConstant: fS + 3).isActive = true
        topScorerLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    fileprivate func setupSquadLblConstraints(_ fS: CGFloat) {
        squadLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:-5).isActive = true
        squadLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        squadLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        squadLbl.heightAnchor.constraint(equalToConstant: fS + 13).isActive = true
    }
    
    fileprivate func setupArrowLblConstraints(_ fS: CGFloat) {
        arrowLbl.centerYAnchor.constraint(equalTo: squadLbl.centerYAnchor).isActive = true
        arrowLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -5).isActive = true
        arrowLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        arrowLbl.widthAnchor.constraint(equalToConstant: fS + 13).isActive = true
    }
    
    fileprivate func addSubviews() {
        view.addSubview(teamCompLbl)
        view.addSubview(teamCrestImg)
        view.addSubview(teamColorLbl)
        view.addSubview(coachNameLbl)
        view.addSubview(topScorerLbl)
        view.addSubview(squadLbl)
        view.addSubview(arrowLbl)
        view.addSubview(arrowLbl2)
    }
    
    fileprivate func addConstraintsToViews(_ fS: CGFloat, _ constant: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        setupTeamCompConstraints(fS)
        setupTeamCrestConstraints(constant, width, height)
        setupTeamColorConstraints(constant, fS)
        setupCoachLblConstraints(fS)
        setupTopScorerLblConstraints(fS)
        setupSquadLblConstraints(fS)
        setupArrowLblConstraints(fS)
        addArrowToCoach(fS)
    }
    
    fileprivate func setupViews(){
        addSubviews()
        let height = UIScreen.main.bounds.height/4
        let width = UIScreen.main.bounds.width/4
        guard let fS = fontSize else{return}
        var constant:CGFloat = 10
        if fS > 20{
            constant = 30
        }
        addConstraintsToViews(fS, constant, width, height)
    }
    fileprivate func setupNameLblConstraints(_ fS: CGFloat) {
        nameLbl.topAnchor.constraint(equalTo: topScorerLbl.bottomAnchor,constant: 5).isActive = true
        nameLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5).isActive = true
        nameLbl.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: fS + 3).isActive = true
    }
    
    fileprivate func setupPosLblConstraints(_ fS: CGFloat) {
        posLbl.topAnchor.constraint(equalTo: topScorerLbl.bottomAnchor,constant: 5).isActive = true
        posLbl.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor).isActive = true
        posLbl.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        posLbl.heightAnchor.constraint(equalToConstant: fS + 3).isActive = true
    }
    
    fileprivate func setupGoalsLblConstraints(_ fS: CGFloat) {
        goalsLbl.topAnchor.constraint(equalTo: topScorerLbl.bottomAnchor,constant: 5).isActive = true
        goalsLbl.leadingAnchor.constraint(equalTo: posLbl.trailingAnchor).isActive = true
        goalsLbl.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        goalsLbl.heightAnchor.constraint(equalToConstant: fS + 3).isActive = true
    }
    
    fileprivate func setupColViewConstraints() {
        collectionView.topAnchor.constraint(equalTo: nameLbl.bottomAnchor,constant:5).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: squadLbl.topAnchor,constant:-5).isActive = true
    }
    
    fileprivate func setupCollectionView(){
        collectionView.register(ScorerCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(collectionView)
        view.addSubview(nameLbl)
        view.addSubview(posLbl)
        view.addSubview(goalsLbl)
        
        guard let fS = fontSize else{return}
        setupNameLblConstraints(fS)
        setupPosLblConstraints(fS)
        setupGoalsLblConstraints(fS)
        setupColViewConstraints()
    }
    fileprivate func setupSquadVC() {
        self.squadLbl.transform = CGAffineTransform.identity
        self.arrowLbl.transform = CGAffineTransform.identity
        let squadVC = SquadVC()
        squadVC.teamN = self.teamName
        squadVC.teamSquad = self.squadNames
        squadVC.fontSize = self.fontSize!
        if self.teamName != nil && self.squadNames != nil{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.navigationController?.pushViewController(squadVC, animated: true)
            }, completion: nil)
        }
    }
    
    @objc func handleSquad(){
        UILabel.animate(withDuration: 0.2,
                         animations: {
                            self.squadLbl.transform = CGAffineTransform(scaleX: 0.97, y: 0.96)
                            self.arrowLbl.transform = CGAffineTransform(scaleX: 0.97, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                self.setupSquadVC()
                            })
        })
        
    }
    @objc func handleAddFavs(){
        if canAddFav{
            self.saveFavTeam { (success) in
                if !success{
                }else{
                    self.canAddFav = false
                    showTeamAddedAlert()
                }
            }
        }else{
            showFavouriteExistAlert()
        }
    }
    fileprivate func setupTeamMsg(_ msg: inout String) {
        switch favTeamName {
        case "Real Madrid CF":
            msg = "¡Hala madrid Y nada más¡"
        case "FC Barcelona":
            msg = "Més que un Club"
        case "Arsenal FC":
            msg = "Come On You Gunners"
        case "Chelsea FC":
            msg = "Keep The Blues Flag Flying High"
        case "Liverpool FC":
            msg = "You Will Never Walk Alone"
        case "Manchester United FC":
            msg = "Glory Glory Man united !"
        case "Tottenham Hotspur FC":
            msg = "Come On You Spurs!"
        case "Manchester City FC":
            msg = "Superbia in Proelio"
        case "Olympique Lyonnais":
            msg = "Coeur de Lyon. Lyon de Coeur"
        case "Paris Saint-Germain FC":
            msg = "Ici C'est Paris"
        case "FC Bayern München":
            msg = "Mia San Mia"
        case "BV Borussia 09 Dortmund":
            msg = "Echte Liebe"
        case "Juventus FC":
            msg = "Fino Alla Fine"
        case "FC Internazionale Milano":
            msg = "La Beneamata"
        case "AC Milan":
            msg = "Forza Milan"
        default:
            msg = "Favourite team added"
        }
    }
    
    fileprivate func showTeamAddedAlert(){
        var msg = ""
        setupTeamMsg(&msg)
        let alert = UIAlertController(title: "Added", message: msg, preferredStyle: .alert)
        alert.setupAlertTintColor()
        alert.setValue(NSAttributedString(string: "Added", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    fileprivate func showFavouriteExistAlert(){
        let alert = UIAlertController(title: "Added", message: "delete favourite team first", preferredStyle: .alert)
        alert.setupAlertTintColor()
        alert.setValue(NSAttributedString(string: "Favourite team already chosen", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    fileprivate func setupNoConnectionView(description: String){
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
    fileprivate func saveFavTeam(completion : (_ finished : Bool)->()) {
            guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
            managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            let team = FavouriteTeam(context: managedContext)
            team.id = favTeamId
            team.name = favTeamName
            do{
                try managedContext.save()
                completion(true)
            } catch{
                debugPrint("Couldn't Save: \(error.localizedDescription)")
                completion(false)
            }
    }
    
    @objc func handleCoach(){
        SVProgressHUD.show()
        UILabel.animate(withDuration: 0.2,
                         animations: {
                            self.coachNameLbl.transform = CGAffineTransform(scaleX: 0.97, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                self.coachNameLbl.transform = CGAffineTransform.identity
                                let playerVC = PlayerVC()
                                playerVC.playerToShow = self.coachNameLbl.text
                                playerVC.fontSize = self.fontSize!
                                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                                    SVProgressHUD.dismiss()
                                    self.navigationController?.pushViewController(playerVC, animated: true)
                                }, completion: nil)
                                
                            })
        })
        
        
    }
}
