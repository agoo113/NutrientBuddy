//
//  CalendarViewController.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 15/03/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//
//  Calendar is to be implemented

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var calenderView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    var day = Int()
    var month = Int()
    var weekday = Int()
    var year = Int()
    var calendar = Calendar.current
    let date = Date()
    var selectedDateString = String()
    
    func getCurrentDate(){
        day = calendar.component(.day, from: date)
        month = calendar.component(.month, from: date) - 1
        weekday = calendar.component(.weekday, from: date) - 1 // weekday 1 means sunday
        year = calendar.component(.year, from: date)
    }
    
    
    let Months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let daysOfMonth = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var currentMonth = String()
    
    var numberOfEmptyBox = Int() // The number of empty boxes at the start of the current month
    
    var direction = 0 // 0 for current month, 1 for next, -1 for past
    
    var positionIndex = 0 // mark the position where the 1st of the month is in a week
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDate()
        if weekday == 0 {
            weekday = 7
        }
        currentMonth = Months[month]
        self.navigationItem.title = "\(currentMonth) \(year)"
        getStartDateDayPosition()
    }
    
    func getStartDateDayPosition() {
        switch direction {
        case 0:
            numberOfEmptyBox = weekday
            var dayCounter = day
            while dayCounter > 0 {
                numberOfEmptyBox -= 1
                dayCounter -= 1
                if numberOfEmptyBox == 0 {
                    numberOfEmptyBox = 7
                }
            }
            if numberOfEmptyBox == 7 {
                numberOfEmptyBox = 0
            }
            positionIndex = numberOfEmptyBox
            
        case 1...:
            var thisMonth = month - 1
            if thisMonth < 0 {
                thisMonth = 12
            }
            if thisMonth > 11 {
                thisMonth = 0
            }
            let nextNumberOfEmptyBox = positionIndex + daysInMonth[thisMonth]%7
            positionIndex = nextNumberOfEmptyBox
            if positionIndex >= 7 {
                positionIndex -= 7
            }
            
        case -1:
            var previousNumberOfEmptyBox = positionIndex - daysInMonth[month]%7
            while previousNumberOfEmptyBox < 0 {
                previousNumberOfEmptyBox += 7
            }
            positionIndex = previousNumberOfEmptyBox
            
        default:
            fatalError()
        }
    }
    
    func leapYearValidation() {
        let remainder = year % 4
        if remainder == 0 {
            daysInMonth[1] = 29
        }
        else {
            daysInMonth[1] = 28
        }
    }
    // Buttons
    @IBAction func todayButtonTapped(_ sender: UIBarButtonItem) {
        getCurrentDate()
        direction = 0
        positionIndex = 0
        if weekday == 0 {
            weekday = 7
        }
        currentMonth = Months[month]
        self.navigationItem.title = "\(currentMonth) \(year)"
        getStartDateDayPosition()
        calenderView.reloadData()
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        direction = -1
        switch currentMonth {
        case "January":
            month = 11
            year -= 1
            getStartDateDayPosition()
            leapYearValidation()
            currentMonth = Months[month]
            self.navigationItem.title = "\(currentMonth) \(year)"
            calenderView.reloadData()
            
        default:
            month -= 1
            getStartDateDayPosition()
            currentMonth = Months[month]
            self.navigationItem.title = "\(currentMonth) \(year)"
            calenderView.reloadData()
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        direction = 1
        switch currentMonth {
        case "December":
            month = 0
            year += 1
            getStartDateDayPosition()
            leapYearValidation()
            currentMonth = Months[month]
            self.navigationItem.title = "\(currentMonth) \(year)"
            calenderView.reloadData()
        default:
            month += 1
            getStartDateDayPosition()
            currentMonth = Months[month]
            self.navigationItem.title = "\(currentMonth) \(year)"
            calenderView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysInMonth[month] + positionIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! DateCollectionViewCell
        cell.isHidden = false
        cell.dateLabel.textColor = UIColor.black
        
        cell.backgroundColor = UIColor.clear
        
        cell.dateLabel.text = "\(indexPath.row + 1 - positionIndex)"
        
        if Int(cell.dateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        //Show weekends in different color
        switch indexPath.row {
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.dateLabel.text!)! > 0 {
                cell.dateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        
        //Mark the current date red
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && day == (indexPath.row + 1 - numberOfEmptyBox){
            cell.backgroundColor = UIColor.red
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDay = indexPath.row + 1 - positionIndex
        let selectedMonth = month + 1
        selectedDateString = String(format: "%02d", selectedDay) + "/" + String(format: "%02d", selectedMonth) + "/" + "\(year)"
        pushDiary()
    }
    
    /*//MARK: pass to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedDiaryView" {
            let selectedDiaryViewController: SelectedDiaryViewController = segue.destination as! SelectedDiaryViewController
            selectedDiaryViewController.date = selectedDateString
        }
    }
 */
    func pushDiary(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selectedDiaryViewController = storyboard.instantiateViewController(withIdentifier: "selectedDiaryView") as! SelectedDiaryViewController
        selectedDiaryViewController.date = selectedDateString
        navigationController?.pushViewController(selectedDiaryViewController, animated: true)
    }
}


