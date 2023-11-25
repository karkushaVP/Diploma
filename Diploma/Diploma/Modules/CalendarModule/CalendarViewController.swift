//
//  CalendarViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import FSCalendar
 
final class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    private let calendar = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        makeLayout()
        makeConstraints()
        calendarSettings()
        title = "Календарь"
        self.view.backgroundColor = .white
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal], for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calendar.reloadData()
    }
    
    private func calendarSettings() {
        calendar.appearance.headerTitleColor = .systemTeal
        calendar.appearance.weekdayTextColor = .systemTeal
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.todayColor = .systemTeal
        calendar.appearance.selectionColor = UIColor.systemTeal.withAlphaComponent(0.5)
        calendar.firstWeekday = 2
    }

    private func makeLayout() {
        view.addSubview(calendar)
    }
    
    private func makeConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let tasks = RealmManager<TaskEntityModel>().read()
        
        let filteredTasks = tasks.filter { task in
            switch Calendar.current.compare(date, to: task.date, toGranularity: .day) {
            case .orderedAscending:
                return false
            case .orderedSame:
                return true
            case .orderedDescending:
                return false
            }
        }
        
        if filteredTasks.isEmpty {
            return 0
        } else {
            return 1
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let tasks = RealmManager<TaskEntityModel>().read()
        
        let filteredTasks = tasks.filter { task in
            switch Calendar.current.compare(date, to: task.date, toGranularity: .day) {
            case .orderedAscending:
                return false
            case .orderedSame:
                return true
            case .orderedDescending:
                return false
            }
        }
        if !filteredTasks.isEmpty {
            let taskDetailVC = TaskDetailViewController()
            taskDetailVC.selectedNotification = filteredTasks.first
            self.present(taskDetailVC, animated:true, completion: nil)
        }
    }
    
}
