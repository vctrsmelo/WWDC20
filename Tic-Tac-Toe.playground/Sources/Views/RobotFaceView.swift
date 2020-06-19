//
//  RobotFaceView.swift
//  TicTacToe
//
//  Created by Victor Melo on 11/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import SwiftUI

public struct RobotFaceView: View {
    
    public let imageName: String
    
    public var body: some View {
        Image(uiImage: UIImage(named: "RobotFace")!)
            .resizable()
            .frame(width: 100, height: 100, alignment: .center)
    }
}
