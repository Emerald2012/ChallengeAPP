//
//  ContentView.swift
//  Challenge1
//
//  Created by Home on 9/5/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) private var openURL
    @State private var statusMessage = "Waiting for scan..."

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "qrcode.viewfinder")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(statusMessage)
                .font(.headline)
        }
        .onOpenURL { url in
            handleIncomingURL(url)
        }
    }

   
    func handleIncomingURL(_ url: URL) {
        // for formatting -> challengeapp://one, challengeapp://two, etc.
        guard let challengeID = url.host?.lowercased() else {
            statusMessage = "Invalid QR Code"
            return
        }

        statusMessage = "Launching Challenge \(challengeID.capitalized)..."

        // Map  URL path to name of Shortcut in the shortcuts App
        let shortcutName: String
        switch challengeID {
        case "one":
            shortcutName = "Shortcut Name One"
        case "two":
            shortcutName = "Shazam"
        case "three":
            shortcutName = "Shortcut Name Three"
        default:
            statusMessage = "Unknown Challenge"
            return
        }

        triggerShortcut(named: shortcutName)
    }

    func triggerShortcut(named name: String) {
        // Encodes the name so spaces like "Shortcut One" work in a URL
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let shortcutURLString = "shortcuts://run-shortcut?name=\(encodedName)"
        
        if let url = URL(string: shortcutURLString) {
            openURL(url)
        }
    }
}
