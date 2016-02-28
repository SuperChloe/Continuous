//
//  PageViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-27.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    let orderedViewControllers: [UIViewController] = [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HabitCollectionViewController"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CreateViewController"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .Reverse, animated: true, completion: nil)
        }
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

}
