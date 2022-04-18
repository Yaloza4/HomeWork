//
//  TaskList.swift
//  14.3
//
//  Created by Satyavrata on 14.04.2022.
//

import Foundation
import RealmSwift
 
class TaskList: Object {
    @objc dynamic var task = ""
    @objc dynamic var completed = false
}
