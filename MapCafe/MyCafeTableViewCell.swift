import UIKit

class MyCafeTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingView: StarRatingView!
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!

//    private var onComplete: (() -> Void)?
//
//    @IBAction func completeButtonTapped(_ sender: UIButton) {
//        onComplete?()
//    }

    func configure(with cafe: myCafe, onCompleteButtonTapped: @escaping (myCafe) -> Void) {
        name.text = cafe.name
        ratingView.rating = cafe.rating  // ← directly set the custom view's rating
        price.text = String(repeating: "$", count: cafe.price.count)
        location.text = cafe.location
        note.text = cafe.note ?? "No note"

        if let imageName = cafe.imageName, let image = UIImage(named: imageName) {
            imageFood.image = image
        } else {
            imageFood.image = UIImage(systemName: "photo")
        }
    }



    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

