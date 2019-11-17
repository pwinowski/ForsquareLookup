//
//  ViewController.swift
//  ForsquareLookup
//
//  Created by Patryk Winowski on 12/11/2019.
//  Copyright © 2019 Patryk Winowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VenuesPresenterDelegate {
    
    
    // next phase would be dependency injection, but let it be for now
    let presenter = VenuesPresenter()

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var resultsTable: UITableView!
    
    var onCredentialsSubmit: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDelegate = self
        resultsTable.dataSource = self
        resultsTable.delegate = self
        
    }

    @IBAction func onAnyTextInput(_ sender: UITextField) {
        if let input = sender.text {
            presenter.onVenueNameInput(input)
        }
    }
    
    // MARK:------- VenuesPresenterDelegate ----------
    
    func refreshVenuesList() {
        resultsTable.reloadData()
    }
    
    func askForCredentials(completion: @escaping (String, String) -> Void) {
        self.onCredentialsSubmit = completion
        performSegue(withIdentifier: "popupRequest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let credentialsVc = segue.destination as? CredentialsController {
            credentialsVc.onSubmit = self.onCredentialsSubmit
        }
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let venueCell = resultsTable.dequeueReusableCell(withIdentifier: "venueCell") {
            venueCell.textLabel?.text = presenter.rows[indexPath.item].name
            venueCell.detailTextLabel?.text = "\(presenter.rows[indexPath.item].address) -> \(presenter.rows[indexPath.item].distance) m"
            return venueCell
        }
        return UITableViewCell()
    }
    
    
}

