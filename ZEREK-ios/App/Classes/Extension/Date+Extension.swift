//
//  Date+Extension.swift
//  ZEREK
//
//  Created by bakebrlk on 23.04.2025.
//

import Foundation

extension Date {
    var toString: String  {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        return outputFormatter.string(from: self)
    }
      var toString1: String  {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d"
        return outputFormatter.string(from: self)
    }
    
      var toString2: String  {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:MM"
        return outputFormatter.string(from: self)
    }
    
    
}
