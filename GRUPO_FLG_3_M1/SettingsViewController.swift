import UIKit
import CoreLocation

class SettingsListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SettingsCellDelegate, CLLocationManagerDelegate {
    
    func timePreferenceChanged(selectedTime: Date?) {
        // Adicione a lógica para lidar com a mudança de preferência de tempo, se necessário
        print("Hora preferencial alterada: \(selectedTime)")
    }
    
    let locationManager = CLLocationManager()
    var locationLabel: UILabel!

    let settingsData = ["Localização", "Idioma", "Notificações", "Hora Preferencial", "Cache"]
    let iconNames = ["gps", "language", "noti", "noti", "cache"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        collectionView.backgroundColor = .black
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: SettingsCell.reuseIdentifier)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.settingsCell = collectionView.cellForItem(at: IndexPath(item: 3, section: 0)) as? SettingsCell
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        setupLocationLabel()
    }

    func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textColor = .white
        locationLabel.textAlignment = .center
        locationLabel.text = "Localização: Desativada"
        view.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationLabel.text = "Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)"
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as? SettingsCell else {
            fatalError("Unable to dequeue SettingsCell")
        }

        cell.delegate = self
        cell.titleLabel.text = settingsData[indexPath.item]
        cell.iconImageView.image = UIImage(named: iconNames[indexPath.item])
        cell.configureButtons()

        // Passa a referência da locationLabel para SettingsCell
        cell.locationLabel = locationLabel

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 80)
    }
}

protocol SettingsCellDelegate: AnyObject {
    func timePreferenceChanged(selectedTime: Date?)
}

class SettingsCell: UICollectionViewCell, CLLocationManagerDelegate {
    static let reuseIdentifier = "SettingsCell"
    var selectedTime: Date?
    var hour1: Int = 0
    var minute1: Int = 0
    
    let locationManager = CLLocationManager()
    
    weak var delegate: SettingsCellDelegate?
    weak var locationLabel: UILabel?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        return label
    }()

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let switchButton: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.addTarget(self, action: #selector(switchButtonTapped), for: .valueChanged)
        return switchView
    }()

    let languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Selecionar Idioma", for: .normal)
        button.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        return button
    }()

    let timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "pt_PT")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
        return datePicker
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        layer.cornerRadius = 12
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4

        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)

        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),

            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    func configureButtons() {
        switch titleLabel.text {
        case "Idioma":
            contentView.addSubview(languageButton)
            NSLayoutConstraint.activate([
                languageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                languageButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
        case "Localização":
            contentView.addSubview(switchButton)
            NSLayoutConstraint.activate([
                switchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                switchButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
        case "Notificações":
            contentView.addSubview(switchButton)
            NSLayoutConstraint.activate([
                switchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                switchButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
        case "Hora Preferencial":
            contentView.addSubview(timePicker)
            titleLabel.textColor = .white
            NSLayoutConstraint.activate([
                timePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                timePicker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
        case "Cache":
            contentView.addSubview(switchButton)
            NSLayoutConstraint.activate([
                switchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                switchButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
        default:
            break
        }
    }

    @objc func switchButtonTapped() {
        let locationEnabled = switchButton.isOn
        locationLabel?.text = locationEnabled ? "Localização: Ativada" : "Localização: Desativada"

        if locationEnabled {
            startUpdatingLocation()
        } else {
            stopUpdatingLocation()
        }

        let notificationsEnabled = switchButton.isOn

        if notificationsEnabled {
            scheduleDailyNotification(hour: hour1, minute: minute1)
        } else {
            cancelDailyNotification()
        }
    }

    private func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }

    private func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    @objc func timePickerValueChanged() {
        selectedTime = timePicker.date
        delegate?.timePreferenceChanged(selectedTime: selectedTime)

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: selectedTime ?? Date())

        hour1 = components.hour ?? 0
        minute1 = components.minute ?? 0

        scheduleDailyNotification(hour: hour1, minute: minute1)
    }

    func scheduleDailyNotification(hour: Int, minute: Int) {
        let notificationCenter = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Título da Notificação"
        content.body = "Corpo da Notificação"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        fetchCharacters { characters in
            let randomIndex = Int.random(in: 0..<characters.count)
            let randomCharacter = characters[randomIndex]

            content.title = "Personagem Aleatório"
            content.body = "Conheça \(randomCharacter.fullName)"

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "DailyNotification", content: content, trigger: trigger)

            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["DailyNotification"])

            notificationCenter.add(request) { error in
                if let error = error {
                    print("Erro ao agendar notificação: \(error.localizedDescription)")
                } else {
                    print("Notificação diária agendada com sucesso!")
                }
            }
        }
    }

    func fetchCharacters(completion: @escaping ([Character]) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            GOTService.fetch { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let characters):
                        completion(characters)
                    case .failure(let error):
                        print("Error fetching data: \(error.localizedDescription)")
                        completion([])
                    }
                }
            }
        }
    }

    func cancelDailyNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["DailyNotification"])
        print("Notificação diária cancelada com sucesso!")
    }

    @objc func languageButtonTapped() {
        // Handle language button tap
    }
}

