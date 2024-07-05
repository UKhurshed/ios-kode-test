//
//  String + Extension.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 28.05.2024.
//

import Foundation


extension String {
    
    func calculateToAge() -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let birthdayDate = dateFormater.date(from: self)
        if let birthdayDate, let calendar: NSCalendar = NSCalendar(calendarIdentifier: .gregorian)  {
            let now = Date()
            let calcAge = calendar.components(.year, from: birthdayDate, to: now, options: [])
            let age = calcAge.year
            return age ?? -1
        } else {
            return -1
        }
    }
    
    func formattedPhone() -> String {
        var result = "+7 ("
        var splitNumber = self.split(separator: "-")
        result += "\(splitNumber.removeFirst())" + ") "
        
        result += "\(splitNumber.removeFirst()) "
        
        let lastPart = splitNumber.joined().split(separator: "")
        
        for i in 0..<lastPart.count {
            if i % 2 != 0 && i != 3 {
                result += lastPart[i]
                result += " "
            } else {
                result += lastPart[i]
            }
        }
        
        return result
    }
    
    func formattedPhoneToTel() -> String {
        var result = "7"
        var splitNumber = self.split(separator: "")
        splitNumber.forEach { value in
            if !value.contains("-") {
                result += value
            }
        }
        
        return result
    }
    
    func calculateBirthday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: convertToDate() ?? Date())
    }
    
    private func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return nil }
        return date
    }
}
