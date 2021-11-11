//
//  MazProjectApp.swift
//  MazProject
//
//  Created by Yannis Lang on 31/10/2021.
//

import SwiftUI

@main
struct MazProjectApp: App {
    var body: some Scene {
        WindowGroup {
            MazeView(map: Map.testMap)
        }
    }
}
