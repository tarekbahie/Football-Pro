//
//  ViewController.swift
//  Football Pro
//
//  Created by tarek bahie on 5/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD
import Alamofire
//import GoogleMobileAds

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class HomeVC: UIViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate{
//    GADBannerViewDelegate
    lazy var searchTeams : UISearchBar = {
        let sBar = UISearchBar()
        sBar.translatesAutoresizingMaskIntoConstraints = false
        sBar.delegate = self
        if #available(iOS 13.0, *) {
            sBar.barTintColor = .systemBackground
        } else {
            sBar.barTintColor = .white
        }
        sBar.placeholder = "Enter country name here"
        let textFieldInsideSearchBar = sBar.value(forKey: "searchField") as? UITextField
        if #available(iOS 13.0, *) {
            textFieldInsideSearchBar?.textColor = .systemIndigo
        } else {
           textFieldInsideSearchBar?.textColor  = #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1)
        }
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        if #available(iOS 13.0, *) {
            textFieldInsideSearchBarLabel?.textColor = .systemBackground
        } else {
            textFieldInsideSearchBarLabel?.textColor = .white
        }
        sBar.tfBackgroundColor()
        return sBar
    }()
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.dataSource = self
        cView.delegate = self
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.setupBgColor()
        return cView
    }()
    let creditsLbl:UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 9)
        lbl.setupCreditsAttributes()
        lbl.text = "Designed by Freepik \n Football data provided by the Football-Data.org API"
        return lbl
    }()
    let countLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.text = "There are currently no live matches"
        lbl.tag = 20000
        return lbl
    }()
    let noConnectionLbl : UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.setupBasicAttributes()
        return lbl
    }()
    lazy var viewBtn:UIButton={
        let btn = UIButton()
        btn.setImage(UIImage(named: "gridFPro")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.addTarget(self, action: #selector(handleViewBtn), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            btn.tintColor = .systemIndigo
        } else {
            btn.tintColor = #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1)
        }
        return btn
    }()
    var viewIsGrid : Bool = false{
        didSet{
            collectionView.reloadData()
        }
    }
    var searchHeightConstraint : NSLayoutConstraint?
    var calendarHeightConstraint : NSLayoutConstraint?
    var creditsHeightConstraint : NSLayoutConstraint?
    var liveMatches = [LiveMatch](){
        didSet{
            collectionView.reloadData()
        }
    }
    var hiddenSearch : Bool = false
    var liveCount = 0
    var tabName : String? = "home" {
        didSet {
            setupViewsForTabName()
        }
    }
    var selectedDay : String?{
        didSet{
            self.matches.removeAll()
            self.collectionView.reloadData()
            getAllMatches(dateF: selectedDay!, dateT: selectedDay!)
//                DataService.instance.getFixtureIdForLineUps(date: selectedDay!, homeName: "", awayName: "") { (connErr, connDesc, id) in
//                }
            self.collectionView.reloadData()
        }
    }
    let tab = TabBar()
    let cal = CalendarBar()
    var competitions : [Competiton] = []
    var id = ""
    var compName = ""
    var competitionsIDs = [String]()
    var competitionNames = [String]()
    var fetchedCompetitionsIDs = [String]()
    var m = [Match]()
    var today21 = Date()
    var fetchedCompetitionsNames = [String](){
        didSet {
            collectionView.reloadData()
        }
    }
    var matches = [Match](){
        didSet{
            m.removeAll()
            collectionView.reloadData()
        }
    }
    var limitExceeded : Bool?{
        didSet{
            if limitExceeded ?? false{
                limitLblDisplay(message: "Server is busy or offline")
                setupTimer()
            }
        }
    }
    var noMatchesCurrently : Bool?{
        didSet{
            if noMatchesCurrently ?? false{
                limitLblDisplay(message: "There are no matches today")
            }
        }
    }
    let errorLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.setupBasicAttributes()
        lbl.tag = 10000
        lbl.setupBgColor()
        return lbl
    }()
    let timerLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.setupBasicAttributes()
        lbl.tag = 30000
        return lbl
    }()
    let reconnectImg:UIImageView={
        let img = UIImageView()
        img.image = UIImage(named: "reconnect")
        img.contentMode = .scaleAspectFit
        img.tag = 40000
        return img
    }()
    var connection : Bool = false
    var favTeam : [FavouriteTeam] = []{
        didSet{
            self.collectionView.reloadData()
        }
    }
    var fetchedTeamName = ""{
        didSet{
            if favTeam.count>0{
                favouriteTeamName = favTeam[0].name
            }
        }
    }
    var fetchedTeamId = ""{
        didSet{
            if fetchedTeamId != ""{
                favTeamSelected = true
            }
            
        }
    }
    var favTeamMatches : [LiveMatch]?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    var favTeamSelected : Bool = false
    var favouriteTeamName : String?
    var counter = 0
    var fontSize:CGFloat = 0.0
    var barHeight:CGFloat = 0.0
    var barImageHeight:CGFloat = 0.0
    var tabBarHeightConst:NSLayoutConstraint?
