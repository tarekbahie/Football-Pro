//
//  DataService.swift
//  Football Pro
//
//  Created by tarek bahie on 5/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


let BASIC_URL = "https://api.football-data.org/v2/"
let wikipediaURl = "https://en.wikipedia.org/w/api.php"

let API_KEY = "259d5770474d4471b71d13c46f779769"
let HEADER = ["X-Auth-Token":"\(API_KEY)"]



public class DataService {
    static let instance = DataService()
    
    var allowedCompetitions = ["portugal", "spain", "england", "italy", "france", "germany", "netherlands", "brazil", "europe", "world"]
    
    var competitionsIDs = [String]()
    var competitionsNames = [String]()
    
    var matches = [Match]()
    
    
    var datesCount = [Int]()
    var i : Int = 0
    var datesArrayCount = [Date]()
    var matchData = [String]()
    
    var leagueStandings = [Team]()
    
    var logo = ""
    
    var teamComp = [String]()
    var crest = ""
    var teamName = ""
    var colours = ""
    var coachName = ""
    var squad = [Player]()
    var teamLeagueId = ""
    
    var scorer = [Scorer]()
    
    var liveMatches = [LiveMatch]()
    
    var apiCalls = 0
    
    func getCompetitionID(name : String, completion : @escaping (_ competitionID : [String], _ competitionName : [String], _ limit : Bool)-> Void) {
        apiCalls += 1
        if self.competitionsIDs.count > 0 && self.competitionsNames.count > 0 {
            self.competitionsIDs.removeAll()
            self.competitionsNames.removeAll()
        }
        Alamofire.request(BASIC_URL + "competitions/", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (Response) in
            if let error = Response.result.error {
                print("Error processing request : \(String(describing: error))")
            } else {
                //                print(Response.result.value as Any)
                let idJSON = JSON(Response.result.value as Any)
                if idJSON["errorCode"].intValue == 429 {
                    completion(self.competitionsIDs, self.competitionsNames, false)
                } else {
                    let count = idJSON["count"].intValue
                    for ind in 0..<count {
                        if idJSON["competitions"][ind]["plan"].stringValue == "TIER_ONE" && idJSON["competitions"][ind]["area"]["name"].stringValue == name {
                            if name == "England" {
                                if idJSON["competitions"][ind]["name"] == "Premier League"{
                                    let competitonID = idJSON["competitions"][ind]["id"].stringValue
                                    let competitionName = idJSON["competitions"][ind]["name"].stringValue
                                    self.competitionsIDs.append(competitonID)
                                    self.competitionsNames.append(competitionName)
                                }
                                
                            }else if name == "Europe" {
                                if idJSON["competitions"][ind]["name"] == "UEFA Champions League"{
                                    let competitonID = idJSON["competitions"][ind]["id"].stringValue
                                    let competitionName = idJSON["competitions"][ind]["name"].stringValue
                                    self.competitionsIDs.append(competitonID)
                                    self.competitionsNames.append(competitionName)
                                }
                            }
                            else {
                                let competitonID = idJSON["competitions"][ind]["id"].stringValue
                                let competitionName = idJSON["competitions"][ind]["name"].stringValue
                                self.competitionsIDs.append(competitonID)
                                self.competitionsNames.append(competitionName)
                                
                            }
                        }
                    }
                    
                    completion(self.competitionsIDs, self.competitionsNames, true)
                }
            }
        }
    }
    func getCompetitionMatches(id : String,dateFrom: String,dateTo: String, completion : @escaping (_ newMatch : [Match], _ matchesCount : [Int], _ limit : Bool, _ dF : String, _ dT : String)-> Void) {
                if self.matches.count > 0 && self.datesCount.count > 0 {
                    self.matches.removeAll()
                    self.datesCount.removeAll()
                }
        apiCalls += 1
        Alamofire.request(BASIC_URL + "competitions/\(id)/matches?dateFrom=\(dateFrom)&dateTo=\(dateTo)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                print("Error getting matches for competition : \(error)")
            } else {
                //                print(response.result.value as Any)
                let matchesJSON = JSON(response.result.value as Any)
                if matchesJSON["errorCode"].intValue == 429 {
                    completion(self.matches, self.datesCount,false, dateFrom, dateTo)
                } else {
                    let count = matchesJSON["count"].intValue
                    for ind in 0..<count {
                        if matchesJSON["matches"][ind]["status"] == "FINISHED" {
                            let date = matchesJSON["matches"][ind]["utcDate"].stringValue
                            let isoFormatter = ISO8601DateFormatter()
                            let matchDate = isoFormatter.date(from: date)
                            let newFormatter = DateFormatter()
                            newFormatter.dateFormat = "MM-dd-yyyy "
                            guard let fDate = matchDate else {return}
                            let fD = newFormatter.string(from: fDate)
                            
                            if let finalDate = matchDate{
                                let homeTeam = matchesJSON["matches"][ind]["homeTeam"]["name"].stringValue
                                let awayTeam = matchesJSON["matches"][ind]["awayTeam"]["name"].stringValue
                                let matchId = matchesJSON["matches"][ind]["id"].intValue
                                let newMatch = Match(newDate: finalDate, newHomeTeam: homeTeam, newAwayTeam: awayTeam, newMatchId: matchId)
                                self.matches.append(newMatch)
                                
                                //                            print(newMatch.date)
                                if ind + 1 <= count {
                                    if matchesJSON["matches"][ind + 1]["status"] != "FINISHED" {
                                        let date2 = matchesJSON["matches"][ind + 1]["utcDate"].stringValue
                                        if ind  == count - 1 {
                                            self.i += 1
                                            self.datesCount.append(self.i)
                                            self.i = 0
                                        }
                                        let isoFormatter2 = ISO8601DateFormatter()
                                        let matchDate2 = isoFormatter2.date(from: date2)
                                        let newFormatter2 = DateFormatter()
                                        newFormatter2.dateFormat = "MM-dd-yyyy "
                                        if let fDate2 = matchDate2 {
                                            let fD2 = newFormatter2.string(from: fDate2)
                                            //                                    print(fD)
                                            //                                    print(fD2)
                                            if fD == fD2 {
                                                self.i += 1
                                            }else {
                                                self.i += 1
                                                self.datesCount.append(self.i)
                                                self.i = 0
                                                
                                            }
                                            self.datesArrayCount.append(newMatch.date)
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    completion(self.matches, self.datesCount,true, "", "")
                    
                }
            }
        }
    }
    func getMatchDataFor(id : Int, completiton : @escaping (_ newMatchData : [String], _ homeWin : String, _ homeDraw : String, _ homeLoss : String, _ awayWin : String, _ awayDraw : String, _ awayLoss : String, _ competitionName : String, _ homeName : String, _ awayName : String, _ time : String, _ id : String, _ homeId : String, _ awayId : String, _ limit : Bool)->()) {
        apiCalls += 1
        if self.matchData.count > 0 {
            self.matchData.removeAll()
        }
        Alamofire.request(BASIC_URL + "matches/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                print("Unable to retreive data : \(error)")
            } else {
                let matchJSON = JSON(response.result.value as Any)
                if matchJSON["errorCode"].intValue == 429 {
                    completiton(self.matchData, "", "", "", "", "", "", "", "", "", "", "","","",false)
                } else {
                    let homeTeamWins = matchJSON["head2head"]["homeTeam"]["wins"].stringValue
                    let homeTeamDraws = matchJSON["head2head"]["homeTeam"]["draws"].stringValue
                    let homeTeamLosses = matchJSON["head2head"]["homeTeam"]["losses"].stringValue
                    let awayTeamWins = matchJSON["head2head"]["awayTeam"]["wins"].stringValue
                    let awayTeamDraws = matchJSON["head2head"]["awayTeam"]["draws"].stringValue
                    let awayTeamLosses = matchJSON["head2head"]["awayTeam"]["losses"].stringValue
                    let competitionName = matchJSON["match"]["competition"]["name"].stringValue
                    let competitionId = matchJSON["match"]["competition"]["id"].stringValue
                    let venue = matchJSON["match"]["venue"].stringValue
                    let matchDay = matchJSON["match"]["matchday"].intValue
                    self.matchData.insert(venue, at: 0)
                    self.matchData.insert("\(matchDay)", at: 1)
                    let homeName = matchJSON["match"]["homeTeam"]["name"].stringValue
                    let homeId = matchJSON["match"]["homeTeam"]["id"].stringValue
                    let awayName = matchJSON["match"]["awayTeam"]["name"].stringValue
                    let awayId = matchJSON["match"]["awayTeam"]["id"].stringValue
                    let date = matchJSON["match"]["utcDate"].stringValue
                    completiton(self.matchData, homeTeamWins, homeTeamDraws, homeTeamLosses, awayTeamWins, awayTeamDraws, awayTeamLosses, competitionName, homeName, awayName, date, competitionId,homeId,awayId,true)
                }
            }
        }
        
    }
    func getLeagueStandingsWith(id : String, completion : @escaping (_ competitionStanding : [Team], _ limit : Bool)-> Void) {
        apiCalls += 1
        if self.leagueStandings.count > 0 {
            self.leagueStandings.removeAll()
        }
        Alamofire.request(BASIC_URL + "competitions/\(id)/standings", method: .get, parameters: nil
            , encoding: JSONEncoding.default, headers: HEADER ).responseJSON { (response) in
                if let error = response.result.error {
                    print("Error getting standings:  \(error)")
                } else {
                    let result = response.result.value as Any
                    let standingJson = JSON(result)
                    if standingJson["errorCode"].intValue == 429 {
                        completion(self.leagueStandings, false)
                    } else {
                        let count = standingJson["standings"].count
                        for i in 0..<count {
                            if standingJson["standings"][i]["type"].stringValue == "TOTAL" {
                                let newCount = standingJson["standings"][i]["table"].count
                                for ind in 0..<newCount {
                                    let pos = standingJson["standings"][i]["table"][ind]["position"].stringValue
                                    let teamName = standingJson["standings"][i]["table"][ind]["team"]["name"].stringValue
                                    let teamId = standingJson["standings"][i]["table"][ind]["team"]["id"].stringValue
                                    let gamesPlayed = standingJson["standings"][i]["table"][ind]["playedGames"].stringValue
                                    let goalDifference = standingJson["standings"][i]["table"][ind]["goalDifference"].stringValue
                                    let points = standingJson["standings"][i]["table"][ind]["points"].stringValue
                                    let newTeam = Team(newPos: pos, teamName: teamName, gamesPlayed: gamesPlayed, goalDiff: goalDifference, totalPts: points, teamId: teamId)
                                    self.leagueStandings.append(newTeam)
                                }
                            }
                        }
                        completion(self.leagueStandings, true)
                    }
                }
        }
    }
    func getLogoFor(teamName : String, leagueId : String, completion : @escaping (_ clubLogo : String, _ limit : Bool, _ compID : String)-> Void) {
        apiCalls += 1
        self.logo = ""
        Alamofire.request(BASIC_URL + "competitions/\(leagueId)/teams", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                print("Error getting Logo : \(error)")
            } else {
                let crestJson = JSON(response.result.value as Any)
                if crestJson["errorCode"].intValue == 429 {
                    completion(self.logo, false, "")
                } else{
                    let leagueCode = crestJson["competition"]["code"].stringValue
                    let count = crestJson["teams"].count
                    for i in 0..<count {
                        if crestJson["teams"][i]["name"].stringValue == teamName {
                            let crestURL = crestJson["teams"][i]["crestUrl"].stringValue
                            self.logo = crestURL
                            print("DataService :  \(self.logo)")
                        }
                    }
                    completion(self.logo, true, leagueCode)
                }
            }
        }
    }
    func getTeamDetail(teamId : String, completion : @escaping (_ competitions : [String], _ crestString : String, _ name : String, _ colours : String, _ coachName : String, _ player : [Player], _ limit : Bool)-> Void) {
        apiCalls += 1
        if self.squad.count > 0 && self.teamComp.count > 0 {
            self.squad.removeAll()
            self.teamComp.removeAll()
        }
        Alamofire.request(BASIC_URL + "teams/\(teamId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                print("error getting team details : \(error)")
            } else {
                let detailJson = JSON(response.result.value as Any)
                if detailJson["errorCode"].intValue == 429 {
                    completion(self.teamComp,self.crest,self.teamName,self.colours,self.coachName,self.squad, false)
                } else {
                    let competitionCount = detailJson["activeCompetitions"].count
                    for i in 0..<competitionCount {
                        let compName = detailJson["activeCompetitions"][i]["name"].stringValue
                        self.teamComp.append(compName)
                    }
                    self.teamName = detailJson["name"].stringValue
                    self.crest = detailJson["crestUrl"].stringValue
                    self.colours = detailJson["clubColors"].stringValue
                    let squadCount = detailJson["squad"].count
                    for ind in 0..<squadCount {
                        if detailJson["squad"][ind]["role"] == "COACH"{
                            self.coachName = detailJson["squad"][ind]["name"].stringValue
                        } else {
                            let playerName = detailJson["squad"][ind]["name"].stringValue
                            let playerPosition = detailJson["squad"][ind]["position"].stringValue
                            let playerAge = detailJson["squad"][ind]["dateOfBirth"].stringValue
                                let date = NSDate()
                                let calendar = Calendar.current
                                let components = calendar.dateComponents([ .year], from: date as Date)
                                let currentDate = calendar.date(from: components)
                                let userCalendar = Calendar.current
                                let isoFormatter = ISO8601DateFormatter()
                                if let matchDate = isoFormatter.date(from: playerAge) {
                                    let matchComponents = calendar.dateComponents([.month,.year], from: matchDate as Date)
                                    if let matchDay = userCalendar.date(from: matchComponents){
                                        let matchDayDifference = calendar.dateComponents([.month,.year], from: matchDay, to: currentDate!)
                                        if var age = matchDayDifference.year, let months = matchDayDifference.month {
                                            if months < 0{
                                                age -= 1
                                            }
                                            let playerNationality = detailJson["squad"][ind]["nationality"].stringValue
                                            let newPlayer = Player(n: playerName, p: playerPosition, a: "\(age)", nat: playerNationality, g: nil)
                                            self.squad.append(newPlayer)
                                        }
                                    }
                                    
                                }
                            
                            
                        }
                    }
                    
                    
                }
                completion(self.teamComp,self.crest,self.teamName,self.colours,self.coachName,self.squad, true)
            }
            
        }
    }
    func getTopScorersFor(leagueCode : String, teamName : String, completion : @escaping (_ scorer : [Scorer], _ limit : Bool)-> Void) {
        if scorer.count > 0 {
            scorer.removeAll()
        }
        Alamofire.request(BASIC_URL + "competitions/\(leagueCode)/scorers", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                print("error getting team details : \(error)")
            } else {
                let scorerJSON = JSON(response.result.value as Any)
                if scorerJSON["errorCode"].intValue == 429 {
                    completion(self.scorer, false)
                } else {
                    let count = scorerJSON["scorers"].count
                    for i in 0..<count {
                        if scorerJSON["scorers"][i]["team"]["name"].stringValue == teamName {
                            let playerName = scorerJSON["scorers"][i]["player"]["name"].stringValue
                            let playerPos = scorerJSON["scorers"][i]["player"]["position"].stringValue
                            let playerGoals = scorerJSON["scorers"][i]["numberOfGoals"].intValue
                            let newScorer = Scorer(n: playerName, p: playerPos, g: "\(playerGoals)")
                            self.scorer.append(newScorer)
                            print("dataservice name : \(playerName), goals : \(playerGoals)")
                        }
                    }
                    completion(self.scorer,true)
                }
                
            }
        }
    }
    func getLiveMatches(completition : @escaping (_ liveMatches : [LiveMatch], _ limit : Bool, _ count : Int)-> Void) {
        
        Alamofire.request(BASIC_URL + "matches?status=LIVE", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                print("error getting team details : \(error)")
            } else {
                let liveJSON = JSON(response.result.value as Any)
                if liveJSON["errorCode"].intValue == 429 {
                    completition(self.liveMatches,false,1)
                } else if liveJSON["count"].intValue == 0 {
                    completition(self.liveMatches,true,0)
                } else {
                    let count = liveJSON["matches"].count
                    for i in 0..<count {
                        let competition = liveJSON["matches"][i]["competition"]["name"].stringValue
                        let status = liveJSON["matches"][i]["status"].stringValue
                        let matchDay = liveJSON["matches"][i]["matchday"].intValue
                        let halfTimeHomeScore = liveJSON["matches"][i]["score"]["halfTime"]["homeTeam"].intValue
                        let halfTimeAwayScore = liveJSON["matches"][i]["score"]["halfTime"]["awayTeam"].intValue
                        let fullTimeHomeScore = liveJSON["matches"][i]["score"]["fullTime"]["homeTeam"].intValue
                        let fullTimeAwayScore = liveJSON["matches"][i]["score"]["fullTime"]["awayTeam"].intValue
                        let homeTeamName = liveJSON["matches"][i]["homeTeam"]["name"].stringValue
                        let awayTeamName = liveJSON["matches"][i]["awayTeam"]["name"].stringValue
                        let refreeName = liveJSON["matches"][i]["referees"][0]["name"].stringValue
                        let newLiveMatch = LiveMatch(comp: competition, stat: status, matchD: matchDay, halfTimeHome: halfTimeHomeScore, halfTimeAway: halfTimeAwayScore, fullTimeHome: fullTimeHomeScore, fullTimeAway: fullTimeAwayScore, homeName: homeTeamName, awayName: awayTeamName, refree: refreeName)
                        self.liveMatches.append(newLiveMatch)
                        print(newLiveMatch)
                        
                    }
                    completition(self.liveMatches, true, liveJSON["count"].intValue )
                }
            }
        }
        
    }
    func requestPlayerImage(withName name: String, completion: @escaping (_ imageURL : String, _ sumary : String)->Void){
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : name,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize": "500"
        ]
        Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.error == nil {
                let imageJSON = JSON(response.result.value as Any)
                let pageId = imageJSON["query"]["pageids"][0].intValue
                let imageURL = imageJSON["query"]["pages"]["\(pageId)"]["thumbnail"]["source"].stringValue
                let summary = imageJSON["query"]["pages"]["\(pageId)"]["extract"].stringValue
                completion(imageURL,summary)
            } else {
                print("error occured getting image : \(response.result.error as Any)")
            }
            
        }
    }
}
