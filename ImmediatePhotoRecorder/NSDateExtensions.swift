//
//  NSDateExtensions.swift
//  Parstagram
//
//  Created by Nathan Miranda on 3/27/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit

extension NSDate{
    func timePassedSinceAsString() -> String {
        var timeSince: String?
        let createdAt = self
        //Time keeps on tickin' tickin' tickin'
        let now = NSDate()
        let then = createdAt
        let timePassed = Int(now.timeIntervalSinceDate(then))
        if timePassed >= 31536000{
            timeSince = String(timePassed/31536000)+"y"
        }else if timePassed >= 2628000{
            timeSince = String(timePassed/2628000)+"m"
        }else if timePassed >= 86400{
            timeSince = String(timePassed/86400)+"d"
        }else if (3600..<86400).contains(timePassed){
            timeSince = String(timePassed/3600)+"h"
        }else if (60..<3600).contains(timePassed){
            timeSince = String(timePassed/60)+"m"
        }else if timePassed < 60 {
            timeSince = String(timePassed)+"s"
        }//End Times
        return timeSince!
    }
}

