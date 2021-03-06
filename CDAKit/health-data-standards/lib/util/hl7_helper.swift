//
//  hl7_helper.swift
//  CDAKit
//
//  Created by Eric Whitley on 12/17/15.
//  Copyright © 2015 Eric Whitley. All rights reserved.
//

import Foundation

/**
Assistive functions to help conform to HL7 formats
*/
public class CDAKHL7Helper {
  
  /**
  Converts an HL7 timestamp into an Integer
   - parameter timestamp: [String] the HL7 timestamp. Expects YYYYMMDD format
   - returns: [Integer] Date in seconds since the epoch
  */
  public class func timestamp_to_integer(timestamp: String?) -> Double? {
    
    if let timestamp = timestamp {
      if timestamp.characters.count >= 4 {
        let year = timestamp[0...3]
        let month = timestamp.characters.count >= 6 ? timestamp[4...5] : "01"
        let day = timestamp.characters.count >= 8 ? timestamp[6...7] : "01"
        let hour = timestamp.characters.count >= 10 ? timestamp[8...9] : "00"
        let min = timestamp.characters.count >= 12 ? timestamp[10...11] : "00"
        let sec = timestamp.characters.count >= 14 ? timestamp[12...13] : "00"
        let dateString = ("\(year)\(month)\(day)\(hour)\(min)\(sec)")
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyyMMddHHmmss"
        
        dateStringFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateStringFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
        
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)
        
        if let d = d {
          return d.timeIntervalSince1970
        }
      }
    }
    
    return nil
  }
  
}