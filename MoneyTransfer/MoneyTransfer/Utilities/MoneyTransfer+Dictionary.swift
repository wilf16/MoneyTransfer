//
//  MoneyTransfer+Dictionary.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
extension Dictionary{
    var jsonString:String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            return String(data: data, encoding: String.Encoding.utf8)!
        }catch{
            return nil
        }
    }
}
