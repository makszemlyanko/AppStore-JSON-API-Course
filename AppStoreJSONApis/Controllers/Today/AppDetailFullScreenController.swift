//
//  AppDetailFullScreenController.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 05.09.2022.
//

import UIKit

class AppDetailFullScreenController: UITableViewController {
    
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
            // hack
            let cell = UITableViewCell()
            let todayCell = TodayCell()
            cell.addSubview(todayCell)
            todayCell.centerInSuperview(size: .init(width: 250, height: 250))
            return cell
        }
        
        let cell = AppDetailFullScreenCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }}
