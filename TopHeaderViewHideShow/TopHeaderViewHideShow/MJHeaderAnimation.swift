//
//  MJHeaderAnimation.swift
//  NavigationHideShowOnScroll
//
//  Created by MAC111 on 10/19/18.
//  Copyright © 2018 MAC111. All rights reserved.
//

import UIKit

public protocol MJHeaderViewScrollviewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
}

class MJHeaderAnimation: UIView {
    
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint! //Height constraint for custom view

    var previousScrollOffset: CGFloat = 0
    var maxHeaderHeight: CGFloat = 0
    var minHeaderHeight: CGFloat = 0
    var tabBarHeight: CGFloat = 0
    var tblView: UITableView?
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgHeader: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initializationTopViewSettings(_ table: UITableView, _ title: String, _ minimumHeaderHeight: CGFloat) {
        self.tblView = table
        self.lblTitle.text = title
        self.minHeaderHeight = minimumHeaderHeight
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.maxHeaderHeight = self.headerHeightConstraint.constant
        self.lblTitle.alpha = 0
        self.updateHeader()

    }
 

}

extension MJHeaderAnimation: MJHeaderViewScrollviewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        let absoluteTop: CGFloat = 0
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        if canAnimateNavigation(scrollView) {
            var newHieght = self.headerHeightConstraint.constant
            if isScrollingDown {
                newHieght = max(self.minHeaderHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
//                Global.global.TabContainerVC?.changeHieght(newHieght)
            } else if isScrollingUp {
                newHieght = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
//                Global.global.TabContainerVC?.changeHieght(newHieght)
            }
            
            if newHieght != self.headerHeightConstraint.constant {
                self.headerHeightConstraint.constant = newHieght
                self.updateHeader()
//                Global.global.TabContainerVC?.changeHieght(newHieght)
                self.setScrollPosition(self.previousScrollOffset)
            }
            
            self.previousScrollOffset = scrollView.contentOffset.y
        }
    }

    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }
    
    func scrollViewDidStopScrolling() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)
        
        if self.headerHeightConstraint.constant > midPoint {
            self.expandHeader()
        } else {
            self.collapseHeader()
        }
    }
    
    func canAnimateNavigation(_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func collapseHeader() {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.updateHeader()
            self.layoutIfNeeded()
        }
    }
    
    func expandHeader()  {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.updateHeader()
            self.layoutIfNeeded()
        }
    }
    
    func setScrollPosition(_ position: CGFloat) {
        self.tblView!.contentOffset = CGPoint(x: self.tblView!.contentOffset.y, y: position)
    }
    
    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.headerHeightConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
        self.lblTitle.alpha = 1.0 - percentage
        self.imgHeader.alpha = percentage
    }
}
