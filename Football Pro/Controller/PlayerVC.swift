//
//  PlayerVC.swift
//  Football Pro
//
//  Created by tarek bahie on 6/1/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class PlayerVC: UIViewController{
    let playerImage : UIImageView={
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "playerDefault")
        img.contentMode = .scaleAspectFit
        img.setupTintColor()
        return img
    }()
    let playerSummaryLbl : UITextView = {
        let lbl = UITextView()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setupAttrib()
        return lbl
    }()
    var playerToShow : String?{
        didSet{
            SVProgressHUD.show()
            getPlayerData()
        }
    }
    var stringUrl : String?{
        didSet{
            guard let u = URL(string: stringUrl ?? "") else{return}
            DispatchQueue.main.async {
                self.playerImage.sd_setImage(with: u, placeholderImage: UIImage(named: "playerDefault")?.withRenderingMode(.alwaysTemplate), options: [], completed: nil)
            }
        }
    }
    var extract : String?{
        didSet{
            self.playerSummaryLbl.text = extract!
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
    var fontSize:CGFloat?{
        didSet{
            if let fS = fontSize{
                setupFonts(size: fS)
            }
        }
    }
    fileprivate func setupFonts(size:CGFloat){
        playerSummaryLbl.font = UIFont.systemFont(ofSize: size)
        
    }
    fileprivate func setupViews(){
        view.addSubview(playerImage)
        view.addSubview(playerSummaryLbl)
        
        playerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        playerImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        playerImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        playerImage.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        
        playerSummaryLbl.topAnchor.constraint(equalTo: playerImage.bottomAnchor).isActive = true
        playerSummaryLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        playerSummaryLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        playerSummaryLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setupBgColor()
        setupViews()
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
    fileprivate func getPlayerData() {
        SVProgressHUD.show()
        DataService.instance.requestPlayerImage(withName: playerToShow!) { [weak self] (picUrl, sumary,conn,connDesc)  in
            if let _ = conn,let connDescription = connDesc{
                self?.setupNoConnectionViews(description: connDescription)
            }else{
                self?.stringUrl = picUrl
                if sumary != ""{
                    self?.extract = sumary
                }else{
                    self?.extract = "No data available yet !"
                }
                SVProgressHUD.dismiss()
            }
        }
    }
}
