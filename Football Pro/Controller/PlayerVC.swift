//
//  PlayerVC.swift
//  Football Pro
//
//  Created by tarek bahie on 6/1/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//


//DataService.instance.requestPlayerImage(withName: "gareth bale") { (url,sumary)  in
//    print("url of wiki image is : \(url)")
//    print(sumary)
//}
import UIKit
import SDWebImage
class PlayerVC: UIViewController{
    let playerImage : UIImageView={
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "playerDefault")
        img.contentMode = .scaleToFill
        img.tintColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return img
    }()
    let playerSummaryLbl : UITextView = {
        let lbl = UITextView()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = #colorLiteral(red: 0.9529411765, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        lbl.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2470588235, alpha: 1)
        lbl.textAlignment = .center
        lbl.isScrollEnabled = true
        return lbl
    }()
    
    var playerToShow : Player?{
        didSet{
            DataService.instance.requestPlayerImage(withName: playerToShow!.name) { (picUrl, sumary) in
                self.stringUrl = picUrl
                if sumary != ""{
                    self.extract = sumary
                }else{
                    self.extract = "No data available yet !"
                }
            }
        }
    }
    var stringUrl : String?{
        didSet{
            guard let u = URL(string: stringUrl ?? "") else{return}
            self.playerImage.sd_setImage(with: u, placeholderImage: UIImage(named: "playerDefault")?.withRenderingMode(.alwaysTemplate), options: .continueInBackground, completed: nil)
        }
    }
    var extract : String?{
        didSet{
            self.playerSummaryLbl.text = extract!
        }
    }
    func setupViews(){
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
        view.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2470588235, alpha: 1)
        setupViews()
    }
}