//    var bannerView: GADBannerView!
    private let refreshControl = UIRefreshControl()
    var compNameToGetId : String?{
        didSet{
            getSearchedMatches()
        }
    }
    var matchDateToSearchFor : String?
    var compIdToSearchFor:String?{
        didSet{
            guard let mDate = matchDateToSearchFor else{return}
            getCompMatches(mDate)
        }
    }
    var deviceType : String?
    var compStart: [String]?
    var compEnd: [String]?
    fileprivate func getCompMatches(_ mDate: String) {
        SVProgressHUD.show()
        DataService.instance.getCompetitionMatches(id: compIdToSearchFor!, dateFrom: mDate, dateTo: mDate, completion: { [weak self] (returnedMatches, mCount, limit2, dF, dT, c2, cD2) in
            if let _ = c2,let d2 = cD2{
                self?.setupNoConnectionViews(description: d2)
                SVProgressHUD.dismiss()
            }else{
                if limit2{
                    if returnedMatches.count == 0{
                        SVProgressHUD.dismiss()
                        self?.noMatchesCurrently = true
                    }else{
                        self?.matches = returnedMatches
                        self?.collectionView.reloadData()
                        SVProgressHUD.dismiss()
                    }
                    
                }else{
                    SVProgressHUD.dismiss()
                }
            }
        })
    }
    fileprivate func getSearchedCountryLeagueId() {
        DataService.instance.getCompetitionID(name: compNameToGetId?.capitalized ?? "") { [weak self] (compId, compName,start,end, limit, c, cD) in
            if let _ = c, let d = cD{
                SVProgressHUD.dismiss()
                self?.setupNoConnectionViews(description: d)
            }else{
                if limit{
                    SVProgressHUD.dismiss()
                    if compId.count != 0 {
                        self?.compIdToSearchFor = compId[0]
                        self?.compStart?.append(start)
                        self?.compEnd?.append(end)
                    }else{
                        self?.limitLblDisplay(message: "Please check country name !")
                    }
                }else{
                    SVProgressHUD.dismiss()
                    self?.limitLblDisplay(message: "Please check country name !")
                }
            }
        }
    }
    fileprivate func getSearchedMatches() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.calendarHeightConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
        if compNameToGetId == "all"{
            guard let mDate = matchDateToSearchFor else{return}
            getAllMatches(dateF: mDate, dateT: mDate)
        }else{
            SVProgressHUD.show()
            getSearchedCountryLeagueId()
        }
    }
    fileprivate func setupViewMenuBar(){
        let viewMenu = UIBarButtonItem(customView: viewBtn)
        self.navigationItem.leftBarButtonItem = viewMenu
        viewMenu.customView?.translatesAutoresizingMaskIntoConstraints = false
        viewMenu.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        viewMenu.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    fileprivate func setupRegularRegular(){
        fontSize = 28.0
        barHeight = 140
        barImageHeight = 50
        deviceType = "ipad"
        setupStartApp()
        tabBarHeightConst?.constant = 140
    }
    fileprivate func setupIphone(){
        fontSize = 17.0
        barHeight = 70
        barImageHeight = 30
        deviceType = "iphone"
        setupStartApp()
        tabBarHeightConst?.constant = 70
    }
    fileprivate func setupViewForLimitError(_ stack: UIStackView) {
        view.addSubview(stack)
        
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: tab.topAnchor).isActive = true
    }
    
    fileprivate func updateUIForServerMsg() {
        tab.isUserInteractionEnabled = false
        cal.isUserInteractionEnabled = false
        timerLbl.isHidden = false
        reconnectImg.isHidden = false
    }
    
    fileprivate func updateUIForOtherMsg() {
        timerLbl.isHidden = true
        reconnectImg.isHidden = true
    }
    
    fileprivate func updateUIAfterTime(_ t: Double, _ stack: UIStackView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + t) { [weak self] in
            self?.errorLbl.text = ""
            self?.timerLbl.text = ""
            self?.errorLbl.removeFromSuperview()
            self?.timerLbl.removeFromSuperview()
            self?.reconnectImg.removeFromSuperview()
            stack.removeFromSuperview()
            self?.tab.isUserInteractionEnabled = true
            self?.cal.isUserInteractionEnabled = true
        }
    }
    
    func limitLblDisplay(message : String){
        errorLbl.text = message
        let stack = UIStackView(arrangedSubviews: [errorLbl,reconnectImg,timerLbl])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        setupViewForLimitError(stack)
        var t = 0.0
        if message == "Server is busy or offline"{
            t = 60.0
            updateUIForServerMsg()
        }else{
            t = 1.0
            updateUIForOtherMsg()
        }
        updateUIAfterTime(t, stack)
    }
    fileprivate func setupTimer() {
        if DataService.instance.timer == nil{
            DataService.instance.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: true)
            counter = 60
        }
    }
    @objc func handleTimer(){
        if counter > 0{
            timerLbl.text = "Reconnecting in : \(counter) sec"
            counter -= 1
        }else{
            if DataService.instance.timer != nil {
                DataService.instance.timer?.invalidate()
                DataService.instance.timer = nil
            }
        }
    }
    func getFavTeamMatches(){
        SVProgressHUD.show()
        DataService.instance.getTeamMatches(id: fetchedTeamId) { [weak self] (returnedMatches,limit, conn5, connDesc5) in
            if let _ = conn5, let desc5 = connDesc5{
                SVProgressHUD.dismiss()
                self?.setupNoConnectionViews(description: desc5)
            }else{
                if limit == false{
                    SVProgressHUD.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now()+10, execute: {
                        self?.getFavTeamMatches()
                    })
                }else{
                    SVProgressHUD.dismiss()
                    self?.favTeamMatches = returnedMatches
                }
            }
        }
    }
    func setupHeightConstraints(const1: CGFloat,const2: CGFloat,const3: CGFloat,title:String){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.searchHeightConstraint?.constant = const1
            self.calendarHeightConstraint?.constant = const2
            self.creditsHeightConstraint?.constant = const3
            self.view.layoutIfNeeded()
            self.navigationItem.title = title
            if title == self.favouriteTeamName ?? "No favourite team" {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.handleDelete))
                self.setupViewMenuBar()
            }
        }, completion: nil)
    }
    
    fileprivate func setupLiveMatches() {
        favTeamMatches?.removeAll()
        setupHeightConstraints(const1: 0, const2: 0, const3: 0, title: "Live Matches")
        collectionView.refreshControl = refreshControl
        getLiveMatches()
        fetchedCompetitionsNames.removeAll()
        self.tab.isUserInteractionEnabled = false
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
        view.viewWithTag(10000)?.removeFromSuperview()
        view.viewWithTag(20000)?.removeFromSuperview()
    }
    
    fileprivate func setupAllMatches() {
        setupHeightConstraints(const1: 0, const2: 80, const3: 0, title: "All Matches")
        collectionView.refreshControl = nil
        let t = Date()
        let tFormatter = DateFormatter()
        tFormatter.dateFormat = "yyyy-MM-dd"
        let df = tFormatter.string(from: t)
        self.matches.removeAll()
        collectionView.reloadData()
        self.tab.isUserInteractionEnabled = false
        getAllMatches(dateF: df, dateT: df)
//        DataService.instance.getFixtureIdForLineUps(date: df, homeName: "", awayName: "") { (connErr, connDesc, id) in
//        }
        cal.scrollToTodayDate()
        self.collectionView.reloadData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.handleSearch))
        self.setupViewMenuBar()
    }
    
    fileprivate func setupClubMatches() {
        collectionView.refreshControl = nil
        setupHeightConstraints(const1: 0, const2: 0, const3: 0, title: self.favouriteTeamName ?? "No favourite team")
        self.collectionView.reloadData()
        view.viewWithTag(10000)?.removeFromSuperview()
        view.viewWithTag(20000)?.removeFromSuperview()
        if fetchedTeamId != "" && self.favTeamMatches?.isEmpty ?? true{
            getFavTeamMatches()
            self.favTeamSelected = true
            collectionView.reloadData()
        }
    }
    
    fileprivate func setupHomePage() {
        self.hiddenSearch = false
        collectionView.refreshControl = nil
        fetchCoreDataObjects()
        self.collectionView.reloadData()
        view.viewWithTag(10000)?.removeFromSuperview()
        view.viewWithTag(20000)?.removeFromSuperview()
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.searchHeightConstraint?.constant = 60
            self.calendarHeightConstraint?.constant = 0
            self.creditsHeightConstraint?.constant = 30
            self.view.layoutIfNeeded()
            self.navigationItem.title = "Favoured leagues"
        }, completion: nil)
    }
    fileprivate func setupViewsForTabName() {
           switch tabName {
           case "live":
               setupLiveMatches()
           case "all" :
               setupAllMatches()
           case "club":
               setupClubMatches()
           default:
               setupHomePage()
           }
       }
    
