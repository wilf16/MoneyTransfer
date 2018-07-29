//
//  MoneyTransferRequest.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

class MoneyTransferRequest {
    internal var endpoint = URL(string: "<endpoint>")
    let json:[String:Any]
    
    init(data:[String:Any])
    {
        json = data
    }
    
    func request() throws -> URLRequest
    {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        guard let url = endpoint else { throw MoneyTransferAPIError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
