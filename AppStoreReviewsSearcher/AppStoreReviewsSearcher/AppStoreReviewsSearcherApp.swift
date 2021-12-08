//
//  AppStoreReviewsSearcherApp.swift
//  AppStoreReviewsSearcher
//
//  Created by Sahil Gangele on 11/13/21.
//

import SwiftUI

@main
struct AppStoreReviewsSearcherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 700, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity, alignment: .center)
        }
        .commands {
            SidebarCommands()
        }
    }
}
