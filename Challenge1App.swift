//
//  Challenge1App.swift
//  Challenge1
//
//  Created by Home on 9/5/26.
//

import SwiftUI

@main
struct Challenge1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    // This checks if the QR code used your scheme
                    if url.scheme == "challengeone" {
                        launchShortcut(named: "Challenge1-Portrait")
                    }
                }
        }
    }
    
    func launchShortcut(named name: String) {
        #if canImport(UIKit) && os(iOS)
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let shortcutScheme = "shortcuts://run-shortcut?name=\(encodedName)"
        
        guard let url = URL(string: shortcutScheme) else { return }
        
        UIApplication.shared.open(url, options: [:]) { success in
            if success {
                // Delay exit slightly to ensure the Shortcuts app has actually launched
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    exit(0)
                }
            }
        }
        #else
        _ = name
        #endif
    }
}

