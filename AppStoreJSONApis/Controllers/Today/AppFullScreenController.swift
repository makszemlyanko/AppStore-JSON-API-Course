//
//  AppFullScreenController.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 05.07.2022.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.item == 0 {
            return AppFullScreenHeaderCell()
        }
        
        let cell = AppFullScreenDescriptionCell()
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
 
}
