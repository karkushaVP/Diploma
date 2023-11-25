//
//  CalendarViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import FSCalendar
 
// отобризить точки на календаре по показу таски
class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
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
    
    private func calendarSettings() {
        calendar.appearance.headerTitleColor = .systemTeal
        calendar.appearance.weekdayTextColor = .systemTeal
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.todayColor = .systemTeal
        calendar.appearance.selectionColor = UIColor.systemTeal.withAlphaComponent(0.5)
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
}
