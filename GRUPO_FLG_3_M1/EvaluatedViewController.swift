import UIKit
import CoreData

class EvaluatedViewController: UIViewController {
    var dataManager: NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    var data =  [Character]() // Change the type to [Rating]

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ratings"
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
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

        let fetchRequest: NSFetchRequest<Rating> = Rating.fetchRequest()

        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            listArray = result
            print(listArray)
            data = listArray.compactMap { rating in
                return Character(
                    id: rating.value(forKey: "id") as? Int ?? 0,
                    firstName: rating.value(forKey: "firstName") as? String ?? "",
                    lastName: rating.value(forKey: "lastName") as? String ?? "",
                    fullName: rating.value(forKey: "fullName") as? String ?? "",
                    title: rating.value(forKey: "title") as? String ?? "",
                    family: rating.value(forKey: "family") as? String ?? "",
                    image: rating.value(forKey: "image") as? String ?? "",
                    imageURL: rating.value(forKey: "imageURL") as? String ?? "",
                    rate: rating.value(forKey: "rate") as? Int
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
        tableView.frame = view.bounds
    }
}

extension EvaluatedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let characterData = data[indexPath.row]

        let vc = DetailViewController(character: characterData)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension EvaluatedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

            let fullName = data[indexPath.row].fullName
            let rate = data[indexPath.row].rate ?? 0

            cell.textLabel?.text = fullName

            // Create and add StarRatingView to the cell's content view
            let starRatingView = StarRatingView()
            starRatingView.setRating(rate)
            cell.contentView.addSubview(starRatingView)

            // Set constraints for StarRatingView
            starRatingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                starRatingView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
                starRatingView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                starRatingView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8)
            ])

            return cell
        }
}
