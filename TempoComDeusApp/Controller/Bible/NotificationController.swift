//
//  NotificationController.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 09/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import UserNotifications
class NotificationsController {
    let bible = Bible()
    let title: String
    let subtitle: String
    let body: String
    let center: UNUserNotificationCenter
    
    init(center: UNUserNotificationCenter) {
        self.center = center
        (subtitle, body) = Bible().generateRamdomVerse()
        title = "Reserve um tempo com Deus"
    }
    
    func schenduleNotificationNonRepeat() {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(
          timeInterval: 10,
          repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
          content: content,
          trigger: trigger)
        center.add(request)
        
    }
    
    func schenduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = .default
            
        let date = Date()
    //    let date = Date().addingTimeInterval(24 * 60 * 60) // -> 24 horas
//        let dateComponents = Calendar.current.dateComponents(
//            [.year, .month, .day, .hour, .minute, .second], from: date)
        let dateComponents = Calendar.current.dateComponents(
                [.hour, .minute, .second], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // -------- Create the request ------------
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        // -------- Register the request -----------
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
