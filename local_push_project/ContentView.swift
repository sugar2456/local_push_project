//
//  ContentView.swift
//  local_push_project
//
//  Created by 小川悟 on 2025/08/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("ローカル通知サンプル")
                .font(.title)
            Button("通知をスケジュール") {
                scheduleNotification()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke())
        }
        .padding()
    }
    
    /// 通知をスケジュールする
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "ローカル通知テスト"
        content.body  = "5秒後に通知が届きます"
        content.sound = .default
        
        // 5秒後に発火するトリガー
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // リクエスト作成
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: content,
                                            trigger: trigger)
        
        // 通知を登録
        UNUserNotificationCenter.current().add(request) { error in
            if let e = error {
                print("通知登録エラー:", e)
            } else {
                print("通知をスケジュールしました")
            }
        }
    }
}
