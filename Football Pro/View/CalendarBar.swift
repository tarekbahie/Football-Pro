//
//  CalendarBar.swift
//  Football Pro
//
//  Created by tarek bahie on 5/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
class CalendarBar : UIView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.delegate = self
        cView.dataSource = self
        cView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cView.isScrollEnabled = true
        return cView
    }()
    
    let today = Date()
    
    var dayNumber = [String]()
    var dayNames = [String]()
    var month=[String]()
    
    var monthArr = [[String]]()
    var dayNumArr = [[String]]()
    var dayNameArr = [[String]]()
    
    var home : HomeVC?
    var tMonth = ""
    var tDay = ""
    
    var month1 = [String]()
    var dayname1 = [String]()
    var daynum1 = [String]()
    
    var month2 = [String]()
    var dayname2 = [String]()
    var daynum2 = [String]()
    
    var month3 = [String]()
    var dayname3 = [String]()
    var daynum3 = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        getDatesBeforeToday()
        getComingDates()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        addSubview(collectionView)
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calId")
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return monthArr[section].count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return monthArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calId", for: indexPath) as! CalendarCell
        cell.dayNumber.text = dayNumArr[indexPath.section][indexPath.item]
        cell.dayName.text = dayNameArr[indexPath.section][indexPath.item]
        cell.monthName.text = monthArr[indexPath.section][indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dateToSend = getSelectedDate(mont: monthArr[indexPath.section][indexPath.item], day: dayNumArr[indexPath.section][indexPath.item])
        home?.selectedDay = dateToSend
    }
    
    func getSelectedDate(mont: String,day:String)->String{
        var monthInNumber = ""
        switch mont {
        case "Jan":
            monthInNumber = "01"
        case "Feb":
            monthInNumber = "02"
        case "Mar":
            monthInNumber = "03"
        case "Apr":
            monthInNumber = "04"
        case "May":
            monthInNumber = "05"
        case "Jun":
            monthInNumber = "06"
        case "Jul":
            monthInNumber = "07"
        case "Aug":
            monthInNumber = "08"
        case "Sep":
            monthInNumber = "09"
        case "Oct":
            monthInNumber = "10"
        case "Nov":
            monthInNumber = "11"
        case "Dec":
            monthInNumber = "12"
        default:
            monthInNumber = "1"
        }
        return "2019-\(monthInNumber)-\(day)"
        
    }
    func getDatesBeforeToday(){
        var (months,daysNum,daysNam) = formMonthDaysNumDaysNamArrays(today: today, numberOfDays: 12, plusOrMinus: "-")
        months.reverse()
        daysNum.reverse()
        daysNam.reverse()
        self.month = months
        self.dayNumber = daysNum
        self.dayNames = daysNam
        
    }
    func getComingDates(){
        var (months,daysNum,daysNam) = formMonthDaysNumDaysNamArrays(today: today, numberOfDays: 59, plusOrMinus: "+")
        months.removeFirst()
        daysNum.removeFirst()
        daysNam.removeFirst()
        self.month.append(contentsOf: months)
        self.dayNumber.append(contentsOf: daysNum)
        self.dayNames.append(contentsOf: daysNam)
        sortMonthsAndDays()
    }
    
    func formMonthDaysNumDaysNamArrays(today : Date,numberOfDays : Int,plusOrMinus: String)->([String],[String],[String]){
        var months = [String]()
        var daysNum = [String]()
        var daysNam = [String]()
        
        for i in 0..<numberOfDays{
            var d = Date()
            if plusOrMinus == "+"{
                d = Calendar.current.date(byAdding: .day, value: i, to: today)!
            }else{
                d = Calendar.current.date(byAdding: .day, value: -i, to: today)!
            }
            let mFormatter = DateFormatter()
            mFormatter.dateFormat = "MMM"
            let mD = mFormatter.string(from: d)
            
            let dNumFormatter = DateFormatter()
            dNumFormatter.dateFormat = "dd"
            let dNumD = dNumFormatter.string(from: d)
            
            let dNamFormatter = DateFormatter()
            dNamFormatter.dateFormat = "E"
            let dNamD = dNamFormatter.string(from: d)
            
            months.append(mD)
            daysNum.append(dNumD)
            daysNam.append(dNamD)
        }
        return (months,daysNum,daysNam)
    }
    
    func sortMonthsAndDays(){
        let (todayM,todayD) = getTodayDate()
        self.tMonth = todayM
        self.tDay = todayD
        combineSameMonthDays(m: &month1, dName: &dayname1, dNumb: &daynum1)
        combineSameMonthDays(m: &month2, dName: &dayname2, dNumb: &daynum2)
        combineSameMonthDays(m: &month3, dName: &dayname3, dNumb: &daynum3)
        
    }
    func combineSameMonthDays(m : inout [String], dName : inout [String],dNumb : inout [String]){
        for i in 0..<month.count - 1{
            if month[i] == month[i+1]{
                m.append(month[i])
                dName.append(dayNames[i])
                dNumb.append(dayNumber[i])
            }else{
                m.append(month[i])
                dName.append(dayNames[i])
                dNumb.append(dayNumber[i])
                break
            }
        }
        month.removeFirst(m.count)
        dayNames.removeFirst(dName.count)
        dayNumber.removeFirst(dNumb.count)
        
        monthArr.append(m)
        dayNumArr.append(dNumb)
        dayNameArr.append(dName)
        
        self.collectionView.reloadData()
    }
    
    func scrollToTodayDate(){
        var i = 0
        var s = 0
        
        if month1.contains(self.tMonth){
            s = 0
        } else if month2.contains(self.tMonth) {
            s = 1
        } else {
            s = 2
        }
        for ind in 0..<daynum1.count{
            if daynum1[ind] == tDay{
                i = ind
                scrollToItemAndSection(i: i, s: s)
                return
            }
        }
        for ind1 in 0..<daynum2.count{
            if daynum2[ind1] == tDay{
                i = ind1
                scrollToItemAndSection(i: i, s: s)
                return
            }
        }
        for ind2 in 0..<daynum3.count{
            if daynum3[ind2] == tDay{
                i = ind2
                scrollToItemAndSection(i: i, s: s)
                return
            }
        }
        
        
    }
    func scrollToItemAndSection(i : Int, s: Int){
        let endIndex = IndexPath(item: i, section: s)
        collectionView.selectItem(at: endIndex, animated: true, scrollPosition: .top)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: endIndex, at: .centeredHorizontally, animated: false)
        }
    }
    
    func getTodayDate()->(String,String){
        let d = Calendar.current.date(byAdding: .day, value: 0, to: today)!
        let mFormatter = DateFormatter()
        mFormatter.dateFormat = "MMM"
        let mD = mFormatter.string(from: d)
        mFormatter.dateFormat = "dd"
        let dD = mFormatter.string(from: d)
        return (mD,dD)
    }
}
