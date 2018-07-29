//
//  MoneyTransferViewModel.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

class MoneyTransferReportViewModel {
    
    lazy var from: String = report.from
    lazy var to: String = report.to
    lazy var amount: String = report.transferAmount
    lazy var date: String = report.date
    lazy var notes:String? = report.personalNotes
    lazy var message:String? = report.messageToReceiver
    
    var report:TransferReport
    var doneViewingReport:() -> Void
    init(report:TransferReport, completionHandler:@escaping () -> Void) {
        self.report = report
        self.doneViewingReport = completionHandler
    }
    
    //MARK: - External Actions
    func doneWithReport()
    {
        doneViewingReport()
    }
}
