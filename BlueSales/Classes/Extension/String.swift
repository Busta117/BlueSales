//
//  String.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit

extension String {
    var isFullyEmpty: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
}
