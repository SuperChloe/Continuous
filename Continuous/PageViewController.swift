//
//  PageViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-27.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit

protocol PagingProtocol {
    
    func goToHabitCollection()
    func goToDetail(habit: Habit)
    
}

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, PagingProtocol {
    
    let createViewController: CreateViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CreateViewController") as! CreateViewController
    
    lazy var orderedViewControllers: [UIViewController] = {[
        UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HabitCollectionViewController"),
        self.createViewController,
    ]}()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        createViewController.delegate = self
        
        goToHabitCollection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
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
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
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
    
    // MARK: PagingProtocol
    
    func goToHabitCollection() {
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func goToDetail(habit: Habit) {
        
    }

}
