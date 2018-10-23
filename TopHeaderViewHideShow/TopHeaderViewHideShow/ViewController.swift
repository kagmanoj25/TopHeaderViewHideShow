//
//  ViewController.swift
//  TopHeaderViewHideShow
//
//  Created by MAC111 on 10/23/18.
//  Copyright © 2018 MAC111. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewTop: MJHeaderAnimation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.viewTop.initializationTopViewSettings(self.tblView, "Manoj", 44)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FirstCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FirstCell
        cell.lblName.text = "\(indexPath.row) Row"
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewTop.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewTop.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        viewTop.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
}



class FirstCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
