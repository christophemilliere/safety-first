//
//  DataExtension.swift
//  Safety First
//
//  Created by Christophe on 18/09/2018.
//  Copyright © 2018 Christophe. All rights reserved.
//

import Foundation

extension Data {
    init?(countOfRandomData:Int) {
        self.init(count: countOfRandomData)
        let result = self.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, countOfRandomData, $0)
        }
        if result != errSecSuccess {
            return nil
        }
    }
}
