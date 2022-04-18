//
//  DataRealm.swift
//  14.3
//
//  Created by Satyavrata on 16.04.2022.
//

import Foundation
import RealmSwift

class DataRealm: Object {
    @Persisted var name = ""
    @Persisted var status = ""
    @Persisted var image = ""
    @Persisted var gender = ""
    @Persisted var location = ""
}
