//
//  composeViewController.swift
//  MapCafe
//
//  Created by Elizabeth Woo on 8/3/25.
//

import UIKit

class composeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var ratingView: StarRatingView!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    
    //PRICE OPTION DROP DWON
    let priceOptions = ["$", "$$", "$$$", "$$$$"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priceOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priceOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priceField.text = priceOptions[row]
    }

    let imagePicker = UIImagePickerController()
        var myCafeToEdit: myCafe?
        var onComposemyCafe: ((myCafe) -> Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        //Image Picker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            imageField.isUserInteractionEnabled = true
            imageField.addGestureRecognizer(tapGesture)
        
        // 🟡 Setup price picker
        let pricePicker = UIPickerView()
        pricePicker.delegate = self
        pricePicker.dataSource = self
        priceField.inputView = pricePicker
        
        // Optionally add a toolbar with a "Done" button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        priceField.inputAccessoryView = toolbar

        // 🟡 Fill if editing
        if let myCafe = myCafeToEdit {
            nameField.text = myCafe.name
            noteField.text = myCafe.note
            locationField.text = myCafe.location
            priceField.text = myCafe.price
            imageField.image = myCafe.image
            ratingView.rating = myCafe.rating
            self.title = "Edit myCafe"
        }
    }


        // MARK: - Image Picker
    @objc func imageTapped() {
        presentImagePicker()
    }

    
    @objc func dismissPicker() {
        view.endEditing(true)
    }

        func presentImagePicker() {
            let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Photo Library", style: .default) { _ in
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true)
            })

            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                    self.imagePicker.sourceType = .camera
                    self.present(self.imagePicker, animated: true)
                })
            }

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                imageField.image = image
            }
            dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true)
        }

        // MARK: - Done Button

    @IBAction func didTapDoneButton(_ sender: Any) {
        guard let name = nameField.text, !name.isEmpty else {
            presentAlert(title: "Oops...", message: "Make sure to add a name!")
            return
        }
        
        guard let location = locationField.text, !location.isEmpty else {
            presentAlert(title: "Oops...", message: "Make sure to add a location!")
            return
        }


        let note = noteField.text
//        let location = locationField.text ?? ""
        let price = priceField.text ?? ""
        let image = imageField.image
        let rating = ratingView.rating

        var finalCafe: myCafe

        if var editingCafe = myCafeToEdit {
            editingCafe.name = name
            editingCafe.note = note
            editingCafe.location = location
            editingCafe.price = price
            editingCafe.image = image
            editingCafe.rating = rating
            finalCafe = editingCafe
        } else {
            finalCafe = myCafe(
                name: name,
                note: note,
                rating: rating,
                price: price,
                location: location,
                image: image
            )
        }

        onComposemyCafe?(finalCafe)
        dismiss(animated: true)
    }


        @IBAction func didTapCancelButton(_ sender: Any) {
            dismiss(animated: true)
        }

        // MARK: - Alert Helper

        private func presentAlert(title: String, message: String) {
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }
    }
