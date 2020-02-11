//
//  MatchVC.swift
//  Football Pro
//
//  Created by tarek bahie on 5/30/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import SDWebImageSVGCoder

class MatchVC : UIViewController {
    
    lazy var teamOneImg : UIImageView = {
        let img = UIImageView()
        img.image = nil
        img.translatesAutoresizingMaskIntoConstraints = false
        img.setupTintColor()
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHomeInfoForImg)))
        img.contentMode = .scaleAspectFit
        return img
    }()
    lazy var teamTwoImg : UIImageView = {
        let img = UIImageView()
        img.image = nil
        img.translatesAutoresizingMaskIntoConstraints = false
        img.setupTintColor()
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAwayInfoForImg)))
        img.contentMode = .scaleAspectFit
        return img
    }()
    lazy var compLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.isUserInteractionEnabled = true
        lbl.setupOutline()
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCompInfo)))
        return lbl
    }()
    let wdlLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "W/D/L"
        lbl.setupBasicAttributes()
        return lbl
    }()
    let venueLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        return lbl
    }()
    let matchdayLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        return lbl
    }()
    let scoreLbl : UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        return lbl
    }()
    let hwdlLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        return lbl
    }()
    let awdlLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        return lbl
    }()
    let homeScoreLbl:UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        return lbl
    }()
    let awayScoreLbl:UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        return lbl
    }()
    lazy var homeNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHomeInfoForLbl)))
        lbl.setupOutline()
        return lbl
    }()
    lazy var detailsLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getMatchDataForFixture)))
        lbl.setupOutline()
        return lbl
    }()
    lazy var awayNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAwayInfoForLbl)))
        lbl.setupOutline()
        return lbl
    }()
    
    var limitExceeded : Bool?{
        didSet{
            if limitExceeded ?? false{
                limitLblDisplay(message: "Server is not responding. please try again later")
            }
        }
    }
    let errorLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.setupBasicAttributes()
        return lbl
    }()
    var matchId : Int?{
        didSet{
            getMatchData()
        }
    }
    let noConnectionLbl : UILabel={
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupBasicAttributes()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.setupBgColor()
        return lbl
    }()
    var dateSearchedFor : String?{
        didSet{
            
        }
    }
    var leagueId = ""
    var homeCrest : String?{
        didSet{
            guard let aCrest = homeCrest else{return}
            if let u = URL(string: aCrest),homeCrest != ""{
                setTeamLogo(url: u, teamImg: teamOneImg)
            }else{
                self.teamOneImg.image = UIImage(named: "default")
            }
        }
    }
    var awayCrest : String?{
        didSet{
            guard let aCrest = awayCrest else{return}
            if let u = URL(string: aCrest),awayCrest != ""{
                setTeamLogo(url: u, teamImg: teamTwoImg)
            }else{
                self.teamTwoImg.image = UIImage(named: "default")
            }
            
        }
    }
    var homeTeamId : String?
    var awayTeamId : String?
    var canSelectTeam : Bool = false
    var fontSize:CGFloat?{
        didSet{
            if let fS = fontSize{
                setupFonts(size: fS)
            }
        }
    }
    var deviceType:String?
    var fixIdToGetLineUps: String?
    var detailsHeightConstr : NSLayoutConstraint?
    var detailsWidthConstr : NSLayoutConstraint?
    var myDate:Date?
    var start:String?
    var end:String?
    
    fileprivate func limitLblDisplay(message : String){
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
    fileprivate func setupDateLbl(date:String) {
        let finalDate1 = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        myDate = dateFormatter.date(from: finalDate1)!
        let now = Date()
        if now < myDate!{
            self.homeScoreLbl.isHidden = true
            self.awayScoreLbl.isHidden = true
            let components = Calendar.current.dateComponents([.day,.hour,.minute], from: Date(), to: myDate!)
            if let day = components.day,let hour = components.hour,let min = components.minute{
                self.scoreLbl.text = "\(day):\(hour):\(min)"
            }else{
                self.scoreLbl.text = ""
            }
        }else{
            self.homeScoreLbl.isHidden = false
            self.awayScoreLbl.isHidden = false
            self.scoreLbl.text = "Final Score"
        }
    }
    fileprivate func updateLabelsTxt(_ venueDay: [String], _ homeWin: String, _ homeDraw: String, _ homeLoss: String, _ awayWin: String, _ awayDraw: String, _ awayLoss: String, _ homeName: String, _ awayName: String, _ compName: String, _ compId: String, _ homeId: String, _ awayId: String, _ hScore: String, _ aScore: String, _ date: String) {
        DispatchQueue.main.async {
            self.venueLbl.text = venueDay[0]
            if let d = self.dateSearchedFor{
                self.matchdayLbl.text = "MatchDay : \(venueDay[1]) / \(d)"
            }else{
                self.matchdayLbl.text = "MatchDay : \(venueDay[1])"
            }
            self.hwdlLbl.text = "\(homeWin)/\(homeDraw)/\(homeLoss)"
            self.awdlLbl.text = "\(awayWin)/\(awayDraw)/\(awayLoss)"
            self.homeNameLbl.text = homeName
            self.awayNameLbl.text = awayName
            self.detailsLbl.text = "details"
            self.compLbl.text = compName
            self.leagueId = compId
            self.homeTeamId = homeId
            self.awayTeamId = awayId
            self.homeScoreLbl.text = hScore
            self.awayScoreLbl.text = aScore
            self.setupDateLbl(date: date)
            
            
        }
    }
    @objc func getMatchDataForFixture(){
            let matchDetVC = MatchDetailsVC()
        guard let hN = homeNameLbl.text, let aN = awayNameLbl.text, let vN = venueLbl.text else{return}
            matchDetVC.hName = hN
            matchDetVC.aName = aN
            matchDetVC.vName = vN
            matchDetVC.leagueName = compLbl.text
            matchDetVC.deviceType = deviceType ?? ""
            if let datSearched = dateSearchedFor{
            matchDetVC.date = datSearched
            }else{
                let t = Date()
                let tFormatter = DateFormatter()
                tFormatter.dateFormat = "yyyy-MM-dd"
                let df = tFormatter.string(from: t)
                matchDetVC.date = df
            }
            self.navigationController?.pushViewController(matchDetVC, animated: true)
    }
    
    fileprivate func getHomeTeamLogo(_ homeName: String, _ compId: String) {
        SVProgressHUD.show()
        DataService.instance.getLogoFor(teamName: homeName, leagueId: compId, completion: {[weak self] (homeURLString, limit, legueCode,conn2,connDesc2) in
            if let _ = conn2, let description2 = connDesc2{
                SVProgressHUD.dismiss()
                self?.setupNoConnectionViews(description: description2)
            }else{
                if limit{
                    self?.homeCrest = homeURLString
                    SVProgressHUD.dismiss()
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now()+10, execute: {
                        SVProgressHUD.dismiss()
                        self?.getMatchData()
                    })
                }
            }
        })
    }
    
    fileprivate func getAwayTeamLogo(_ awayName: String, _ compId: String) {
        SVProgressHUD.show()
        DataService.instance.getLogoFor(teamName: awayName, leagueId: compId, completion: {[weak self] (awayURLString, limit, leagueCode,conn3,connDesc3) in
            if let _ = conn3, let desc3 = connDesc3{
                SVProgressHUD.dismiss()
                self?.setupNoConnectionViews(description: desc3)
            }else{
                if limit{
                    self?.awayCrest = awayURLString
                    SVProgressHUD.dismiss()
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now()+10, execute: {
                        SVProgressHUD.dismiss()
                        self?.getMatchData()
                    })
                }
            }
        })
    }
    fileprivate func getMatchData(){
        SVProgressHUD.show()
        DataService.instance.getMatchDataFor(id: matchId!) {[weak self] (venueDay, homeWin, homeDraw, homeLoss, awayWin, awayDraw, awayLoss, compName, homeName, awayName, date, compId, homeId, awayId,hScore,aScore,win ,limit,conn,connDesc)  in
            if let _ = conn, let description = connDesc{
                self?.setupNoConnectionViews(description: description)
            }else{
                if limit {
                    self?.updateLabelsTxt(venueDay, homeWin, homeDraw, homeLoss, awayWin, awayDraw, awayLoss, homeName, awayName, compName, compId, homeId, awayId, hScore, aScore, date)
                    self?.getHomeTeamLogo(homeName, compId)
                    self?.getAwayTeamLogo(awayName, compId)
                    SVProgressHUD.dismiss()
                } else{
                    DispatchQueue.main.asyncAfter(deadline: .now()+10, execute: {
                        self?.getMatchData()
                    })
                }
            }
        }
    }
    fileprivate func setTeamLogo(url : URL,teamImg : UIImageView){
        if url.absoluteString != "http://upload.wikimedia.org/wikipedia/de/5/5c/Chelsea_crest.svg"{
        SVProgressHUD.show()
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        let imageView = UIImageView()
        imageView.sd_setImage(with: url)
        let w = UIScreen.main.bounds.height / 4
        let h:CGFloat = 200
        let SVGImageSize = CGSize(width: w, height: h)
        DispatchQueue.main.async {
            teamImg.sd_setImage(with: url, placeholderImage: UIImage(named: "default")?.withRenderingMode(.alwaysTemplate), options: [], context: [.svgImageSize : SVGImageSize])
            SVProgressHUD.dismiss()
        }
        }else{
            teamImg.image = UIImage(named: "chelsea")
        }
    }
    fileprivate func setupFonts(size:CGFloat){
        compLbl.font = UIFont.systemFont(ofSize: size)
        wdlLbl.font = UIFont.systemFont(ofSize: size)
        venueLbl.font = UIFont.systemFont(ofSize: size)
        matchdayLbl.font = UIFont.systemFont(ofSize: size)
        hwdlLbl.font = UIFont.systemFont(ofSize: size)
        awdlLbl.font = UIFont.systemFont(ofSize: size)
        homeScoreLbl.font = UIFont.systemFont(ofSize: size)
        awayScoreLbl.font = UIFont.systemFont(ofSize: size)
        homeNameLbl.font = UIFont.systemFont(ofSize: size)
        awayNameLbl.font = UIFont.systemFont(ofSize: size)
        detailsLbl.font = UIFont.systemFont(ofSize: size)
        scoreLbl.font = UIFont.systemFont(ofSize: size)
        detailsLbl.font = UIFont.systemFont(ofSize: size)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setupBgColor()
        setupViews()
    }
    fileprivate func updateUIConstraints(_ width: CGFloat) {
        homeNameLbl.widthAnchor.constraint(equalTo: teamOneImg.widthAnchor).isActive = true
        awayNameLbl.widthAnchor.constraint(equalTo: teamTwoImg.widthAnchor).isActive = true
        detailsWidthConstr?.constant = width
        teamOneImg.widthAnchor.constraint(equalToConstant: width).isActive = true
        compLbl.widthAnchor.constraint(equalToConstant: width).isActive = true
        teamTwoImg.widthAnchor.constraint(equalToConstant: width).isActive = true
        hwdlLbl.widthAnchor.constraint(equalTo: teamOneImg.widthAnchor).isActive = true
        awdlLbl.widthAnchor.constraint(equalTo: teamTwoImg.widthAnchor).isActive = true
        homeScoreLbl.widthAnchor.constraint(equalTo: teamOneImg.widthAnchor).isActive = true
        awayScoreLbl.widthAnchor.constraint(equalTo: teamTwoImg.widthAnchor).isActive = true
        homeNameLbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
        detailsHeightConstr?.constant = 80
        awayNameLbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
        compLbl.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    fileprivate func setupViews(){
        let stack1 = UIStackView(arrangedSubviews: [homeNameLbl,awayNameLbl])
        let stack2 = UIStackView(arrangedSubviews: [teamOneImg,compLbl,teamTwoImg])
        let stack3 = UIStackView(arrangedSubviews: [hwdlLbl,wdlLbl,awdlLbl])
        let stack4 = UIStackView(arrangedSubviews: [homeScoreLbl,scoreLbl,awayScoreLbl])
        stack1.distribution = .equalSpacing
        stack1.axis = .horizontal
        stack2.distribution = .equalSpacing
        stack2.axis = .horizontal
        stack3.distribution = .equalSpacing
        stack3.axis = .horizontal
        stack4.distribution = .equalSpacing
        stack4.axis = .horizontal
        
        let stack = UIStackView(arrangedSubviews: [stack1,stack2,stack3,venueLbl,matchdayLbl,stack4])
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        view.addSubview(detailsLbl)
        
        let width = UIScreen.main.bounds.width/4
        
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 5).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -5).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5).isActive = true
        
        detailsLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5).isActive = true
        detailsLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        detailsHeightConstr = detailsLbl.heightAnchor.constraint(equalToConstant: 0)
        detailsHeightConstr?.isActive = true
        detailsWidthConstr = detailsLbl.widthAnchor.constraint(equalToConstant: 0)
        detailsWidthConstr?.isActive = true
        
        updateUIConstraints(width)
    }

    
    @objc func handleHomeInfoForLbl(){
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            self.homeNameLbl.transform = CGAffineTransform(scaleX: 0.97, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                self.homeNameLbl.transform = CGAffineTransform.identity
                                if Connectivity.isConnected{
                                    self.setupTeamDetails(homeOrAway: "home")
                                }else{
                                    self.setupNoConnectionViews(description: "Check internet connection")
                                }
                                
                            })
        })
    }
    @objc func handleHomeInfoForImg(){
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            self.teamOneImg.transform = CGAffineTransform(scaleX: 0.97, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                self.teamOneImg.transform = CGAffineTransform.identity
                                if Connectivity.isConnected{
                                    self.setupTeamDetails(homeOrAway: "home")
                                }else{
                                    self.setupNoConnectionViews(description: "Check internet connection")
                                }
                                
                            })
        })
    }
    fileprivate func setupTeamDetails(homeOrAway : String) {
        let teamDVC = TeamDetailVC()
        if homeOrAway == "home"{
            teamDVC.teamId = self.homeTeamId
        }else{
            teamDVC.teamId = self.awayTeamId
        }
        teamDVC.leagueId = self.leagueId
        teamDVC.canAddFav = self.canSelectTeam
        teamDVC.fontSize = self.fontSize!
        if self.awayTeamId != nil && self.leagueId != ""{
                self.navigationController?.pushViewController(teamDVC, animated: true)
        }
    }
    
    @objc func handleAwayInfoForLbl(){
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            self.awayNameLbl.transform = CGAffineTransform(scaleX: 0.97, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                self.awayNameLbl.transform = CGAffineTransform.identity
                                if Connectivity.isConnected{
                                    self.setupTeamDetails(homeOrAway: "away")
                                }else{
                                    self.setupNoConnectionViews(description: "Check internet connection")
                                }
                                
                            })
        })
    }
    @objc func handleAwayInfoForImg(){
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            self.teamTwoImg.transform = CGAffineTransform(scaleX: 0.97, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                self.teamTwoImg.transform = CGAffineTransform.identity
                                if Connectivity.isConnected{
                                    self.setupTeamDetails(homeOrAway: "away")
                                }else{
                                    self.setupNoConnectionViews(description: "Check internet connection")
                                }
                                
                            })
        })
    }
    @objc func handleCompInfo(){
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            self.compLbl.transform = CGAffineTransform(scaleX: 0.97, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                self.compLbl.transform = CGAffineTransform.identity
                                if Connectivity.isConnected{
                                    let compVC = CompVC()
                                    compVC.canAddTeamToFavs = self.canSelectTeam
                                    compVC.league = self.leagueId
                                    compVC.fontSize = self.fontSize!
                                    if self.leagueId != ""{
                                            self.navigationController?.pushViewController(compVC, animated: true)
                                    }
                                }else{
                                    self.setupNoConnectionViews(description: "Check internet connection")
                                }
                                
                            })
        })
        
        
    }
    fileprivate func setupNoConnectionViews(description : String){
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
