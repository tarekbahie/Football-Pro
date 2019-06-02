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

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class HomeVC: UIViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate{
    
    lazy var searchTeams : UISearchBar = {
        let sBar = UISearchBar()
        sBar.translatesAutoresizingMaskIntoConstraints = false
        sBar.delegate = self
        sBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        sBar.placeholder = "Enter country name here"
        let textFieldInsideSearchBar = sBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        sBar.tfBackgroundColor(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        return sBar
    }()
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.dataSource = self
        cView.delegate = self
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return cView
    }()
    let countLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.numberOfLines = 0
        lbl.text = "There are currently no live matches"
        return lbl
    }()
    
    var searchHeightConstraint : NSLayoutConstraint?
    var calendarHeightConstraint : NSLayoutConstraint?
    
    var liveMatches = [LiveMatch](){
        didSet{
            collectionView.reloadData()
        }
    }
    var hiddenSearch : Bool = false
    var liveCount = 0
    var tabName : String? {
        didSet {
            switch tabName {
            case "live":
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                    self.searchHeightConstraint?.constant = 0
                    self.calendarHeightConstraint?.constant = 0
                    self.view.layoutIfNeeded()
                    self.navigationItem.title = "Live Matches"
                }, completion: nil)
                getLiveMatches()
                self.matches.removeAll()
                self.m.removeAll()
                
                collectionView.reloadData()
                
            case "all" :
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                    self.searchHeightConstraint?.constant = 0
                    self.calendarHeightConstraint?.constant = 80
                    self.view.layoutIfNeeded()
                    self.navigationItem.title = "All Matches"
                }, completion: nil)
                self.matches.removeAll()
                self.m.removeAll()
                let t = Date()
                let tFormatter = DateFormatter()
                tFormatter.dateFormat = "yyyy-MM-dd"
                let df = tFormatter.string(from: t)
                getAllMatches(dateF: df, dateT: df)
                cal.scrollToTodayDate()
                self.collectionView.reloadData()
                
            case "club":
                print("club")
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                    self.searchHeightConstraint?.constant = 0
                    self.calendarHeightConstraint?.constant = 0
                    self.view.layoutIfNeeded()
                    self.navigationItem.title = "Favourite"
                }, completion: nil)
                self.matches.removeAll()
                self.m.removeAll()
                
                
                
            default:
                print("home")
                self.hiddenSearch = false
                self.matches.removeAll()
                self.m.removeAll()
                self.collectionView.reloadData()
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                    self.searchHeightConstraint?.constant = 60
                    self.calendarHeightConstraint?.constant = 0
                    self.view.layoutIfNeeded()
                    self.navigationItem.title = "Favoured leagues"
                }, completion: nil)
                
            }
            
        }
    }
    var selectedDay : String?{
        didSet{
            getAllMatches(dateF: selectedDay!, dateT: selectedDay!)
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
    var today21 = Date(){
        didSet{
            print(today21)
        }
    }
    var fetchedCompetitionsNames = [String](){
        didSet {
            collectionView.reloadData()
        }
    }
    var matches = [Match](){
        didSet{
            m.removeAll()
            collectionView.reloadData()
            print(matches)
        }
    }
    var limitExceeded : Bool?{
        didSet{
            if limitExceeded ?? false{
                limitLblDisplay(message: "Server is not responding. please try again later")
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
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        return lbl
    }()
    func limitLblDisplay(message : String){
        view.addSubview(errorLbl)
        errorLbl.text = message
        errorLbl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        errorLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        errorLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        errorLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.errorLbl.removeFromSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationItem.title = "Favoured leagues"
        view.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
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
    }
    func setupViews() {
        view.addSubview(searchTeams)
        view.addSubview(collectionView)
        view.addSubview(tab)
        view.addSubview(cal)
//        view.addSubview(calender)
        searchTeams.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchTeams.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchTeams.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        searchTeams.heightAnchor.constraint(equalToConstant: 60).isActive = true
        searchHeightConstraint = searchTeams.heightAnchor.constraint(equalToConstant: 60)
        searchHeightConstraint?.isActive = true
        
        cal.topAnchor.constraint(equalTo: searchTeams.bottomAnchor).isActive = true
        cal.leadingAnchor.constraint(equalTo: searchTeams.leadingAnchor).isActive = true
        cal.trailingAnchor.constraint(equalTo: searchTeams.trailingAnchor).isActive = true
        calendarHeightConstraint = cal.heightAnchor.constraint(equalToConstant: 0)
        calendarHeightConstraint?.isActive = true
        
        collectionView.topAnchor.constraint(equalTo: cal.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: searchTeams.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: searchTeams.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: tab.topAnchor).isActive = true
        
        tab.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tab.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tab.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tab.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    
    func getAllMatches(dateF : String, dateT : String){
        SVProgressHUD.show()
        self.m.removeAll()
        self.matches.removeAll()
        let downloadGroup = DispatchGroup()
        let _ = DispatchQueue.global(qos: .userInitiated)
        DispatchQueue.concurrentPerform(iterations: fetchedCompetitionsIDs.count) { [unowned self] (ind) in
            downloadGroup.enter()
            DataService.instance.getCompetitionMatches(id: fetchedCompetitionsIDs[ind], dateFrom: dateF, dateTo: dateT, completion: { [weak self] (returnedMatch, datesCount, limit,dF,dT)  in
                if limit == false{
//                    self?.limitExceeded = true
//                    SVProgressHUD.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now()+10, execute: {
                        self?.getAllMatches(dateF: dF, dateT: dT)
                    })
                } else {
                    self?.m = returnedMatch
                    downloadGroup.leave()
                }
            })
        }
        downloadGroup.notify(queue: .main) {
            SVProgressHUD.dismiss()
            self.matches = self.m
            if self.matches.isEmpty{
                self.noMatchesCurrently = true
            }
            self.m.removeAll()
            self.collectionView.reloadData()
        }
    }
    
    func getLiveMatches(){
        DataService.instance.getLiveMatches { [weak self] (returnedLiveMatches, limit, count) in
            if limit == true && count > 0 {
                self?.liveMatches = returnedLiveMatches
                self?.collectionView.reloadData()
                self?.liveCount = returnedLiveMatches.count
            } else if limit == false {
                self?.limitExceeded = true
            } else {
                self?.noMatchesCurrently = true
                self?.liveCount = 0
                DispatchQueue.main.async {
                    self?.view.addSubview((self?.countLbl)!)
                    self?.countLbl.topAnchor.constraint(equalTo: (self?.view.topAnchor)!).isActive = true
                    self?.countLbl.leadingAnchor.constraint(equalTo: (self?.view.leadingAnchor)!).isActive = true
                    self?.countLbl.trailingAnchor.constraint(equalTo: (self?.view.trailingAnchor)!).isActive = true
                    self?.countLbl.bottomAnchor.constraint(equalTo: (self?.view.bottomAnchor)!).isActive = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self?.countLbl.removeFromSuperview()
                })
            }
        }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tabName == "live"{
            return self.liveMatches.count
        }else if tabName == "all"{
            return self.matches.count
//            return 3
        } else {
            return fetchedCompetitionsNames.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tabName == "live"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liveId", for: indexPath) as! LiveMatchCell
            cell.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
            cell.configureCell(match: liveMatches[indexPath.item])
            return cell
        }else if tabName == "all" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchId", for: indexPath) as! MatchCell
            cell.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
            
            let matchId = matches[indexPath.item].matchId
            DataService.instance.getMatchDataFor(id: matchId) { (_, _, _, _, _, _, _, cName, _, _, _, _, _, _, limit) in
                if !limit{
                    self.limitExceeded = true
                } else{
                    cell.configureCell(match: self.matches[indexPath.item], compName: cName)
                }
            }
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leagueId", for: indexPath) as! HomeCell
            cell.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
            cell.leagueName.text = fetchedCompetitionsNames[indexPath.item]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if tabName == "live"{
            return CGSize(width: view.frame.width, height: 250)
        }else if tabName == "all"{
            return CGSize(width: view.frame.width, height: 200)
        } else{
            return CGSize(width: view.frame.width, height: 40)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if tabName == "all"{
            let matchVC = MatchVC()
            matchVC.matchId = matches[indexPath.item].matchId
            matches.removeAll()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.navigationController?.pushViewController(matchVC, animated: true)
            }, completion: nil)
        }
    }
    
    // MARK: - Calendar datasource and delegate methods
    
    

    
    
  // MARK: - Core Data Saving support
    func fetch(completion : (_ complete : Bool)->()){
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
    func save(completion : (_ finished : Bool)->()) {
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
    func fetchCoreDataObjects(){
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
    // MARK: - searchBar delegate methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let name = searchBar.text {
            DataService.instance.getCompetitionID(name: name) { (id, name, limit) in
                if limit == true {
                    self.competitionNames.append(contentsOf: name)
                    for i in id {
                        if !self.competitionsIDs.contains(i){
                            self.competitionsIDs.append(i)
                            self.id = i
                        }
                    }
                    for n in name{
                            self.competitionNames.append(n)
                            self.compName = n
                        
                    }
                    self.save(completion: { (success) in
                        if !success {
                            print("error Saving !")
                        } else {
                            self.fetchCoreDataObjects()
                        }
                    })
                } else {
                    self.limitExceeded = true
                }
            }
            
        }
        searchBar.text = ""
    }
}
extension UISearchBar {
    
    func tfBackgroundColor(color: UIColor){
        for view in self.subviews {
            for subview in view.subviews {
                if subview is UITextField {
                    let textField: UITextField = subview as! UITextField
                    textField.backgroundColor = color
                }
            }
        }
    }
}
