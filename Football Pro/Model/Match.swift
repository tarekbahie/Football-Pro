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
    init(newDate : Date, newHomeTeam : String, newAwayTeam  :String, newMatchId : Int) {
        self.date = newDate
        self.homeName = newHomeTeam
        self.awayName = newAwayTeam
        self.matchId = newMatchId
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
    init(n:String,p:String,g:String) {
        self.Name = n
        self.position = p
        self.goals = g
    }
}
struct LiveMatch {
    var competition : String
    var status : String
    var matchDay : Int
    var halfTimeHome : Int
    var halfTimeAway : Int
    var fullTimeHome : Int
    var fullTimeAway : Int
    var homeName : String
    var awayName : String
    var refreeName : String
    
    init(comp:  String, stat:  String,matchD:  Int,halfTimeHome:  Int,halfTimeAway:  Int,fullTimeHome:  Int,fullTimeAway:  Int,homeName:  String,awayName:  String,refree:  String) {
        self.competition = comp
        self.status = stat
        self.matchDay = matchD
        self.halfTimeHome = halfTimeHome
        self.halfTimeAway = halfTimeAway
        self.fullTimeHome = fullTimeHome
        self.fullTimeAway = fullTimeAway
        self.homeName = homeName
        self.awayName = awayName
        self.refreeName = refree
    }
}
