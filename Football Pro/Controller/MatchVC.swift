//
//  MatchVC.swift
//  Football Pro
//
//  Created by tarek bahie on 5/30/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
import SDWebImage
class MatchVC : UIViewController {
    
    lazy var teamOneImg : UIImageView = {
        let img = UIImageView()
        img.image = nil
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 50.0
        img.layer.masksToBounds = true
        img.tintColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHomeInfo)))
        return img
    }()
    lazy var teamTwoImg : UIImageView = {
        let img = UIImageView()
        img.image = nil
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 50.0
        img.layer.masksToBounds = true
        img.tintColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAwayInfo)))
        return img
    }()
    lazy var compLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.isUserInteractionEnabled = true
        lbl.layer.borderWidth = 1.0
        lbl.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1).cgColor
        lbl.layer.cornerRadius = 8.0
        lbl.layer.masksToBounds = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCompInfo)))
        return lbl
    }()
    let wdlLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "W/D/L"
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let venueLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let matchdayLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let hwdlLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    let awdlLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return lbl
    }()
    lazy var homeNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.numberOfLines = 0
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHomeInfo)))
        return lbl
    }()
    lazy var awayNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.numberOfLines = 0
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAwayInfo)))
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
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
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
    
    var matchId : Int?{
        didSet{
            DataService.instance.getMatchDataFor(id: matchId!) { (venueDay, homeWin, homeDraw, homeLoss, awayWin, awayDraw, awayLoss, compName, homeName, awayName, date, compId, homeId, awayId, limit) in
                if limit {
                    DispatchQueue.main.async {
                        self.venueLbl.text = venueDay[0]
                        self.matchdayLbl.text = "MatchDay : \(venueDay[1])"
                        self.hwdlLbl.text = "\(homeWin)/\(homeDraw)/\(homeLoss)"
                        self.awdlLbl.text = "\(awayWin)/\(awayDraw)/\(awayLoss)"
                        self.homeNameLbl.text = homeName
                        self.awayNameLbl.text = awayName
                        self.compLbl.text = compName
                        self.leagueId = compId
                        self.homeTeamId = homeId
                        self.awayTeamId = awayId
                    }
                    DataService.instance.getLogoFor(teamName: homeName, leagueId: compId, completion: { (homeURLString, limit, legueCode) in
                        if limit{
                            self.homeCrest = homeURLString
                        }else{
                            self.limitExceeded = true
                        }
                    })
                    DataService.instance.getLogoFor(teamName: awayName, leagueId: compId, completion: { (awayURLString, limit, leagueCode) in
                        if limit{
                            self.awayCrest = awayURLString
                        }else{
                            self.limitExceeded = true
                        }
                    })
                } else{
                    self.limitExceeded = true
                }
            }
        }
    }
    var leagueId = ""
    
    var homeCrest : String?{
        didSet{
            let url = URL(string: homeCrest!)
            guard let u = url else{
                self.teamOneImg.image = UIImage(named: "default")?.withRenderingMode(.alwaysTemplate)
                return
            }
            self.teamOneImg.sd_setImage(with: u, placeholderImage: UIImage(named: "default")?.withRenderingMode(.alwaysTemplate), options: SDWebImageOptions.delayPlaceholder, completed: nil)
            
        }
    }
    
    
    var awayCrest : String?{
        didSet{
            let url = URL(string: awayCrest!)
            guard let u = url else{
                self.teamTwoImg.image = UIImage(named: "default")?.withRenderingMode(.alwaysTemplate)
                return
            }
            self.teamTwoImg.sd_setImage(with: u, placeholderImage: UIImage(named: "default")?.withRenderingMode(.alwaysTemplate), options: SDWebImageOptions.delayPlaceholder, completed: nil)
            
        }
    }
    var homeTeamId : String?
    var awayTeamId : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.1725490196, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        setupViews()
    }
    func setupViews(){
        view.addSubview(homeNameLbl)
        view.addSubview(awayNameLbl)
        view.addSubview(venueLbl)
        view.addSubview(matchdayLbl)
        view.addSubview(hwdlLbl)
        view.addSubview(awdlLbl)
        view.addSubview(teamOneImg)
        view.addSubview(teamTwoImg)
        view.addSubview(wdlLbl)
        view.addSubview(compLbl)
        
        
        homeNameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant:10).isActive = true
        homeNameLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:10).isActive = true
        homeNameLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        homeNameLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        awayNameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant:10).isActive = true
        awayNameLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-10).isActive = true
        awayNameLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        awayNameLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        teamOneImg.topAnchor.constraint(equalTo: homeNameLbl.bottomAnchor,constant:10).isActive = true
        teamOneImg.leadingAnchor.constraint(equalTo: homeNameLbl.leadingAnchor).isActive = true
        teamOneImg.widthAnchor.constraint(equalToConstant: 100).isActive = true
        teamOneImg.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        teamTwoImg.topAnchor.constraint(equalTo: homeNameLbl.bottomAnchor,constant:10).isActive = true
        teamTwoImg.leadingAnchor.constraint(equalTo: awayNameLbl.leadingAnchor).isActive = true
        teamTwoImg.widthAnchor.constraint(equalToConstant: 100).isActive = true
        teamTwoImg.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        hwdlLbl.topAnchor.constraint(equalTo: teamOneImg.bottomAnchor,constant:10).isActive = true
        hwdlLbl.leadingAnchor.constraint(equalTo: teamOneImg.leadingAnchor).isActive = true
        hwdlLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        hwdlLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        compLbl.centerYAnchor.constraint(equalTo: teamOneImg.centerYAnchor).isActive = true
        compLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        compLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        compLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        wdlLbl.topAnchor.constraint(equalTo: hwdlLbl.topAnchor).isActive = true
        wdlLbl.widthAnchor.constraint(equalToConstant: 60).isActive = true
        wdlLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        wdlLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        awdlLbl.topAnchor.constraint(equalTo: teamTwoImg.bottomAnchor,constant:10).isActive = true
        awdlLbl.leadingAnchor.constraint(equalTo: teamTwoImg.leadingAnchor).isActive = true
        awdlLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        awdlLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        venueLbl.topAnchor.constraint(equalTo: wdlLbl.bottomAnchor,constant:10).isActive = true
        venueLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        venueLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        venueLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        matchdayLbl.topAnchor.constraint(equalTo: venueLbl.bottomAnchor,constant:10).isActive = true
        matchdayLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        matchdayLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        matchdayLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    @objc func handleHomeInfo(){
        let teamDVC = TeamDetailVC()
        teamDVC.teamId = self.homeTeamId
        teamDVC.leagueId = self.leagueId
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.navigationController?.pushViewController(teamDVC, animated: true)
        }, completion: nil)
    }
    @objc func handleAwayInfo(){
        let teamDVC = TeamDetailVC()
        teamDVC.teamId = self.awayTeamId
        teamDVC.leagueId = self.leagueId
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.navigationController?.pushViewController(teamDVC, animated: true)
        }, completion: nil)
    }
    @objc func handleCompInfo(){
        let compVC = CompVC()
        compVC.league = self.leagueId
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.navigationController?.pushViewController(compVC, animated: true)
        }, completion: nil)
        
    }
}
