//
//  SampleCollectionViewController.swift
//  StatefulListSample
//
//  Created by Jason Jon E. Carreos on 23/02/2018.
//  Copyright © 2018 Ingenuity Global Consulting, Inc. All rights reserved.
//

import UIKit

import IGCStatefulView

class SampleCollectionViewController: UIViewController {
    
    // MARK: Constants
    
    let cellIdentifier = "ItemCell"
    
    // MARK: Properties
    
    lazy var items: [String] = {
        var items: [String] = []
        
        for i in 1...15 {
            items.append("Item \(i)")
        }
        
        return items
    }()
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.configureViewDataState(as: .loading(message: nil, styles: nil))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.collectionView.configureViewDataState(as: .success)
        }
    }
    
}

extension SampleCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.itemLabel.text = self.items[indexPath.row]
        
        return cell
    }
    
}

extension SampleCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = (collectionView.frame.width / 3.0) - 1
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
