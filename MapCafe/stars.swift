import UIKit

class StarRatingView: UIView {
    private var starImageViews: [UIImageView] = []
    var rating: Float = 0 {
        didSet {
            updateStars()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStars()
    }

    private func setupStars() {
        // Find the stack view (assuming only one subview which is your UIStackView)
        guard let stackView = subviews.compactMap({ $0 as? UIStackView }).first else {
            print("No UIStackView found in StarRatingView")
            return
        }
        // Access the UIImageViews inside the stack view's arrangedSubviews
        starImageViews = stackView.arrangedSubviews.compactMap { $0 as? UIImageView }
        
        // Set tags and enable interaction for each star
        for (index, star) in starImageViews.enumerated() {
            star.tag = index + 1
            star.isUserInteractionEnabled = true
        }
    }

    private func updateStars() {
        for star in starImageViews {
            let starIndex = Float(star.tag)
            if rating >= starIndex {
                star.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            } else if rating + 0.5 >= starIndex {
                star.image = UIImage(systemName: "star.lefthalf.fill")?.withRenderingMode(.alwaysTemplate)
            } else {
                star.image = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
            }
            star.tintColor = .systemYellow
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouch(touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouch(touches)
    }

    private func handleTouch(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        print("Touch at \(point)")

        for star in starImageViews {
            if point.x >= star.frame.minX && point.x <= star.frame.maxX {
                let relativeX = point.x - star.frame.minX
                let half = star.frame.width / 2
                rating = Float(star.tag) - (relativeX < half ? 0.5 : 0.0)
                return
            }
        }

        if let lastStar = starImageViews.last, point.x > lastStar.frame.maxX {
            rating = Float(starImageViews.count)
        }

        if let firstStar = starImageViews.first, point.x < firstStar.frame.minX {
            rating = 0
        }
    }
}
