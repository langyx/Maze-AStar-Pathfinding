//
//  SafeCollection.swift
//  MazProject
//
//  Created by Yannis Lang on 01/11/2021.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
