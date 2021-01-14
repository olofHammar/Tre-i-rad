//
//  WalkthroughContentViewController.swift
//  TicTacToe
//
//  Created by Olof Hammar on 2021-01-13.
//

import UIKit

//Here is set the connections and default-content in the tutorial-pages.
class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var contentImageView: UIImageView!
    
    var index = 0
    var heading = ""
    var imageFile = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        contentImageView.image = UIImage(named: imageFile)
    }

}
