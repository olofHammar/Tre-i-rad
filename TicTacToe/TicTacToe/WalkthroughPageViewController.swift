//
//  WalkthroughPageViewController.swift
//  TicTacToe
//
//  Created by Olof Hammar on 2021-01-13.
//

import UIKit

protocol walkthroughPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}


//This class handles the pageViewControllers index when moving between pages, and sets the content of each page.
class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    weak var walkthroughDelegate: walkthroughPageViewControllerDelegate?
    
    /*
     Here I create an array of strings containing the text of each page and below I do the
     same with the images. Current index is set to 0 so that the walkthrough always start on the first page.
    */
    var headings = ["Welcome to Tic Tac Toe!\n Lets start with a quick tutorial.", "Click here to start a new game\n or set names of the players.", "Click here to start a new game \n with the current players.","This counter keeps track of the score.", "Click here to reset the scores.", "Click here to switch between\n one and two-player mode."]
    
    var images = ["welcome_chalkboard", "start_new_game_image", "rematch_image", "keep_track_of_wins_image", "reset_score_image", "change_player_mode_image"]
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }

    }
    /*
     These two methods below manages the index of the pageController as it scrolls back and forth
    */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                currentIndex = contentViewController.index
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
        
    }
    /*
     This method sets the variables from the WalkthroughContentViewController-class to the values set in the arrays of text and images in this class and connects them to the
     correct storyboard. 
     */
    func contentViewController (at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= headings.count {
            return nil
        }
        
        let storyBoard = UIStoryboard (name: "onBoarding", bundle: nil)
        if let pageContentViewController = storyBoard.instantiateViewController(identifier: "WalkthtroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = images[index]
            pageContentViewController.heading = headings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    /*
     This method gets called from the WalkthroughViewController-class when the
     next-button i tapped.
     */
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}
