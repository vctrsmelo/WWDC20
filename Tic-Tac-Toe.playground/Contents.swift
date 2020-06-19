/**
 Created by: Victor S. Melo
 - http://www.victormelo.com.br
 - https://www.linkedin.com/in/vsmelo/
 */


import SwiftUI
import PlaygroundSupport

public struct ContentView: View {
    public var body: some View {
        VStack {
            StartingView()
        }
    }
}

let view = UIHostingController(rootView: ContentView())
view.preferredContentSize = CGSize(width: 500, height: 700)

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view
