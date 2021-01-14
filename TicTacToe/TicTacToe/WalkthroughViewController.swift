//
//  WalkthroughViewController.swift
//  TicTacToe
//
//  Created by Olof Hammar on 2021-01-13.
//

import UIKit

/*
 This class handles connections and actions for the pagecontroller and the buttons in the walkthrough.
 */
class WalkthroughViewController: UIViewController, walkthroughPageViewControllerDelegate {
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25
            nextButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var skipButton: UIButton!
    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    //This function dismisses the walkthrough.
    @IBAction func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "walkthroughHasBeenSeen")
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...4:
                walkthroughPageViewController?.forwardPage()
                
            case 5:
                UserDefaults.standard.set(true, forKey: "walkthroughHasBeenSeen")
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
        updateUI()
    }
    
    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...4:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
            case 5:
                nextButton.setTitle("START GAME", for: .normal)
                skipButton.isHidden = true
            default:
                break
            }
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        
        updateUI()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
}
