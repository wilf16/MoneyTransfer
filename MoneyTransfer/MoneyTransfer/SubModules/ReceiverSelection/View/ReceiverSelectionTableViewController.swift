//
//  ReceiverSelectionViewcontroller.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
import UIKit

class ReceiverSelectionTableViewController: UITableViewController {
    
    var viewModel:ReceiverSelectionViewModel?
    var dataSource:[(name:String,bank:String,account:String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ReceiverAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountCell")
        dataSource = viewModel?.items ?? []
        tableView.reloadData()
    }
    
    //MARK: - UITableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! ReceiverAccountTableViewCell
        
        let item = dataSource[indexPath.row]
        cell.nameLabel.text = item.name
        cell.bankLabel.text = item.bank
        cell.accountLabel.text = item.account
        
        return cell
    }
    //MARK: - UITableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.selectedAccount(indexPath.row)
    }
}
