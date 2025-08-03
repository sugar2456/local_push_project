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
                title: "ローカル通知　日時指定",
                buttonTitle: "特定の日時になるとスケジュール"
            ) {
                scheduleDateNotification()
            }
            
            NotificationSampleView(
                title: "ローカル通知　画像添付",
                buttonTitle: "画像の添付通知"
            ) {
                scheduleImageAttachmentNotification()
            }
            
            
            NotificationSampleView(
                title: "ローカル通知　Gif添付",
                buttonTitle: "Gifの添付通知"
            ) {
                scheduleGitAttachmentNotification()
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
    
    func scheduleDateNotification () {
        let content = UNMutableNotificationContent()
        content.title = "日付指定ローカル通知テスト"
        content.body  = "特定の日時になると通知が届きます"
        content.sound = .default

        var date = DateComponents()
        date.hour = 1
        date.minute = 31
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: "date notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let e = error {
                print("通知登録エラー:", e)
            } else {
                print("通知をスケジュールしました")
            }
        }
    }
    
    func scheduleImageAttachmentNotification() {
        let content = UNMutableNotificationContent()
        content.title = "画像付き通知"
        content.body  = "バンドル内の画像を添付しています"

        if let imageURL = Bundle.main.url(forResource: "notification", withExtension: "png") {
            do {
                let attachment = try UNNotificationAttachment(
                    identifier: "myImageAttachment",
                    url: imageURL,
                    options: nil
                )
                content.attachments = [attachment]
            } catch {
                print("Attachment 作成失敗:", error)
            }
        } else {
            print("fileが見つからない")
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
    
    func scheduleGitAttachmentNotification() {
        let content = UNMutableNotificationContent()
        content.title = "gif付き通知"
        content.body  = "バンドル内のgifを添付しています"

        if let imageURL = Bundle.main.url(forResource: "cat", withExtension: "gif") {
            do {
                let attachment = try UNNotificationAttachment(
                    identifier: "myGifAttachment",
                    url: imageURL,
                    options: nil
                )
                content.attachments = [attachment]
            } catch {
                print("Attachment 作成失敗:", error)
            }
        } else {
            print("fileが見つからない")
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
}
