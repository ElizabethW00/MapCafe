import UIKit

class MyCafeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var ratingView: StarRatingView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    //    private var onComplete: (() -> Void)?
//
//    @IBAction func completeButtonTapped(_ sender: UIButton) {
//        onComplete?()
//    }
    
    func configure(with cafe: myCafe, onCompleteButtonTapped: @escaping (myCafe) -> Void) {
            name.text = cafe.name
            location.text = cafe.location
            note.text = cafe.note ?? "No note"
            ratingView.rating = cafe.rating
            
            // Price — show $ symbols based on length
            price.text = String(repeating: "$", count: cafe.price.count)

            // Set image from imageData (preferred) or fallback to imageName
            if let image = cafe.image {
                imageFood.image = image
            } else if let imageName = cafe.imageName, let fallback = UIImage(named: imageName) {
                imageFood.image = fallback
            } else {
                imageFood.image = UIImage(systemName: "photo")
            }
        }

        override func awakeFromNib() {
            super.awakeFromNib()
            imageFood.layer.cornerRadius = 8
            imageFood.clipsToBounds = true
            imageFood.contentMode = .scaleAspectFill
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
}

