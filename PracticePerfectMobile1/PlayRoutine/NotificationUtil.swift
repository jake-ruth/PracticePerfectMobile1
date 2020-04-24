//
//  NotificationUtil.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/23/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation
import UserNotifications

public class NotificationUtil {
    
    static func scheduleNotification(seconds: Int){
        let content = UNMutableNotificationContent()
        content.title = "Practice item complete!"
        content.subtitle = "Click here to move on"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    static func requestAccess(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            success, error in
            if (success) {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    static func cancelAllNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
