//
//  CustomUITabBar.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 09/09/2021.
//

import UIKit

class CustomUITabBarController: UITabBarController {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let orderedTabBarItemViews: [UIView] = {
                let interactionViews = tabBar.subviews.filter({ $0 is UIControl })
                return interactionViews.sorted(by: { $0.frame.minX < $1.frame.minX })
            }()

            guard
                let index = tabBar.items?.firstIndex(of: item),
                let subview = orderedTabBarItemViews[index].subviews.first
            else {
                return
            }

            performSpringAnimation(for: subview)
    }
    
    func performSpringAnimation(for view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }, completion: nil)
    }
}
