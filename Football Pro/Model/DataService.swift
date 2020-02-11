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
let BASIC_URL2 = "https://server1.api-football.com/"
let wikipediaURl = "https://en.wikipedia.org/w/api.php"

let API_KEY = "259d5770474d4471b71d13c46f779769"
let API_KEY2 = "a9fb71338864ae4543e37d1256cc1c5f"
let HEADER = ["X-Auth-Token":"\(API_KEY)"]
let HEADER2 = ["X-RapidAPI-Key":"\(API_KEY2)"]


let availableComp = ["Brazil","England","Europe","France","Germany","Italy","Netherlands","Portugal","Spain","World",]


public class DataService {
    static let instance = DataService()
    
    
    let brazil = "357"
    let england = "524"
    let champions = "52"
    let france = "525"
    let germany = "751"
    let italy = "891"
    let nether = "566"
    let portugal = "766"
    let spain = "775"
    
    weak var manager = Alamofire.SessionManager.default
    var timer : Timer? = nil
    
    func getCompetitionID(name : String, completion : @escaping (_ competitionID : [String], _ competitionName : [String],_ startD:String,_ endD:String, _ limit : Bool,_ connection : Bool?,_ connecDisc : String?)-> Void) {
        var competitionsIDs = [String]()
        var competitionsNames = [String]()
        var start = ""
        var end = ""
        if availableComp.contains(name){
            manager?.session.configuration.timeoutIntervalForRequest = 60
            manager?.request(BASIC_URL + "competitions/", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (Response) in
                if let error = Response.result.error {
                    completion([String](),[String](),start,end,true,false,error.localizedDescription)
                } else {
                    let idJSON = JSON(Response.result.value as Any)
                }
            }
        }else{
            completion([String](),[String](),start,end,true,false,"\(name)'s League will be available soon. Please choose another country.")
        }
    }
    func getDataFromJson(idJSON: JSON){
        
        if idJSON["errorCode"].intValue == 429 {
            completion(competitionsIDs, competitionsNames,start,end,false, nil,nil)
        } else {
            let count = idJSON["count"].intValue
            for ind in 0..<count {
                if idJSON["competitions"][ind]["plan"].stringValue == "TIER_ONE" && idJSON["competitions"][ind]["area"]["name"].stringValue == name {
                    if name == "England" {
                        if idJSON["competitions"][ind]["name"] == "Premier League"{
                            let competitonID = idJSON["competitions"][ind]["id"].stringValue
                            let competitionName = idJSON["competitions"][ind]["name"].stringValue
                            let compStart = idJSON["competitions"][ind]["currentSeason"]["startDate"].stringValue
                            let compend = idJSON["competitions"][ind]["currentSeason"]["endDate"].stringValue
                            competitionsIDs.append(competitonID)
                            competitionsNames.append(competitionName)
                            start = compStart
                            end = compend
                        }
                        
                    }else if name == "Europe" {
                        if idJSON["competitions"][ind]["name"] == "UEFA Champions League"{
                            let competitonID = idJSON["competitions"][ind]["id"].stringValue
                            let competitionName = idJSON["competitions"][ind]["name"].stringValue
                            let compStart = idJSON["competitions"][ind]["currentSeason"]["startDate"].stringValue
                            let compend = idJSON["competitions"][ind]["currentSeason"]["endDate"].stringValue
                            competitionsIDs.append(competitonID)
                            competitionsNames.append(competitionName)
                            start = compStart
                            end = compend
                        }
                    }
                    else {
                        let competitonID = idJSON["competitions"][ind]["id"].stringValue
                        let competitionName = idJSON["competitions"][ind]["name"].stringValue
                        let compStart = idJSON["competitions"][ind]["currentSeason"]["startDate"].stringValue
                        let compend = idJSON["competitions"][ind]["currentSeason"]["endDate"].stringValue
                        competitionsIDs.append(competitonID)
                        competitionsNames.append(competitionName)
                        start = compStart
                        end = compend
                        
                    }
                }
            }
            
            completion(competitionsIDs, competitionsNames,start,end, true, nil,nil)
        }
    }
    func getCompetitionMatches(id : String,dateFrom: String,dateTo: String, completion : @escaping (_ newMatch : [Match], _ matchesCount : [Int], _ limit : Bool, _ dF : String, _ dT : String,_ connection : Bool?,_ connecDisc : String?)-> Void) {
        var matches = [Match]()
        var datesCount = [Int]()
        var datesArrayCount = [Date]()
        var i : Int = 0
        manager?.session.configuration.timeoutIntervalForRequest = 60
        manager?.request(BASIC_URL + "competitions/\(id)/matches?dateFrom=\(dateFrom)&dateTo=\(dateTo)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                completion([Match](),[Int](),true,"","",false,error.localizedDescription)
            } else {
                let matchesJSON = JSON(response.result.value as Any)
                if matchesJSON["errorCode"].intValue == 429 {
                    completion(matches, datesCount,false, dateFrom, dateTo,nil,nil)
                } else {
                    let count = matchesJSON["count"].intValue
                    for ind in 0..<count {
                        if matchesJSON["matches"][ind]["status"] == "FINISHED" || matchesJSON["matches"][ind]["status"] == "SCHEDULED" {
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
                                let compName = matchesJSON["competition"]["name"].stringValue
                                let sts = matchesJSON["matches"][ind]["status"].stringValue
                                let homeS = matchesJSON["matches"][ind]["score"]["fullTime"]["homeTeam"].stringValue
                                let awayS = matchesJSON["matches"][ind]["score"]["fullTime"]["awayTeam"].stringValue
                                let newMatch = Match(newDate: finalDate, newHomeTeam: homeTeam, newAwayTeam: awayTeam, newMatchId: matchId, cName: compName, sts: sts, hS: homeS, aS: awayS)
                                matches.append(newMatch)
                                if ind + 1 <= count {
                                    if matchesJSON["matches"][ind + 1]["status"] != "FINISHED" {
                                        let date2 = matchesJSON["matches"][ind + 1]["utcDate"].stringValue
                                        if ind  == count - 1 {
                                            i += 1
                                            datesCount.append(i)
                                            i = 0
                                        }
                                        let isoFormatter2 = ISO8601DateFormatter()
                                        let matchDate2 = isoFormatter2.date(from: date2)
                                        let newFormatter2 = DateFormatter()
                                        newFormatter2.dateFormat = "MM-dd-yyyy "
                                        if let fDate2 = matchDate2 {
                                            let fD2 = newFormatter2.string(from: fDate2)
                                            if fD == fD2 {
                                                i += 1
                                            }else {
                                                i += 1
                                                datesCount.append(i)
                                                i = 0
                                                
                                            }
                                            datesArrayCount.append(newMatch.date)
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    completion(matches, datesCount,true, "", "",nil,nil)
                    
                }
            }
        }
    }
    func getMatchDataFor(id : Int, completiton : @escaping (_ newMatchData : [String], _ homeWin : String, _ homeDraw : String, _ homeLoss : String, _ awayWin : String, _ awayDraw : String, _ awayLoss : String, _ competitionName : String, _ homeName : String, _ awayName : String, _ time : String, _ id : String, _ homeId : String, _ awayId : String,_ hScore : String,_ aScore : String,_ winner : String, _ limit : Bool,_ connection : Bool?,_ connecDisc : String?)->()) {
        var matchData = [String]()
        manager?.session.configuration.timeoutIntervalForRequest = 60
        manager?.request(BASIC_URL + "matches/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                completiton([String](),"","","","","","","","","","","","","","","","",true,false,error.localizedDescription)
            } else {
                let matchJSON = JSON(response.result.value as Any)
                if matchJSON["errorCode"].intValue == 429 {
                    completiton(matchData, "", "", "", "", "", "", "", "", "", "", "","","","","","",false,nil,nil)
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
                    matchData.insert(venue, at: 0)
                    matchData.insert("\(matchDay)", at: 1)
                    let homeName = matchJSON["match"]["homeTeam"]["name"].stringValue
                    let homeId = matchJSON["match"]["homeTeam"]["id"].stringValue
                    let awayName = matchJSON["match"]["awayTeam"]["name"].stringValue
                    let awayId = matchJSON["match"]["awayTeam"]["id"].stringValue
                    let date = matchJSON["match"]["utcDate"].stringValue
                    let homeScore = matchJSON["match"]["score"]["fullTime"]["homeTeam"].stringValue
                    let awayScore = matchJSON["match"]["score"]["fullTime"]["awayTeam"].stringValue
                    let win = matchJSON["match"]["score"]["winner"].stringValue
                    completiton(matchData, homeTeamWins, homeTeamDraws, homeTeamLosses, awayTeamWins, awayTeamDraws, awayTeamLosses, competitionName, homeName, awayName, date, competitionId,homeId,awayId,homeScore,awayScore,win,true,nil,nil)
                }
            }
        }
        
    }
    func getLeagueStandingsWith(id : String, completion : @escaping (_ competitionStanding : [Team], _ limit : Bool,_ connection : Bool?,_ connecDisc : String?)-> Void) {
        var leagueStandings = [Team]()
        manager?.session.configuration.timeoutIntervalForRequest = 60
        manager?.request(BASIC_URL + "competitions/\(id)/standings", method: .get, parameters: nil
            , encoding: JSONEncoding.default, headers: HEADER ).responseJSON { (response) in
                if let error = response.result.error {
                    completion([Team](),true,false,error.localizedDescription)
                } else {
                    let result = response.result.value as Any
                    let standingJson = JSON(result)
                    if standingJson["errorCode"].intValue == 429 {
                        completion(leagueStandings, false,nil,nil)
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
                                    leagueStandings.append(newTeam)
                                }
                            }
                        }
                        completion(leagueStandings, true,nil,nil)
                    }
                }
        }
    }
    func getLogoFor(teamName : String, leagueId : String, completion : @escaping (_ clubLogo : String, _ limit : Bool, _ compID : String,_ connection : Bool?,_ connecDisc : String?)-> Void) {
        var logo = ""
        manager?.session.configuration.timeoutIntervalForRequest = 60
        manager?.request(BASIC_URL + "competitions/\(leagueId)/teams", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                completion("",true,"",false,error.localizedDescription)
            } else {
                let crestJson = JSON(response.result.value as Any)
                if crestJson["errorCode"].intValue == 429 {
                    completion(logo, false, "",nil,nil)
                } else{
                    let leagueCode = crestJson["competition"]["code"].stringValue
                    let count = crestJson["teams"].count
                    for i in 0..<count {
                        if crestJson["teams"][i]["name"].stringValue == teamName {
                            let crestURL = crestJson["teams"][i]["crestUrl"].stringValue
                            logo = crestURL
                        }
                    }
                    completion(logo, true, leagueCode,nil,nil)
                }
            }
        }
    }
    
    func getTeamDetail(teamId : String, completion : @escaping (_ competitions : [String], _ crestString : String, _ name : String, _ colours : String, _ coachName : String, _ player : [Player], _ limit : Bool,_ connection : Bool?,_ connecDisc : String?)-> Void) {
        var squad = [Player]()
        var teamComp = [String]()
        var crest = ""
        var teamName = ""
        var colours = ""
        var coachName = ""
        manager?.session.configuration.timeoutIntervalForRequest = 60
        manager?.request(BASIC_URL + "teams/\(teamId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                completion([String](),"","","","",[Player](),true,false,error.localizedDescription)
            } else {
                let detailJson = JSON(response.result.value as Any)
                if detailJson["errorCode"].intValue == 429 {
                    completion(teamComp,crest,teamName,colours,coachName,squad, false,nil,nil)
                } else {
                    let competitionCount = detailJson["activeCompetitions"].count
                    for i in 0..<competitionCount {
                        let compName = detailJson["activeCompetitions"][i]["name"].stringValue
                        teamComp.append(compName)
                    }
                    teamName = detailJson["name"].stringValue
                    crest = detailJson["crestUrl"].stringValue
                    colours = detailJson["clubColors"].stringValue
                    let squadCount = detailJson["squad"].count
                    for ind in 0..<squadCount {
                        if detailJson["squad"][ind]["role"] == "COACH"{
                            coachName = detailJson["squad"][ind]["name"].stringValue
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
                                            squad.append(newPlayer)
                                        }
                                    }
                                    
                                }
                            
                            
                        }
                    }
                    
                    
                }
                completion(teamComp,crest,teamName,colours,coachName,squad, true,nil,nil)
            }
            
        }
    }
    func getTopScorersFor(leagueCode : String, teamName : String, completion : @escaping (_ scorer : [Scorer], _ limit : Bool,_ connection : Bool?,_ connecDisc : String?)-> Void) {
        var scorer = [Scorer]()
        manager?.session.configuration.timeoutIntervalForRequest = 60
        manager?.request(BASIC_URL + "competitions/\(leagueCode)/scorers", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                completion([Scorer](),true,false,error.localizedDescription)
            } else {
                let scorerJSON = JSON(response.result.value as Any)
                if scorerJSON["errorCode"].intValue == 429 {
                    completion(scorer, false,nil,nil)
                } else {
                    let count = scorerJSON["scorers"].count
                    for i in 0..<count {
                        if scorerJSON["scorers"][i]["team"]["name"].stringValue == teamName {
                            let playerName = scorerJSON["scorers"][i]["player"]["name"].stringValue
                            let playerPos = scorerJSON["scorers"][i]["player"]["position"].stringValue
                            let playerGoals = scorerJSON["scorers"][i]["numberOfGoals"].intValue
                            let playerAge = scorerJSON["scorers"][i]["player"]["dateOfBirth"].stringValue
                            let playerNat = scorerJSON["scorers"][i]["player"]["nationality"].stringValue
                            let newScorer = Scorer(n: playerName, p: playerPos, g: "\(playerGoals)", a: playerAge, nat: playerNat)
                            scorer.append(newScorer)
                        }
                    }
                    completion(scorer,true,nil,nil)
                }
                
            }
        }
    }
    func getLiveMatches(completition : @escaping (_ liveMatches : [LiveMatch], _ limit : Bool, _ count : Int,_ connection : Bool?,_ connecDisc : String?)-> Void) {
        var liveMatches = [LiveMatch]()
        manager?.session.configuration.timeoutIntervalForRequest = 60
        manager?.request(BASIC_URL + "matches?status=LIVE", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                completition([LiveMatch](),true,1000,false,error.localizedDescription)
            } else {
                let liveJSON = JSON(response.result.value as Any)
                if liveJSON["errorCode"].intValue == 429 {
                    completition(liveMatches,false,1000,nil,nil)
                } else if liveJSON["count"].intValue == 0 {
                    completition(liveMatches,true,0,nil,nil)
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
                        let newLiveMatch = LiveMatch(d: nil, comp: competition, stat: status, matchD: matchDay, halfTimeHome: halfTimeHomeScore, halfTimeAway: halfTimeAwayScore, fullTimeHome: fullTimeHomeScore, fullTimeAway: fullTimeAwayScore, homeName: homeTeamName, hId: nil, awayName: awayTeamName, aId: nil, refree: refreeName, mId: nil, mWinner: nil, compId: nil)
                        liveMatches.append(newLiveMatch)
                        
                    }
                    completition(liveMatches, true, liveJSON["count"].intValue,nil,nil)
                }
            }
        }
        
    }
    func requestPlayerImage(withName name: String, completion: @escaping (_ imageURL : String, _ sumary : String,_ connection : Bool?,_ connecDisc : String?)->Void){
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
            if let error = response.result.error{
                completion("","",false,error.localizedDescription)
            } else {
                let imageJSON = JSON(response.result.value as Any)
                let pageId = imageJSON["query"]["pageids"][0].intValue
                let imageURL = imageJSON["query"]["pages"]["\(pageId)"]["thumbnail"]["source"].stringValue
                let summary = imageJSON["query"]["pages"]["\(pageId)"]["extract"].stringValue
                completion(imageURL,summary,nil,nil)
            }
            
        }
    }
    func getTeamMatches(id : String,comp: @escaping(_ favmatch : [LiveMatch], _ limit : Bool,_ connection : Bool?,_ connecDisc : String?)->()){
        var favouriteTeamMatches = [LiveMatch]()
        manager?.session.configuration.timeoutIntervalForRequest = 60
        manager?.request(BASIC_URL + "teams/\(id)/matches" , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error{
                comp([LiveMatch](),true,false,error.localizedDescription)
            }else{
                let favMatchJson = JSON(response.result.value as Any)
                let count = favMatchJson["matches"].count
                if favMatchJson["errorCode"].intValue == 429{
                    comp(favouriteTeamMatches,false,nil,nil)
                }else{
                    if count>0{
                        for i in 0..<count - 1{
                            if favMatchJson["matches"][i]["status"].stringValue == "FINISHED" || favMatchJson["matches"][i]["status"].stringValue == "SCHEDULED" {
                                let date = favMatchJson["matches"][i]["utcDate"].stringValue
                                let mId = favMatchJson["matches"][i]["id"].stringValue
                                let day = favMatchJson["matches"][i]["matchday"].intValue
                                let winner = favMatchJson["matches"][i]["score"]["winner"].stringValue
                                let hScore = favMatchJson["matches"][i]["score"]["fullTime"]["homeTeam"].intValue
                                let aScore = favMatchJson["matches"][i]["score"]["fullTime"]["awayTeam"].intValue
                                let hId = favMatchJson["matches"][i]["homeTeam"]["id"].stringValue
                                let hName = favMatchJson["matches"][i]["homeTeam"]["name"].stringValue
                                let aId = favMatchJson["matches"][i]["awayTeam"]["id"].stringValue
                                let aName = favMatchJson["matches"][i]["awayTeam"]["name"].stringValue
                                let refName = favMatchJson["matches"][i]["referees"][0]["name"].stringValue
                                let compId = favMatchJson["matches"][i]["competition"]["id"].stringValue
                                let newFavMatch = LiveMatch(d: date, comp: nil, stat: nil, matchD: day, halfTimeHome: nil, halfTimeAway: nil, fullTimeHome: hScore, fullTimeAway: aScore, homeName: hName, hId: hId, awayName: aName, aId: aId, refree: refName, mId: mId, mWinner: winner, compId: compId)
                                favouriteTeamMatches.append(newFavMatch)
                            }
                        }
                    }
                }
                comp(favouriteTeamMatches,true,nil,nil)
            }
        }
    }
    func getFixtureIdForLineUps(date:String,leagueId:String?,homeName:String,awayName:String,venue:String,id: @escaping(_ connection : Bool?,_ connecDisc : String?,_ limitReached:Bool?, _ id : String)->()){
        var fixId = ""
        manager?.session.configuration.timeoutIntervalForRequest = 60
        if let lID = leagueId{
        manager?.request(BASIC_URL2 + "fixtures/league/\(lID)/\(date)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER2).responseJSON(completionHandler: { (response) in
            if let err = response.result.error{
                id(false,err.localizedDescription,nil,fixId)
            }else{
                let res = JSON(response.result.value as Any)
                let count = res["api"]["results"].intValue
                if count == 0 {
                    id(nil,nil,true,fixId)
                }else{
                for ind in 0..<count{
                    let hName = res["api"]["fixtures"][ind]["homeTeam"]["team_name"].stringValue
                    let aName = res["api"]["fixtures"][ind]["awayTeam"]["team_name"].stringValue
                    let vName = res["api"]["fixtures"][ind]["venue"].stringValue
                    if homeName.contains(hName) || awayName.contains(aName) || vName.contains(venue){
                        let id = res["api"]["fixtures"][ind]["fixture_id"].stringValue
                        fixId = id
                        break
                    }
                }
            }
                id(nil,nil,nil,fixId)
                
            }
        })
        }else{
            manager?.request(BASIC_URL2 + "fixtures/date/\(date)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER2).responseJSON(completionHandler: { (response) in
                if let err = response.result.error{
                    id(false,err.localizedDescription,nil,fixId)
                }else{
                    let res = JSON(response.result.value as Any)
                    let count = res["api"]["results"].intValue
                    if count == 0 {
                        id(nil,nil,true,fixId)
                    }else{
                    for ind in 0..<count{
                        let hName = res["api"]["fixtures"][ind]["homeTeam"]["team_name"].stringValue
                        let aName = res["api"]["fixtures"][ind]["awayTeam"]["team_name"].stringValue
                        let vName = res["api"]["fixtures"][ind]["venue"].stringValue
                        if homeName.contains(hName) || awayName.contains(aName) || vName.contains(venue){
                            let id = res["api"]["fixtures"][ind]["fixture_id"].stringValue
                            fixId = id
                            break
                        }
                    }
                }
                    id(nil,nil,nil,fixId)
                    
                }
            })
        }
    }
    func getDataFor(fixId:String,d:@escaping(_ connection : Bool?,_ connecDisc : String?,_ mData: MatchData?)->()){
        var homeEventTime = [String]()
        var homeEventPlayer = [String]()
        var homeEventType = [String]()
        var homeEventDetail = [String]()
        var homeEventAssist = [String]()
        var homeStartingName = [String]()
        var homeStartingPos = [String]()
        var homeSubName = [String]()
        var homeSubPos = [String]()
        
        var awayEventTime = [String]()
        var awayEventPlayer = [String]()
        var awayEventType = [String]()
        var awayEventDetail = [String]()
        var awayEventAssist = [String]()
        var awayStartingName = [String]()
        var awayStartingPos = [String]()
        var awaySubName = [String]()
        var awaySubPos = [String]()
        manager?.session.configuration.timeoutIntervalForRequest = 60
        manager?.request(BASIC_URL2 + "fixtures/id/\(fixId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER2).responseJSON(completionHandler: { (response) in
            if let err = response.result.error{
                d(false,err.localizedDescription,nil)
            }else{
                let dataJSON = JSON(response.result.value as Any)
                let hN = dataJSON["api"]["fixtures"][0]["homeTeam"]["team_name"].stringValue
                let aN = dataJSON["api"]["fixtures"][0]["awayTeam"]["team_name"].stringValue
                let eventsArr = dataJSON["api"]["fixtures"][0]["events"]
                for ind in 0..<eventsArr.count{
                    if eventsArr[ind]["teamName"].stringValue == hN{
                        let timeEl = eventsArr[ind]["elapsed"].stringValue
                        let pName = eventsArr[ind]["player"].stringValue
                        let eventDet = eventsArr[ind]["detail"].stringValue
                        let eventType = eventsArr[ind]["type"].stringValue
                        let eventAssist = eventsArr[ind]["assist"].stringValue
                        homeEventTime.append(timeEl)
                        homeEventPlayer.append(pName)
                        homeEventDetail.append(eventDet)
                        homeEventType.append(eventType)
                        homeEventAssist.append(eventAssist)
                    }else if eventsArr[ind]["teamName"].stringValue == aN{
                        let timeEl = eventsArr[ind]["elapsed"].stringValue
                        let pName = eventsArr[ind]["player"].stringValue
                        let eventType = eventsArr[ind]["type"].stringValue
                        let eventDet = eventsArr[ind]["detail"].stringValue
                        let eventAssist = eventsArr[ind]["assist"].stringValue
                        awayEventTime.append(timeEl)
                        awayEventPlayer.append(pName)
                        awayEventDetail.append(eventDet)
                        awayEventType.append(eventType)
                        awayEventAssist.append(eventAssist)
                    }
                }
                let lineUpsArr = dataJSON["api"]["fixtures"][0]["lineups"]
                let homeFormation = lineUpsArr[hN]["formation"].stringValue
                let awayFormation = lineUpsArr[aN]["formation"].stringValue
                let homeStarters = lineUpsArr[hN]["startXI"]
                for ind in 0..<homeStarters.count{
                    let name = homeStarters[ind]["player"].stringValue
                    let pos = homeStarters[ind]["pos"].stringValue
                    homeStartingName.append(name)
                    homeStartingPos.append(pos)
                }
                let awayStarters = lineUpsArr[aN]["startXI"]
                for ind in 0..<awayStarters.count{
                    let name = awayStarters[ind]["player"].stringValue
                    let pos = awayStarters[ind]["pos"].stringValue
                    awayStartingName.append(name)
                    awayStartingPos.append(pos)
                }
                let homeSub = lineUpsArr[hN]["substitutes"]
                for ind in 0..<homeSub.count{
                    let name = homeSub[ind]["player"].stringValue
                    let pos = homeSub[ind]["pos"].stringValue
                    homeSubName.append(name)
                    homeSubPos.append(pos)
                }
                let awaySub = lineUpsArr[aN]["substitutes"]
                for ind in 0..<awaySub.count{
                    let name = awaySub[ind]["player"].stringValue
                    let pos = awaySub[ind]["pos"].stringValue
                    awaySubName.append(name)
                    awaySubPos.append(pos)
                }
                let statisticsArr = dataJSON["api"]["fixtures"][0]["statistics"]
                let homSOG = statisticsArr["Shots on Goal"]["home"].stringValue
                let awySOG = statisticsArr["Shots on Goal"]["away"].stringValue
                let homTOS = statisticsArr["Total Shots"]["home"].stringValue
                let awyTOS = statisticsArr["Total Shots"]["away"].stringValue
                let homF = statisticsArr["Fouls"]["home"].stringValue
                let awyF = statisticsArr["Fouls"]["away"].stringValue
                let homC = statisticsArr["Corner Kicks"]["home"].stringValue
                let awyC = statisticsArr["Corner Kicks"]["away"].stringValue
                let homYC = statisticsArr["Yellow Cards"]["home"].stringValue
                let awyYC = statisticsArr["Yellow Cards"]["away"].stringValue
                let homRC = statisticsArr["Red Cards"]["home"].stringValue
                let awyRC = statisticsArr["Red Cards"]["away"].stringValue
                let homTP = statisticsArr["Total passes"]["home"].stringValue
                let awyTP = statisticsArr["Total passes"]["away"].stringValue
                let homBP = statisticsArr["Ball Possession"]["home"].stringValue
                let awyBP = statisticsArr["Ball Possession"]["away"].stringValue
                let newMData = MatchData(hET: homeEventTime, hEP: homeEventPlayer, hETy: homeEventType, hED: homeEventDetail, hEA: homeEventAssist, hFor: homeFormation, hSN: homeStartingName, hSP: homeStartingPos, hSubN: homeSubName, hSubPos: homeSubPos, hSOG: homSOG, hTS: homTOS, hF: homF, hC: homC, hYC: homYC, hRC: homRC, hTP: homTP, hBP: homBP, aET: awayEventTime, aEP: awayEventPlayer, aETy: awayEventType, aED: awayEventDetail, aEA: awayEventAssist, aFor: awayFormation, aSN: awayStartingName, aSP: awayStartingPos, aSubN: awaySubName, aSubPos: awaySubPos, aSOG: awySOG, aTS: awyTOS, aF: awyF, aC: awyC, aYC: awyYC, aRC: awyRC, aTP: awyTP, aBP: awyBP)
                d(nil,nil,newMData)
            }
        })
    }
}
