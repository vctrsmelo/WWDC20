//
//  ButtonView.swift
//  TicTacToe
//
//  Created by Victor Melo on 11/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import SwiftUI

public struct ButtonView: View {
    
    public let imageName: String
    public let text: String
    
    public init(_ imageName: String, text: String) {
        self.imageName = imageName
        self.text = text
    }

    public var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .padding(20)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
                .shadow(color: .darkBlue, radius: 1, x: 0, y: 4)
            Text(text)
                .multilineTextAlignment(.center)
            
        }
    }
}

public struct ButtonView_Previews: PreviewProvider {
    public static var previews: some View {
        ButtonView("T", text: "Text")
    }
}
