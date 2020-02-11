//
//  Match.swift
//  Football Pro
//
//  Created by tarek bahie on 5/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import Foundation
struct Match {
    var date : Date
    var homeName: String
    var awayName: String
    var matchId : Int
    var compName  : String
    var status : String
    var hScore : String
    var aScore : String
    init(newDate : Date, newHomeTeam : String, newAwayTeam  :String, newMatchId : Int,cName : String,sts:String,hS:String,aS:String) {
        self.date = newDate
        self.homeName = newHomeTeam
        self.awayName = newAwayTeam
        self.matchId = newMatchId
        self.compName = cName
        self.status = sts
        self.hScore = hS
        self.aScore = aS
    }
}
struct Team {
    var position : String
    var name : String
    var gamesPlayed : String
    var goalDifference : String
    var totalPoints : String
    var id : String
    init(newPos : String, teamName : String, gamesPlayed : String, goalDiff : String, totalPts : String, teamId : String) {
        self.position = newPos
        self.name = teamName
        self.gamesPlayed = gamesPlayed
        self.goalDifference = goalDiff
        self.totalPoints = totalPts
        self.id = teamId
    }
}
struct Player {
    var name : String
    var position : String
    var age : String
    var nationality : String
    var goals : String?
    init(n : String, p : String, a : String, nat : String, g : String?) {
        self.name = n
        self.position = p
        self.age = a
        self.nationality = nat
        self.goals = g
    }
}
struct Scorer {
    var Name : String
    var position : String
    var goals : String
    var age : String
    var nationality : String
    init(n:String,p:String,g:String,a : String,nat : String) {
        self.Name = n
        self.position = p
        self.goals = g
        self.age = a
        self.nationality = nat
    }
}
struct LiveMatch {
    var date : String?
    var competition : String?
    var status : String?
    var matchDay : Int
    var halfTimeHome : Int?
    var halfTimeAway : Int?
    var fullTimeHome : Int
    var fullTimeAway : Int
    var homeName : String
    var homeId : String?
    var awayName : String
    var awayId : String?
    var refreeName : String
    var matchId : String?
    var winner : String?
    var competitionId : String?
    
    init(d: String?,comp:  String?, stat:  String?,matchD:  Int,halfTimeHome:  Int?,halfTimeAway:  Int?,fullTimeHome:  Int,fullTimeAway:  Int,homeName:  String,hId : String?,awayName:  String,aId:  String?,refree:  String,mId : String?,mWinner : String?,compId: String?) {
        self.date = d
        self.competition = comp
        self.status = stat
        self.matchDay = matchD
        self.halfTimeHome = halfTimeHome
        self.halfTimeAway = halfTimeAway
        self.fullTimeHome = fullTimeHome
        self.fullTimeAway = fullTimeAway
        self.homeName = homeName
        self.homeId = hId
        self.awayName = awayName
        self.awayId = aId
        self.refreeName = refree
        self.matchId = mId
        self.winner = mWinner
        self.competitionId = compId
    }
}
struct FavMatch {
    var mDate : String
    var mDay : String
    var mId : String
    var winner : String
    var homeScore : String
    var awayScore : String
    var homeName: String
    var homeId : String
    var awayName: String
    var awayId : String
    var refName : String
    init(date: String,day: String,matchId: String,winner: String,hScore: String,aScore: String,hName: String,hId: String,aName: String,aId: String,rName: String) {
        self.mDate = date
        self.mDay = day
        self.mId = matchId
        self.winner = winner
        self.homeScore = hScore
        self.awayScore = aScore
        self.homeName = hName
        self.homeId = hId
        self.awayName = aName
        self.awayId = aId
        self.refName = rName
    }
    
}
struct MatchData {
    var homeEventTime : [String]
    var homeEventPlayer : [String]
    var homeEventType : [String]
    var homeEventDetail : [String]
    var homeEventAssist : [String]
    var homeFormation : String
    var homeStartingName : [String]
    var homeStartingPos : [String]
    var homeSubName : [String]
    var homeSubPos : [String]
    var homeShotsOnGoal : String
    var homeTotalShots : String
    var homeFouls : String
    var homeCorners : String
    var homeYellowCards : String
    var homeRedCards : String
    var homeTotalPasses : String
    var homeBallPoss : String
    var awayEventTime : [String]
    var awayEventPlayer : [String]
    var awayEventType : [String]
    var awayEventDetail : [String]
    var awayEventAssist : [String]
    var awayFormation : String
    var awayStartingName : [String]
    var awayStartingPos : [String]
    var awaySubName : [String]
    var awaySubPos : [String]
    var awayShotsOnGoal : String
    var awayTotalShots : String
    var awayFouls : String
    var awayCorners : String
    var awayYellowCards : String
    var awayRedCards : String
    var awayTotalPasses : String
    var awayBallPoss:String
    init(hET:[String],hEP:[String],hETy:[String],hED:[String],hEA:[String],hFor:String,hSN:[String],hSP:[String],hSubN:[String],hSubPos:[String],hSOG:String,hTS:String,hF:String,hC:String,hYC:String,hRC:String,hTP:String,hBP:String,aET:[String],aEP:[String],aETy:[String],aED:[String],aEA:[String],aFor:String,aSN:[String],aSP:[String],aSubN:[String],aSubPos:[String],aSOG:String,aTS:String,aF:String,aC:String,aYC:String,aRC:String,aTP:String,aBP:String) {
           homeEventTime = hET
           homeEventPlayer = hEP
           homeEventType = hETy
           homeEventDetail = hED
           homeEventAssist = hEA
           homeFormation = hFor
           homeStartingName = hSN
           homeStartingPos = hSP
           homeSubName = hSubN
           homeSubPos = hSubPos
           homeShotsOnGoal = hSOG
           homeTotalShots = hTS
           homeFouls = hF
           homeCorners = hC
           homeYellowCards = hYC
           homeRedCards = hRC
           homeTotalPasses = hTP
           homeBallPoss = hBP
           awayEventTime = aET
           awayEventPlayer = aEP
           awayEventType = aETy
           awayEventDetail = aED
           awayEventAssist = aEA
           awayFormation = aFor
           awayStartingName = aSN
           awayStartingPos = aSP
           awaySubName = aSubN
           awaySubPos = aSubPos
           awayShotsOnGoal = aSOG
           awayTotalShots = aTS
           awayFouls = aF
           awayCorners = aC
           awayYellowCards = aYC
           awayRedCards = aRC
           awayTotalPasses = aTP
           awayBallPoss = aBP
    }
}
