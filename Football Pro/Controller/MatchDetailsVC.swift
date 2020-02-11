//
//  MatchDetailsVC.swift
//  Football Pro
//
//  Created by tarek bahie on 11/2/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
import SVProgressHUD
class MatchDetailsVC:UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    let detailTab = TabBar()
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.setupBgColor()
        cView.isScrollEnabled = true
        return cView
    }()
    
    var hName:String?
    var aName:String?
    var vName:String?
    var leagueName:String?{
        didSet{
            switch leagueName {
            case "Primera Division":
                leagueID = DataService.instance.spain
            case "Premier League" :
                leagueID = DataService.instance.england
                case "Série A":
                    leagueID = DataService.instance.brazil
                case "UEFA Champions League" :
                    leagueID = DataService.instance.champions
                case "Ligue 1":
                    leagueID = DataService.instance.france
                case "Bundesliga" :
                    leagueID = DataService.instance.germany
                case "Serie A":
                    leagueID = DataService.instance.italy
                case "Eredivisie" :
                    leagueID = DataService.instance.nether
                case "Primeira Liga":
                    leagueID = DataService.instance.portugal
            default:
                leagueID = nil
            }
        }
    }
    var leagueID:String?
    var retreivedMatchId:String?
    @objc fileprivate func getMatchDetailsFor() {
        guard let id = retreivedMatchId else {return}
        DataService.instance.getDataFor(fixId: id) { [weak self] (connErr, connDesc, mD) in
            if mD?.homeStartingName.isEmpty ?? true && mD?.awayStartingName.isEmpty ?? true {
                self?.showEmptyMatchDataAlert(msg: "No Data")
            }else{
                self?.awayCorners = mD?.awayCorners ?? "0"
                self?.awayEvDetail = mD?.awayEventDetail
                self?.awayEvplayer = mD?.awayEventPlayer
                self?.awayEvTime = mD?.awayEventTime
                self?.awayEvType = mD?.awayEventType
                self?.awayEvAssist = mD?.awayEventAssist
                self?.awayFouls = mD?.awayFouls ?? "0"
                self?.awayRed = mD?.awayRedCards ?? "0"
                self?.awayShotsOnTarget = mD?.awayShotsOnGoal ?? "0"
                self?.awayStartingEleven = mD?.awayStartingName
                self?.awayStartingElevenPos = mD?.awayStartingPos
                self?.awaySub = mD?.awaySubName
                self?.awaySubPos = mD?.awaySubPos
                self?.awayPasses = mD?.awayTotalPasses ?? "0"
                self?.awayShots = mD?.awayTotalShots ?? "0"
                self?.awayYellow = mD?.awayYellowCards ?? "0"
                self?.homeCorners = mD?.homeCorners ?? "0"
                self?.homeEvDetail = mD?.homeEventDetail
                self?.homeEvplayer = mD?.homeEventPlayer
                self?.homeEvTime = mD?.homeEventTime
                self?.homeEvType = mD?.homeEventType
                self?.homeEvAssist = mD?.homeEventAssist
                self?.homeFouls = mD?.homeFouls ?? "0"
                self?.homeRed = mD?.homeRedCards ?? "0"
                self?.homeShotsOnTarget = mD?.homeShotsOnGoal ?? "0"
                self?.homeStartingEleven = mD?.homeStartingName
                self?.homeStartingElevenPos = mD?.homeStartingPos
                self?.homeSub = mD?.homeSubName
                self?.homeSubPos = mD?.homeSubPos
                self?.homePasses = mD?.homeTotalPasses ?? "0"
                self?.homeShots = mD?.homeTotalShots ?? "0"
                self?.homeYellow = mD?.homeYellowCards ?? "0"
                self?.homeBPoss = mD?.homeBallPoss ?? "0"
                self?.awayBPoss = mD?.awayBallPoss ?? "0"
            }
            SVProgressHUD.dismiss()
            self?.refreshControl.endRefreshing()
            self?.collectionView.reloadData()
        }
    }
    
    fileprivate func getMatchId() {
        if date != nil {
            guard let hN = hName, let aN = aName else{return}
            if let vN = vName{
                DataService.instance.getFixtureIdForLineUps(date: date!, leagueId: leagueID, homeName: hN, awayName: aN, venue: vN) { [weak self] (connErr, connDesc,limit, id) in
                    if let _ = limit{
                        self?.showEmptyMatchDataAlert(msg: "Server error.\n Please try again later")
                    }else{
                        self?.retreivedMatchId = id
                        self?.getMatchDetailsFor()
                    }
                }
            }else{
                DataService.instance.getFixtureIdForLineUps(date: date!, leagueId: leagueID, homeName: hN, awayName: aN, venue: "vN") { [weak self] (connErr, connDesc,limit, id) in
                    if let _ = limit{
                        self?.showEmptyMatchDataAlert(msg: "Server error.\n Please try again later")
                    }else{
                        self?.retreivedMatchId = id
                        self?.getMatchDetailsFor()
                    }
                }
            }
            
        }
    }
    
    var date:String?{
        didSet{
            getMatchId()
        }
    }
    var homeStartingEleven:[String]?
    var homeStartingElevenPos:[String]?
    var homeSub:[String]?
    var homeSubPos:[String]?
    
    var awayStartingEleven:[String]?
    var awayStartingElevenPos:[String]?
    var awaySub:[String]?
    var awaySubPos:[String]?
    
    var homeShotsOnTarget = ""
    var awayShotsOnTarget = ""
    var homeShots = ""
    var awayShots = ""
    var homeFouls = ""
    var awayFouls = ""
    var homeCorners = ""
    var awayCorners = ""
    var homeYellow = ""
    var awayYellow = ""
    var homeRed = ""
    var awayRed = ""
    var homePasses = ""
    var awayPasses = ""
    var homeBPoss = ""
    var awayBPoss = ""
    
    var homeEvTime:[String]?
    var homeEvplayer:[String]?
    var homeEvType:[String]?
    var homeEvDetail:[String]?
    var homeEvAssist:[String]?
    
    var awayEvTime:[String]?
    var awayEvplayer:[String]?
    var awayEvType:[String]?
    var awayEvDetail:[String]?
    var awayEvAssist:[String]?
    
    
    var tabName: String? = "lineup"{
        didSet{
            collectionView.reloadData()
            collectionView.flashScrollIndicators()
        }
    }
    var tabHeightConstr:NSLayoutConstraint?
    var deviceType:String?{
        didSet{
            if let dT = deviceType{
                setupFonts(type: dT)
            }
        }
    }
    var fontSize:CGFloat = 14
    var barHeight:CGFloat = 0.0
    var barImageHeight:CGFloat = 0.0
    var playerToShow : String?{
        didSet{
            guard let pN = playerToShow, playerToShow != "" else{return}
            let playerVC = PlayerVC()
            playerVC.fontSize = self.fontSize
            playerVC.playerToShow = pN
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.navigationController?.pushViewController(playerVC, animated: true)
            }, completion: nil)
        }
    }
    private let refreshControl = UIRefreshControl()
    
    fileprivate func setupViews(){
        view.addSubview(collectionView)
        view.addSubview(detailTab)
        
        detailTab.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailTab.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        detailTab.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tabHeightConstr = detailTab.heightAnchor.constraint(equalToConstant: 0)
        tabHeightConstr?.isActive = true
        
        collectionView.topAnchor.constraint(equalTo: detailTab.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    fileprivate func setupFonts(type:String){
        if type == "ipad"{
            barHeight = 140
            barImageHeight = 50
            fontSize = 28
        }else{
            barHeight = 70
            barImageHeight = 30
            fontSize = 14
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        SVProgressHUD.show()
        collectionView.register(FormationCell.self, forCellWithReuseIdentifier: "formCell")
        collectionView.register(StatsCell.self, forCellWithReuseIdentifier: "statsCell")
        collectionView.register(EventsCell.self, forCellWithReuseIdentifier: "eventsCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getMatchDetailsFor), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.03529411765, green: 0.5058823529, blue: 0.2901960784, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching updates")
        detailTab.mDetails = self
        detailTab.translatesAutoresizingMaskIntoConstraints = false
        detailTab.names = ["lineup","live","stats"]
        detailTab.size = barHeight
        detailTab.imageHeight = barImageHeight
        tabHeightConstr?.constant = barHeight
    }
    func showEmptyMatchDataAlert(msg : String){
        let alert = UIAlertController(title: msg, message: "Please check back for lineups 20 minutes before match", preferredStyle: .alert)
        alert.setupAlertTintColor()
        alert.setValue(NSAttributedString(string: msg, attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var defence = [String]()
        var midfield = [String]()
        var attack = [String]()
        var defenceAway = [String]()
        var midfieldAway = [String]()
        var attackAway = [String]()
        var keeperHArr = [String]()
        var keeperAArr = [String]()
        if let tN = tabName{
            if tN == "lineup"{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "formCell", for: indexPath) as! FormationCell
                if let hSE = homeStartingEleven, homeStartingEleven?.count ?? 0 > 0, let hSEP = homeStartingElevenPos, let aSE = awayStartingEleven,awayStartingEleven?.count ?? 0 > 0, let aSEP = awayStartingElevenPos{
                    if hSEP.count > 0{
                        for i in 1..<hSEP.count{
                            if hSEP[i] == "D"{
                                defence.append(hSE[i])
                            }else if hSEP[i] == "M"{
                                midfield.append(hSE[i])
                            }else{
                                attack.append(hSE[i])
                            }
                        }
                    }
                    if aSEP.count > 0{
                        for i in 1..<aSEP.count{
                            if aSEP[i] == "D"{
                                defenceAway.append(aSE[i])
                            }else if aSEP[i] == "M"{
                                midfieldAway.append(aSE[i])
                            }else{
                                attackAway.append(aSE[i])
                            }
                        }
                    }
                    keeperHArr.append(homeStartingEleven?[0] ?? "")
                    keeperAArr.append(awayStartingEleven?[0] ?? "")
                    cell.fontSize = fontSize
                    cell.homeVC = self
                    cell.configCell(keeperH: keeperHArr, keeperA:  keeperAArr, defH: defence, midH: midfield, attH: attack, defA: defenceAway, midA: midfieldAway, attA: attackAway, teamH: hName ?? "", teamA: aName ?? "", subH: homeSub ?? [String](), subHPos: homeSubPos ?? [String](), subA: awaySub ?? [String](), subAPos: awaySubPos ?? [String]())
                    return cell
                }else{
                    cell.configCell(keeperH: [String](), keeperA: [String](), defH: [String](), midH: [String](), attH: [String](), defA: [String](), midA: [String](), attA: [String](), teamH: "", teamA: "", subH: [String](), subHPos: [String](), subA: [String](), subAPos: [String]())
                    return cell
                }
            }else if tN == "stats"{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statsCell", for: indexPath) as! StatsCell
                cell.fontSize = fontSize
                cell.configureCell(onTargetH: homeShotsOnTarget, onTargetA: awayShotsOnTarget, totalH: homeShots, totalA: awayShots, foulsH: homeFouls, foulsA: awayFouls, cornersH: homeCorners, cornersA: awayCorners, yellowH: homeYellow, yellowA: awayYellow, redH: homeRed, redA: awayRed, passesH: homePasses, passesA: awayPasses, hName: hName ?? "", aName: aName ?? "", hBP: homeBPoss, aBP: awayBPoss)
                return cell
                
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventsCell", for: indexPath) as! EventsCell
                cell.fontSize = fontSize
                cell.configureCell(homeTime: homeEvTime ?? [String](), homePlayer: homeEvplayer ?? [String](), homeType: homeEvType ?? [String](), homeDetail: homeEvDetail ?? [String](), homeAssist: homeEvAssist ?? [String](), awayTime: awayEvTime ?? [String](), awayPlayer: awayEvplayer ?? [String](), awayType: awayEvType ?? [String](), awayDetail: awayEvDetail ?? [String](), awayAssist: awayEvAssist ?? [String](), hName: hName ?? "", aName: aName ?? "")
                return cell
            }
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath) 
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.collectionViewLayout.invalidateLayout()
        let width = collectionView.frame.width, height = collectionView.frame.height
        if width <= 0 || height <= 0 {
            return CGSize(width: 0, height: 0)
        }else{
            return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height - barHeight - refreshControl.frame.height)
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}
