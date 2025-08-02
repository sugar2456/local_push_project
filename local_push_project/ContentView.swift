import SwiftUI

struct NotificationSampleView: View {
    // 外部から渡すプロパティ
    let title: String
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title)
            Button(buttonTitle) {
                action()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke())
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40) {
            NotificationSampleView(
                title: "ローカル通知　最小設定",
                buttonTitle: "5秒後に通知"
            ) {
                scheduleNotification()
            }
            
            // 2つ目のビュー
            NotificationSampleView(
                title: "ローカル通知　",
                buttonTitle: "通知をスケジュール 2"
            ) {
                scheduleNotification()
            }
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