//    fileprivate func setupBannerView() {
//        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//        bannerView.delegate = self
//        bannerView.adUnitID = "ca-app-pub-5116874595847249/7097237108"
//        bannerView.rootViewController = self
//    }
    fileprivate func setupStartApp() {
        fetchCoreDataObjects()
        fetchFavTeamCoreDataObjects()
        tab.size = barHeight
        tab.names = ["home","live","all","club"]
        tab.imageHeight = barImageHeight
        navigationItem.title = "Favoured leagues"
        view.setupBgColor()
        tab.translatesAutoresizingMaskIntoConstraints = false
        cal.translatesAutoresizingMaskIntoConstraints = false
        tab.home = self
        cal.home = self
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "leagueId")
        collectionView.register(LiveMatchCell.self, forCellWithReuseIdentifier: "liveId")
        collectionView.register(MatchCell.self, forCellWithReuseIdentifier: "matchId")
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCoreDataObjects()
        fetchFavTeamCoreDataObjects()
        if tabName == "home" && fetchedCompetitionsNames.isEmpty{
            showInstructionsAlert()
        }
//        bannerView.load(GADRequest())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(getLiveMatches), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.03529411765, green: 0.5058823529, blue: 0.2901960784, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Getting live matches")
//        setupBannerView()
//        addBannerViewToView(self.bannerView)
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.regular, .regular):
            setupRegularRegular()
            break
        default: setupIphone()
            break
        }
    }
