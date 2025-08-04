//
//  MyCafeViewController.swift
//  MapCafe
//
//  Created by Elizabeth Woo on 8/3/25.
//

import UIKit

class MyCafeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var myCafes = [myCafe]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("ATTEMPT CELL")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCafeTableViewCell", for: indexPath) as! MyCafeTableViewCell
        
        print("CELL CREATED")
            
            let cafe = myCafes[indexPath.row]  // Avoid shadowing by using a different name
            
            cell.configure(with: cafe, onCompleteButtonTapped: { [weak self] (selectedCafe: myCafe) in
                selectedCafe.save()
                self?.refreshMyCafe()
            })
            
            return cell
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Hide top cell separator
        tableView.tableHeaderView = UIView()

        // Set table view data source
        // Needed for standard table view setup:
        //    - tableView(numberOfRowsInSection:)
        //    - tableView(cellForRowAt:)
        // Also for swipe to delete row:
        //    - tableView(_:commit:forRowAt:)
        tableView.dataSource = self

        // Set table view delegate
        // Needed to detect row selection: tableView(_:didSelectRowAt:)
        tableView.delegate = self
    }
    
    // Refresh the myCafes list each time the view appears in case any myCafes were updated on the other tab.
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        refreshMyCafe()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshMyCafe()
    }

    
    @IBAction func didTapNewmyCafeButton(_ sender: Any) {
        performSegue(withIdentifier: "ComposeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let composeViewController = segue.destination as? composeViewController {
            composeViewController.myCafeToEdit = sender as? myCafe
            composeViewController.onComposemyCafe = { [weak self] myCafe in
                print("Saving cafe: \(myCafe.name)")
                myCafe.save()
                self?.refreshMyCafe()
            }
        }
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ComposeSegue" {
//            if let composeNavController = segue.destination as? UINavigationController,
//               let composeViewController = composeNavController.topViewController as? composeViewController {
//                composeViewController.myCafeToEdit = sender as? myCafe
//                composeViewController.onComposemyCafe = { [weak self] myCafe in
//                    print("Saving cafe: \(myCafe.name)")
//                    myCafe.save()
//                    self?.refreshMyCafe()
//                }
//            }
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
    */
    private func refreshMyCafe() {
        let myCafes = myCafe.getmyCafes()
        print("Refreshed cafes: \(myCafes.map { $0.name })")
        self.myCafes = myCafes
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
    

}
