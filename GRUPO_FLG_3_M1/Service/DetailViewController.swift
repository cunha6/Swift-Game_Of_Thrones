import UIKit
import CoreData

protocol RatingViewDelegate: AnyObject {
    func ratingView(_ ratingView: RatingView, didChangeRating rating: Int)
}

class DetailViewController: UIViewController, RatingViewDelegate {
    
    private let character: Character
    var dataManager: NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let familyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let ratingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()

    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = character.fullName
        
        //dataManager = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        setupViews()
        configureViews()
        setupNavigationBar()
        setupRatingView()
        setupFavoriteButton()
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(overlayView)
        view.addSubview(nameLabel)
        view.addSubview(titleLabel)
        view.addSubview(familyLabel)

        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
        
        NSLayoutConstraint.activate([
            familyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            familyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        ])
    }
    
    private func configureViews() {
        titleLabel.text = "\(character.title)"
        familyLabel.text = "\(character.family)"

        // Load character image from URL
        if let url = URL(string: character.imageURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        self.backgroundImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }

    
    @objc private func favoriteButtonTapped() {
            if favoriteButton.isSelected {
                favoriteButton.isSelected = false
                favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                removeFromFavorites()
            } else {
                favoriteButton.isSelected = true
                favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                addToFavorites()
            }
        }
    
    private func removeFromFavorites() {
            // Implemente a lógica para remover o personagem dos favoritos (se necessário)
            // Isso envolverá a exclusão da entrada correspondente na entidade de Favoritos
        }
    
    private func addToFavorites() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            dataManager = appDelegate.persistentContainer.viewContext

            // Verifica se o personagem já existe nos Favoritos com base no 'id'
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
            fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: character.id))

            do {
                if (try dataManager.fetch(fetchRequest).first as? NSManagedObject) == nil {
                    // Cria uma nova entidade em Favoritos
                    let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: dataManager)
                    newEntity.setValue(character.firstName, forKey: "firstName")
                    newEntity.setValue(character.lastName, forKey: "lastName")
                    newEntity.setValue(character.fullName, forKey: "fullName")
                    newEntity.setValue(character.title, forKey: "title")
                    newEntity.setValue(character.id, forKey: "id")
                    newEntity.setValue(character.family, forKey: "family")
                    newEntity.setValue(character.image, forKey: "image")
                    newEntity.setValue(character.imageURL, forKey: "imageURL")

                    try dataManager.save()
                    print("Character added to Favorites successfully")
                } else {
                    print("Character already in Favorites")
                }
            } catch {
                print("Error saving data: \(error.localizedDescription)")
            }
        }
    
    
    private func setupRatingView() {
        ratingView.delegate = self
        view.addSubview(ratingView)
        NSLayoutConstraint.activate([
            ratingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ratingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            ratingView.heightAnchor.constraint(equalToConstant: 30),
            ratingView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func setupFavoriteButton() {
        view.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            favoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func ratingView(_ ratingView: RatingView, didChangeRating rating: Int) {
        saveRating(rating: rating)
    }

    func saveRating(rating: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        dataManager = appDelegate.persistentContainer.viewContext

        // Verifica se a entidade já existe no CoreData com base no 'id'
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rating")
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: character.id))

        do {
            if let existingEntity = try dataManager.fetch(fetchRequest).first as? NSManagedObject {
                // Atualiza o rating existente
                existingEntity.setValue(rating, forKey: "rate")
            } else {
                // Cria uma nova entidade
                let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Rating", into: dataManager)
                newEntity.setValue(character.firstName, forKey: "firstName")
                newEntity.setValue(character.lastName, forKey: "lastName")
                newEntity.setValue(character.fullName, forKey: "fullName")
                newEntity.setValue(character.title, forKey: "title")
                newEntity.setValue(character.id, forKey: "id")
                newEntity.setValue(character.family, forKey: "family")
                newEntity.setValue(character.image, forKey: "image")
                newEntity.setValue(character.imageURL, forKey: "imageURL")
                newEntity.setValue(rating, forKey: "rate")
            }

            try dataManager.save()
            print("Data saved successfully")

            // Atualiza a exibição do RatingView após salvar
            ratingView.rating = rating
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

}

class RatingView: UIView {
    private var starButtons: [UIButton] = []
    weak var delegate: RatingViewDelegate?

    var rating: Int = 0 {
        didSet {
            updateStars()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
    }

    private func setupStars() {
        for i in 0..<5 {
            let starButton = UIButton()
            starButton.translatesAutoresizingMaskIntoConstraints = false
            starButton.tag = i
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
            starButton.tintColor = .yellow
            starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            addSubview(starButton)
            starButtons.append(starButton)
        }

        var leadingAnchor: NSLayoutXAxisAnchor = self.leadingAnchor
        for starButton in starButtons {
            NSLayoutConstraint.activate([
                starButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                starButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                starButton.widthAnchor.constraint(equalToConstant: 30),
                starButton.heightAnchor.constraint(equalToConstant: 30)
            ])
            leadingAnchor = starButton.trailingAnchor
        }
    }

    @objc private func starButtonTapped(_ sender: UIButton) {
        rating = sender.tag + 1
        updateStars()
        delegate?.ratingView(self, didChangeRating: rating)
    }

    private func updateStars() {
        for i in 0..<starButtons.count {
            starButtons[i].isSelected = i < rating
        }
    }
}

