import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    var dataManager: NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    var data = [Character]() // Change the type to [Favorite]

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "imgback"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self

        // Adicione um ícone de coração no final de cada linha
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }

    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedObjectContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()

        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            listArray = result
            data = listArray.compactMap { favorite in
                return Character(
                    id: favorite.value(forKey: "id") as? Int ?? 0,
                    firstName: favorite.value(forKey: "firstName") as? String ?? "",
                    lastName: favorite.value(forKey: "lastName") as? String ?? "",
                    fullName: favorite.value(forKey: "fullName") as? String ?? "",
                    title: favorite.value(forKey: "title") as? String ?? "",
                    family: favorite.value(forKey: "family") as? String ?? "",
                    image: favorite.value(forKey: "image") as? String ?? "",
                    imageURL: favorite.value(forKey: "imageURL") as? String ?? "",
                    rate: favorite.value(forKey: "rate") as? Int
                )
            }
            tableView.reloadData()
            print(data)

        } catch {
            print("Error retrieving data: \(error.localizedDescription)")
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImage.frame = view.bounds
        tableView.frame = view.bounds
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let characterData = data[indexPath.row]

        let vc = DetailViewController(character: characterData)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let fullName = data[indexPath.row].fullName

        cell.textLabel?.text = fullName

        // Adicione um ícone de coração no final de cada linha
        let favoriteButton = UIButton(type: .system)
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteButton.tintColor = .black
        cell.accessoryView = favoriteButton

        return cell
    }
}

