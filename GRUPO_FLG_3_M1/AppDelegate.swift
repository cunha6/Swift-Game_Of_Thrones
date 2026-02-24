import UIKit
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var settingsCell: SettingsCell?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().tintColor = .todayPrimaryTint
        UINavigationBar.appearance().backgroundColor = .todayNavigationBackground
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        // Solicitar permissões de notificação
        requestNotificationPermissions()

        // Agendar notificação diária
        scheduleDailyNotification()

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GRUPO_FLG_3_M1")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func requestNotificationPermissions() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
            if didAllow {
                print("Permissões de notificação concedidas")
            }
        }
    }

    func scheduleDailyNotification() {
        let notificationCenter = UNUserNotificationCenter.current()

        // Configurar o conteúdo da notificação
        let content = UNMutableNotificationContent()
        content.title = "Game of Thrones"
        content.body = "Come with me discover a new Character"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 50
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // Configurar o pedido de notificação
        let request = UNNotificationRequest(identifier: "DailyNotification", content: content, trigger: trigger)

        // Remover notificações pendentes com o mesmo identificador
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["DailyNotification"])

        // Adicionar a notificação
        notificationCenter.add(request) { error in
            if let error = error {
                print("Erro ao agendar notificação: \(error.localizedDescription)")
            } else {
                print("Notificação diária agendada com sucesso!")
            }
        }
    }
}