//    fileprivate func addBannerViewToView(_ bannerView:GADBannerView){
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bannerView)
//            positionBannerViewFullWidthAtTopWithSafeArea(bannerView)
//    }
//    fileprivate func positionBannerViewFullWidthAtTopWithSafeArea(_ bannerView: UIView) {
//        bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        bannerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        bannerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//    }
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        bannerView.alpha = 0
//        UIView.animate(withDuration: 1, animations: {
//            bannerView.alpha = 1
//        })
//    }
    fileprivate func showInstructionsAlert(){
        let inst = UIAlertController(title: "Instructions", message: "Please type the country name NOT the league name in the search box", preferredStyle: .alert)
        inst.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            inst.dismiss(animated: true, completion: nil)
        }))
        self.present(inst, animated: true, completion: nil)
    }
    fileprivate func addSubviews() {
        view.addSubview(searchTeams)
        view.addSubview(collectionView)
        view.addSubview(tab)
        view.addSubview(cal)
        view.addSubview(creditsLbl)
    }
    fileprivate func setupSearchTeamsConstraints(){
//        searchTeams.topAnchor.constraint(equalTo: bannerView.bottomAnchor).isActive = true
        searchTeams.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchTeams.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchTeams.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchHeightConstraint = searchTeams.heightAnchor.constraint(equalToConstant: 60)
        searchHeightConstraint?.isActive = true
    }
    fileprivate func setupCalConstraints(){
        cal.topAnchor.constraint(equalTo: searchTeams.bottomAnchor).isActive = true
        cal.leadingAnchor.constraint(equalTo: searchTeams.leadingAnchor).isActive = true
        cal.trailingAnchor.constraint(equalTo: searchTeams.trailingAnchor).isActive = true
        calendarHeightConstraint = cal.heightAnchor.constraint(equalToConstant: 0)
        calendarHeightConstraint?.isActive = true
    }
    fileprivate func setupColViewConstraints() {
        collectionView.topAnchor.constraint(equalTo: cal.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: creditsLbl.topAnchor).isActive = true
    }
    fileprivate func setupCreditsLblConstraints(){
        creditsLbl.bottomAnchor.constraint(equalTo: tab.topAnchor).isActive = true
        creditsLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        creditsLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        creditsHeightConstraint = creditsLbl.heightAnchor.constraint(equalToConstant: 30)
        creditsHeightConstraint?.isActive = true
    }
    fileprivate func setupTabConstraints(){
        tab.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tab.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tab.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tabBarHeightConst = tab.heightAnchor.constraint(equalToConstant: 0)
        tabBarHeightConst?.isActive = true
    }
    fileprivate func setupViews() {
        addSubviews()
        setupSearchTeamsConstraints()
        setupCalConstraints()
        setupColViewConstraints()
        setupCreditsLblConstraints()
        setupTabConstraints()
    }
    fileprivate func populateAllMatchesArray() {
        SVProgressHUD.dismiss()
        matches.append(contentsOf: m)
        if matches.isEmpty{
            noMatchesCurrently = true
        }
        collectionView.reloadData()
        tab.isUserInteractionEnabled = true
    }
    fileprivate func getAllMatches(dateF : String, dateT : String){
        SVProgressHUD.show()
        view.viewWithTag(10000)?.removeFromSuperview()
        view.viewWithTag(20000)?.removeFromSuperview()
        let downloadGroup = DispatchGroup()
        let _ = DispatchQueue.global(qos: .userInitiated)
        DispatchQueue.concurrentPerform(iterations: fetchedCompetitionsIDs.count) { [weak self] (ind) in
            downloadGroup.enter()
            DataService.instance.getCompetitionMatches(id: fetchedCompetitionsIDs[ind], dateFrom: dateF, dateTo: dateT, completion: { [weak self] (returnedMatch, datesCount, limit,dF,dT,conn,connDesc)  in
                if let _ = conn, let desc = connDesc{
                    self?.setupNoConnectionViews(description: desc)
                    SVProgressHUD.dismiss()
                }else{
                    if limit == false{
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            self?.limitExceeded = true
                        }
                    } else {
                        self?.m.append(contentsOf: returnedMatch)
                        downloadGroup.leave()
                        SVProgressHUD.dismiss()
                    }
                }
            })
        }
        downloadGroup.notify(queue: .main) { [weak self] in
            self?.populateAllMatchesArray()
        }
    }
    @objc func getLiveMatches(){
        SVProgressHUD.show()
        DataService.instance.getLiveMatches { [weak self] (returnedLiveMatches, limit, count,conn2,connDesc2) in
            if let _ = conn2, let desc2 = connDesc2{
                SVProgressHUD.dismiss()
                self?.setupNoConnectionViews(description: desc2)
            }else{
                if limit == true && count > 0 {
                    self?.liveMatches = returnedLiveMatches
                    self?.collectionView.reloadData()
                    self?.liveCount = returnedLiveMatches.count
                    self?.tab.isUserInteractionEnabled = true
                    SVProgressHUD.dismiss()
                    self?.refreshControl.endRefreshing()
                } else if limit == false {
                    self?.refreshControl.endRefreshing()
                    DispatchQueue.main.asyncAfter(deadline: .now()+10, execute: {
                        self?.getLiveMatches()
                    })
                } else {
                    self?.liveCount = 0
                    self?.tab.isUserInteractionEnabled = true
                    SVProgressHUD.dismiss()
                    self?.refreshControl.endRefreshing()
                    DispatchQueue.main.async {
                        self?.setupNoLiveMatch()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                        self?.countLbl.removeFromSuperview()
                    })
                }
            }
        }
    }
    func setupNoLiveMatch(){
        view.addSubview(countLbl)
        countLbl.topAnchor.constraint(equalTo: (view.topAnchor)).isActive = true
        countLbl.leadingAnchor.constraint(equalTo: (view.leadingAnchor)).isActive = true
        countLbl.trailingAnchor.constraint(equalTo: (view.trailingAnchor)).isActive = true
        countLbl.bottomAnchor.constraint(equalTo: (view.bottomAnchor)).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tabName == "live"{
            return self.liveMatches.count
        }else if tabName == "all"{
            return self.matches.count
        }else if tabName == "club"{
            return favTeamMatches?.count ?? 0
        } else {
            return fetchedCompetitionsNames.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tabName == "live"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liveId", for: indexPath) as! LiveMatchCell
            cell.configureCell(match: liveMatches[indexPath.item], fSize: fontSize)
            return cell
        }else if tabName == "all" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchId", for: indexPath) as! MatchCell
            cell.configureCell(match: self.matches[indexPath.item], fSize: fontSize)
            return cell
            
        }else if tabName == "club"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liveId", for: indexPath) as! LiveMatchCell
            if let fTeamMat = favTeamMatches, !favTeamMatches!.isEmpty{
                cell.configureCell(match: fTeamMat[indexPath.item], fSize: fontSize)
            }else{
                cell.configureCell(match: LiveMatch(d: nil, comp: nil, stat: nil, matchD: 0, halfTimeHome: nil, halfTimeAway: nil, fullTimeHome: 0, fullTimeAway: 0, homeName: "", hId: nil, awayName: "", aId: nil, refree: "", mId: nil, mWinner: nil, compId: nil), fSize: fontSize)
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leagueId", for: indexPath) as! HomeCell
            cell.leagueName.text = fetchedCompetitionsNames[indexPath.item]
            cell.leagueName.font = UIFont.systemFont(ofSize: fontSize)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if tabName == "live"{
            return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - 20, height: 250)
        }else if tabName == "all"{
            if viewIsGrid{
                return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width - 20) / 2, height: 200)
            }else{
                return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - 20, height: 200)
            }
        }else if tabName == "club"{
            if viewIsGrid{
                return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width - 20) / 2, height: 200)
            }else{
                return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - 20, height: 200)
            }
        } else{
            return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - 20, height: 40)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 1, height: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 1, height: 20)
    }
    fileprivate func setupClubMatchRowSelected(_ indexPath: IndexPath) {
        let matchVC = MatchVC()
        matchVC.matchId = Int((self.favTeamMatches?[indexPath.item].matchId)!)
        matchVC.canSelectTeam = !self.favTeamSelected
        matchVC.fontSize = self.fontSize
        matchVC.deviceType = deviceType ?? ""
        let finalDate = (favTeamMatches?[indexPath.item].date)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:finalDate)!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fD1 = dateFormatter.string(from: date)
        matchVC.dateSearchedFor = fD1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.navigationController?.pushViewController(matchVC, animated: true)
        }, completion: nil)
    }
    
    fileprivate func setupLiveMatchRowSelected(_ indexPath: IndexPath) {
            let hName = self.liveMatches[indexPath.item].homeName
            let aName = self.liveMatches[indexPath.item].awayName
            let compName = self.liveMatches[indexPath.item].competition
            let t = Date()
            let tFormatter = DateFormatter()
            tFormatter.dateFormat = "yyyy-MM-dd"
            let df = tFormatter.string(from: t)
            let matchDetVC = MatchDetailsVC()
            matchDetVC.hName = hName
            matchDetVC.aName = aName
            matchDetVC.leagueName = compName
            matchDetVC.date = df
            matchDetVC.deviceType = deviceType ?? ""
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.navigationController?.pushViewController(matchDetVC, animated: true)
            }, completion: nil)
        
    }
    
    fileprivate func setupAllMatchesRowSelected(_ indexPath: IndexPath) {
        let matchVC = MatchVC()
        matchVC.matchId = self.matches[indexPath.item].matchId
        matchVC.canSelectTeam = !self.favTeamSelected
        matchVC.fontSize = self.fontSize
        matchVC.deviceType = deviceType ?? ""
        if let mD = matchDateToSearchFor{
            matchVC.dateSearchedFor = mD
        }else{
            matchVC.dateSearchedFor = selectedDay
        }
        if let s = compStart, let e = compEnd {
            matchVC.start = s[indexPath.item]
            matchVC.end = e[indexPath.item]
        }else{
            matchVC.start = nil
            matchVC.end = nil
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.navigationController?.pushViewController(matchVC, animated: true)
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Connectivity.isConnected{
            if tabName == "all"{
                    setupAllMatchesRowSelected(indexPath)
            }else if tabName == "club"{
                    setupClubMatchRowSelected(indexPath)
            }else if tabName == "live"{
                setupLiveMatchRowSelected(indexPath)
            }
        }else{
            setupNoConnectionViews(description: "Check internet connection")
        }
    }
  // MARK: - Core Data Saving support
    fileprivate func fetch(completion : (_ complete : Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let fetchRequest = NSFetchRequest<Competiton>(entityName: "Competiton")
        do{
            competitions = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch{
            debugPrint("Couldn't fetch\(error.localizedDescription)")
            completion(false)
        }
    }
    fileprivate func save(completion : (_ finished : Bool)->()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let competition = Competiton(context: managedContext)
        competition.id = id
        competition.name = compName
        do{
            try managedContext.save()
            completion(true)
        } catch{
            debugPrint("Couldn't Save: \(error.localizedDescription)")
            completion(false)
        }
    }
    fileprivate func fetchCoreDataObjects(){
        self.fetchedCompetitionsIDs.removeAll()
        self.fetchedCompetitionsNames.removeAll()
    self.fetch { (complete) in
        if complete{
            for competition in competitions {
                if let fetchedId = competition.id {
                    if fetchedCompetitionsIDs.contains(fetchedId) == false{
                        fetchedCompetitionsIDs.append(fetchedId)
                    }
                }
                if let fetchedName = competition.name {
                    if fetchedCompetitionsNames.contains(fetchedName) == false{
                        fetchedCompetitionsNames.append(fetchedName)
                    }
                }
            }
            self.collectionView.reloadData()
        } else {
        }
    }
}
    
    fileprivate func fetchFavTeam(completion : (_ complete : Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let fetchRequest = NSFetchRequest<FavouriteTeam>(entityName: "FavouriteTeam")
        do{
            favTeam = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch{
            debugPrint("Couldn't fetch\(error.localizedDescription)")
            completion(false)
        }
    }
    fileprivate func fetchFavTeamCoreDataObjects(){
        self.fetchedTeamId.removeAll()
        self.fetchedTeamName.removeAll()
        self.fetchFavTeam { (complete) in
            if complete{
                for team in favTeam {
                    if let fetchedId = team.id {
                        if fetchedTeamId.contains(fetchedId) == false{
                            fetchedTeamId.append(fetchedId)
                        }
                    }
                    if let fetchedName = team.name {
                        if fetchedTeamName.contains(fetchedName) == false{
                            fetchedTeamName.append(fetchedName)
                        }
                    }
                }
                self.collectionView.reloadData()
            } else {
            }
        }
    }
    fileprivate func removeFavTeam(){
        guard let fTeamMatches = favTeamMatches else{return}
        if favTeam.count>0 && !fTeamMatches.isEmpty{
            favTeamMatches?.removeAll()
            guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
            managedContext.delete(favTeam[0])
            do {
                try managedContext.save()
            } catch{
                debugPrint("Couldn't remove\(error.localizedDescription)")
            }
        }
        
    }
    // MARK: - searchBar delegate methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let name = searchBar.text {
            getCompId(n: name)
            
        }
        searchBar.text = ""
    }
    fileprivate func getCompId(n:String){
        SVProgressHUD.show()
        DataService.instance.getCompetitionID(name: n.capitalized) { [weak self] (id, name,start,end,limit,conn4,connDesc4)  in
            if let _ = conn4,let desc4 = connDesc4{
                self?.setupNoConnectionViews(description: desc4)
                SVProgressHUD.dismiss()
            }else{
                if limit == true {
                    self?.competitionNames.append(contentsOf: name)
                    SVProgressHUD.dismiss()
                    for i in id {
                        if !(self?.competitionsIDs.contains(i) ?? false){
                            self?.competitionsIDs.append(i)
                            self?.id = i
                            self?.compStart?.append(start)
                            self?.compEnd?.append(end)
                        }
                    }
                    for n in name{
                        self?.competitionNames.append(n)
                        self?.compName = n
                        
                    }
                    self?.save(completion: { (success) in
                        if !success {
                        } else {
                            self?.fetchCoreDataObjects()
                        }
                    })
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now()+10, execute: {
                        self?.getCompId(n: n)
                        SVProgressHUD.dismiss()
                    })
                }
            }
        }
    }
    fileprivate func setupNoConnectionViews(description: String){
        view.addSubview(noConnectionLbl)
        noConnectionLbl.text = description
        noConnectionLbl.bottomAnchor.constraint(equalTo: creditsLbl.topAnchor).isActive = true
        noConnectionLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        noConnectionLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        noConnectionLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tab.isUserInteractionEnabled = true
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.noConnectionLbl.removeFromSuperview()
        }
    }
    @objc func handleDelete(){
        if favTeamSelected{
            self.removeFavTeam()
            self.favTeamSelected = false
            showTeamRemovedAlert()
            navigationItem.title = "No favourite team"
            self.fetchFavTeamCoreDataObjects()
            self.collectionView.reloadData()
        }
    }
    @objc func handleViewBtn(){
        if !viewIsGrid{
            viewBtn.setImage(UIImage(named: "listFPro")?.withRenderingMode(.alwaysTemplate), for: .normal)
            viewIsGrid = !viewIsGrid
        }else{
            viewBtn.setImage(UIImage(named: "gridFPro")?.withRenderingMode(.alwaysTemplate), for: .normal)
            viewIsGrid = !viewIsGrid
        }
    }
    @objc func handleSearch(){
        var compNameField: UITextField?
        var dateField : UITextField?
        let searchAlert = UIAlertController(title: "Search", message: "Type country name & date", preferredStyle: .alert)
        searchAlert.addTextField { (textField) in
            textField.placeholder = "Country name or type 'all'"
            compNameField = textField
        }
        searchAlert.addTextField { (tField) in
            tField.placeholder = "Date format : YYYY-MM-DD"
            tField.delegate = self
            tField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
            dateField = tField
        }
        let search = UIAlertAction(title: "Search", style: .default) { (UIAlertAction) in
            if let dat = dateField?.text,dateField?.text != ""{
                self.matchDateToSearchFor = dat
            }
            if let cN = compNameField?.text, compNameField?.text != ""{
                self.compNameToGetId = cN
            }
        }
        let cancel = UIAlertAction(title: "cancel", style: .destructive) { (UIAlertAction) in
            searchAlert.dismiss(animated: true, completion: nil)
        }
        searchAlert.addAction(search)
        searchAlert.addAction(cancel)
        self.present(searchAlert, animated: true, completion: nil)
    }
    fileprivate func showTeamRemovedAlert(){
        let alert = UIAlertController(title: "Deleted", message: "favourite team was removed", preferredStyle: .alert)
        alert.setupAlertTintColor()
        alert.setValue(NSAttributedString(string: "Deleted", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func textDidChange(textField : UITextField){
        if textField.text?.count == 4 {
            var t1 = textField.text!
            t1 += "-"
            textField.text = t1
        }else if textField.text?.count == 7{
            var t2 = textField.text!
            t2 += "-"
            textField.text = t2
        }
    }
}
struct Connectivity {
    static let instance = NetworkReachabilityManager()!
    static var isConnected : Bool{
        return self.instance.isReachable
    }
}
