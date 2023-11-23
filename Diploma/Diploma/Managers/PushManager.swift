//
//  PushManager.swift
//  Diploma
//
//  Created by Polya on 16.11.23.
//

import Foundation
import UserNotifications

final class PushManager: NSObject {
    private let center = UNUserNotificationCenter.current()
    var isPushesEnabled = false
    
    static let shared: PushManager = PushManager()

    private func requestAutorization() {
        center.delegate = self
        center.requestAuthorization(options: [.badge, .alert, .sound]) { [weak self] granted, error in
            if granted {
                self?.isPushesEnabled = true
            }
        }
    }
    
    func checkPermission() {
        center.getNotificationSettings { [weak self] settings in
            switch settings.authorizationStatus {
                
            case .notDetermined:
                self?.requestAutorization()
            case .denied:
                   print("не дали разрешение на пуши")
            case .provisional, .authorized:
                print("Разрешение на пуши дано")
            default:
                break
            }
        }
    }
    
    func createPushFrom(push: LocalPush) {
        let content = UNMutableNotificationContent()
        content.title = push.title
        if let subtitle = push.subtitle {
            content.subtitle = subtitle
        }
        content.sound = UNNotificationSound.default

        let dateComponents = Calendar.current.dateComponents([.day, .month, .hour, .minute], from: push.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: push.repeats)
        
        
        let request = UNNotificationRequest(identifier: push.id, content: content, trigger: trigger)
        
        center.add(request)
    }
    
    func removeAllNotifications() {
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }
}

struct LocalPush {
    let id: String
    let title: String
    let subtitle: String?
    let date: Date
    let repeats: Bool
    
    init(
        id: String = UUID().uuidString,
        title: String,
        subtitle: String,
        date: Date,
        repeats: Bool
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.repeats = repeats
    }
}

extension PushManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.badge, .banner, .sound])
    }
    
}
