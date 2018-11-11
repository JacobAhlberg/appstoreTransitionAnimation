//
//  ViewController.swift
//  appstoreAnimation
//
//  Created by Jacob Ahlberg on 2018-11-10.
//  Copyright © 2018 Jacob Ahlberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var selectedCell: UICollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCell = collectionView.cellForItem(at: indexPath)
        let detailVC = DetailVC.create()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCell
        
        return cell
    }
    
    
}

extension ViewController: Animatable {
    var containerView: UIView? {
        return self.collectionView
    }
    
    var childView: UIView? {
        return self.selectedCell
    }
}

