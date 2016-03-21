//
//  PageViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-27.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit

protocol PagingProtocol {
    
    func goToHabitCollection(from: UIViewController)
    func goToDetail(habit: Habit)
    
}

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, PagingProtocol {
    
    let createViewController: CreateViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CreateViewController") as! CreateViewController
    let habitCollectionViewController: HabitCollectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HabitCollectionViewController") as! HabitCollectionViewController
    
    lazy var orderedViewControllers: [UIViewController] = {[
        self.createViewController,
        self.habitCollectionViewController,
    ]}()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        createViewController.delegate = self
        habitCollectionViewController.delegate = self
        
        goToHabitCollection(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// *************************************
// MARK: UIPageViewControllerDataSource
// *************************************
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            if viewController.isKindOfClass(DetailViewController) {
                // Bug fix when DetailViewController has been popped from orderedViewControllers but is still loaded in PageViewController
                return orderedViewControllers[1]
            }
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]

    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return nil
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
// *************************************
// MARK: UIPageViewControllerDelegate
// *************************************
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            return
        }
        
        if let previous = previousViewControllers.first {
            if previous.isKindOfClass(DetailViewController) {
                discardDetail()
            }
        }
    }
    
// *************************************
// MARK: PagingProtocol
// *************************************
    
    func goToHabitCollection(from: UIViewController) {
        if from.isKindOfClass(DetailViewController) {
            setViewControllers([habitCollectionViewController], direction: .Reverse, animated: true, completion: { (_) -> Void in
                self.discardDetail()
            })
        } else {
            setViewControllers([habitCollectionViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func goToDetail(habit: Habit) {
        let detailViewController: DetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailViewController.habit = habit
        detailViewController.delegate = self
        if orderedViewControllers.count > 2 {
            orderedViewControllers = Array(orderedViewControllers[0...1])
        }
        orderedViewControllers.append(detailViewController)
        
        setViewControllers([detailViewController], direction: .Forward, animated: true, completion: nil)
    }
    
// *************************************
// MARK: Helper methods
// *************************************
    
    func discardDetail() {
        orderedViewControllers = Array(orderedViewControllers[0...1])
        
        dispatch_async(dispatch_get_main_queue()) {
            // 'Reload data' hack
            self.dataSource = nil
            self.dataSource = self
        }
    }

}
