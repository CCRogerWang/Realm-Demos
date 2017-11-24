//
//  RLM_User.swift
//  TapGame
//
//  Created by roger.wang on 2017/11/21.
//  Copyright © 2017年 roger.wang. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RLM_User: Object {
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    // MARK: - Persisted Properties
    dynamic var name = ""
    dynamic var timestamp = Date().timeIntervalSinceReferenceDate
    dynamic var tapCount: Int = 0
    
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
