//
//  StringExtensions.swift
//  ImmediatePhotoRecorder
//
//  Created by Nathan Miranda on 3/25/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit

extension String {
    func isWhitespace() -> Bool {
        return (self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty)
    }
}
