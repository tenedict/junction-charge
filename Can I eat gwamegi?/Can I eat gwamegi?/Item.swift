//
//  Item.swift
//  Can I eat gwamegi?
//
//  Created by 문재윤 on 8/10/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
