//
//  RobotChatView.swift
//  TicTacToe
//
//  Created by Victor Melo on 11/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import SwiftUI

public struct RobotChatView: View {
    
    public var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .bold()
            .padding(10)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(10)
    }
}

public struct RobotChatView_Previews: PreviewProvider {
    public static var previews: some View {
        RobotChatView(text: "Hello!")
    }
}
