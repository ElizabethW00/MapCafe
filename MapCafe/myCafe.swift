//
//  myCafe.swift
//  MapCafe
//
//  Created by Elizabeth Woo on 8/3/25.
//

import UIKit

struct myCafe: Codable, Equatable {
    var name: String
    var location: String
    var rating: Float       // 1–5
    var price: String          // 1–4
    var note: String?
    var date: Date
    var imageData: Data?    // Store image as Data
    var imageName: String?

    private(set) var id: String = UUID().uuidString
    private(set) var createdDate: Date = Date()

    var image: UIImage? {
        get {
            if let data = imageData {
                return UIImage(data: data)
            }
            return nil
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }

    init(name: String,
         note: String? = nil,
         rating: Float,
         price: String,
         date: Date = Date(),
         location: String,
         image: UIImage? = nil,
         imageName: String? = nil) {
        self.name = name
        self.note = note
        self.rating = rating
        self.price = price
        self.date = date
        self.location = location
        self.image = image
        self.imageName = imageName
    }
}

// MARK: - myCafe + UserDefaults
extension myCafe {
    
    static let storageKey = "myCafes"

    static func save(_ myCafes: [myCafe]) {
        let defaults = UserDefaults.standard
        do {
            let encodedData = try JSONEncoder().encode(myCafes)
            defaults.set(encodedData, forKey: storageKey)
            print("Saved \(myCafes.count) cafes")
        } catch {
            print("Failed to encode cafes: \(error)")
        }
    }

    static func getmyCafes() -> [myCafe] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: storageKey) {
            do {
                return try JSONDecoder().decode([myCafe].self, from: data)
            } catch {
                print("Failed to decode cafes: \(error)")
                return []
            }
        }
        return []
    }

    func save() {
        var savedmyCafes = myCafe.getmyCafes()
        if let idx = savedmyCafes.firstIndex(where: { $0.id == self.id }) {
            savedmyCafes[idx] = self
        } else {
            savedmyCafes.append(self)
        }
        myCafe.save(savedmyCafes)
    }
}
