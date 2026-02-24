import UIKit
import CoreData

protocol StarRatingViewDelegate: AnyObject {
    func starRatingView(_ starRatingView: StarRatingView, didChangeRating rating: Int, forCell cell: UITableViewCell)
}

class StarRatingView: UIStackView {
    private let maxRating: Int = 5
    private var currentRating: Int = 0

    weak var delegate: StarRatingViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
    }

    private func setupStars() {
        for _ in 1...maxRating {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.contentMode = .scaleAspectFit
            starImageView.tintColor = .systemYellow
            starImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
            starImageView.addGestureRecognizer(tapGesture)
            addArrangedSubview(starImageView)
        }

        distribution = .fillEqually
        spacing = 2
    }

    @objc private func starTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView,
              let index = arrangedSubviews.firstIndex(of: tappedImageView) else {
            return
        }

        let newRating = index + 1
        setRating(newRating)

        if let cell = findSuperView(of: UITableViewCell.self, for: self) {
            delegate?.starRatingView(self, didChangeRating: newRating, forCell: cell)
        }
    }

    private func findSuperView<T: UIView>(of type: T.Type, for view: UIView?) -> T? {
        var currentView = view?.superview

        while currentView != nil {
            if let foundView = currentView as? T {
                return foundView
            }
            currentView = currentView?.superview
        }

        return nil
    }

    func setRating(_ rating: Int) {
        currentRating = rating
        for (index, arrangedSubview) in arrangedSubviews.enumerated() {
            if let starImageView = arrangedSubview as? UIImageView {
                starImageView.image = index < rating ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            }
        }
    }

    func getRating() -> Int {
        return currentRating
    }
}
