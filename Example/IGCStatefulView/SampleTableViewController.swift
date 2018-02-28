//
//  ViewController.swift
//  StatefulListSample
//
//  Created by Jason Jon E. Carreos on 22/02/2018.
//  Copyright © 2018 Ingenuity Global Consulting, Inc. All rights reserved.
//

import UIKit

import IGCStatefulView

class SampleTableViewController: UIViewController {
    
    // MARK: Constants
    
    let cellIdentifier = "ItemCell"
    
    // MARK: Properties
    
    lazy var items: [String] = {
        var items: [String] = []
        
        for i in 1...20 {
            items.append("Row \(i)")
        }
        
        return items
    }()
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        }
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.setViewDataState(.loading(message: "Loading...", styleParams: nil))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let status: IGCViewState = .error(
                image: UIImage(named: "icon"),
                title: "Error",
                message: "Please try again later",
                styleParams: ["title": ["font": UIFont(name: "HelveticaNeue-Bold", size: 30),
                                        "color": UIColor.darkGray],
                              "message": ["font": UIFont(name: "HelveticaNeue", size: 20),
                                          "color": UIColor.lightGray],
                              "image": ["size": 100],
                              "indicator": ["tint": UIColor.black],
                              "button": ["font": UIFont(name: "HelveticaNeue", size: 16),
                                         "color": UIColor.black]],
                buttonAction: { button in
                    let alert = UIAlertController(title: "Alert",
                                                  message: button.title(for: .normal),
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok",
                                                  style: .default,
                                                  handler: nil))
                    self.present(alert, animated: true, completion: nil)
            })
            
            self.tableView.setViewDataState(status)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SampleTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
}

