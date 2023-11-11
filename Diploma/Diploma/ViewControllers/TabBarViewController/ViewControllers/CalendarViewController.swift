//
//  CalendarViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    private let calendar = FSCalendar()

    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        makeLayout()
        makeConstraints()
        calendarSettings()
        self.view.backgroundColor = .white
    }
    
    private func calendarSettings() {
        calendar.appearance.headerTitleColor = .systemTeal
        calendar.appearance.weekdayTextColor = .systemTeal
        calendar.appearance.titleTodayColor = .systemTeal

    }

    private func makeLayout() {
        view.addSubview(calendar)
    }
    
    private func makeConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
