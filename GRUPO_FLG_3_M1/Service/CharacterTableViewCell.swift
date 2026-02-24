import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7) // Opacidade mais escura (70% preto)
        return view
    }()

    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        addSubview(characterImageView)
        addSubview(overlayView)
        addSubview(firstNameLabel)
        addSubview(lastNameLabel)

        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            characterImageView.widthAnchor.constraint(equalTo: widthAnchor),

            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.widthAnchor.constraint(equalTo: widthAnchor),

            firstNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            firstNameLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4),

            lastNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            lastNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            lastNameLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 4)
        ])
    }

    func configure(with character: Character) {
        firstNameLabel.text = character.firstName
        lastNameLabel.text = character.lastName

        if let url = URL(string: character.imageURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        self.characterImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}

