//
//  SettingsView.swift
//  TicTacToe
//
//  Created by Victor Melo on 13/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import SwiftUI

public struct SettingsView: View {
    
    static private let playerOptions = "👩🧑👨👩‍🦱🧑‍🦱👨‍🦱👩‍🦲🧑‍🦲👨‍🦲👳‍♀️👳👳‍♂️🦄🌼🏳️‍🌈♥️🍎🖖"
    
    @State public var selectedDimension: Int = 3
    @State public var selectedCharacter: String = "\(SettingsView.playerOptions.first!)"
    
    @State public var board: Board = Board(dimension: GameConfig.dimension)
    
    public var body: some View {
        ZStack {
            Color.green
            VStack {
                boardSizeTitle
                    .padding(.top, 10)
                boardSizesView
                Spacer()
                    .frame(height: 50)
                yourCharacterTitle
                charactersView
                Spacer()
                NavigationLink(destination: GameView(board: self.$board)) {
                    Text("Play")
                        .font(Font.system(size: 25))
                }.buttonStyle(CustomButtonStyle(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40)))
                Spacer()
            }
        }.onAppear(perform: {
            self.board.dimension = self.selectedDimension
        })
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    public var boardSizeTitle: some View {
        Text("Board Size:")
            .font(Font.system(size: 30, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding(.bottom, 20)
    }
    
    public var boardSizesView: some View {
        HStack {
            ForEach((3 ... 5), id: \.self) { i in
                SettingsDimensionButton(dimension: i, selectedDimension: self.$selectedDimension, board: self.$board)
            }
        }
    }
    
    public var yourCharacterTitle: some View {
        Text("Your Character:")
            .font(Font.system(size: 30, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding(.bottom, 20)
    }
    
    public var charactersView: some View {
        let characterButtons = getCharacterButtons(SettingsView.playerOptions)
        let cols = characterButtons.count/3
        let rows = characterButtons.count/cols
        
        return VStack {
            ForEach((0 ..< rows), id: \.self) { i in
                HStack {
                    ForEach((i*cols..<(i*cols+cols)), id: \.self) { j in
                        characterButtons[j]
                    }
                }
            }
        }
    }
    
    public func getCharacterButtons(_ characters: String) -> [SettingsPlayerButton] {
        return characters.map {
            let button = SettingsPlayerButton(label: String($0), selectedString: $selectedCharacter)
            return button
        }
    }
}

public struct SettingsView_Previews: PreviewProvider {
    public static var previews: some View {
        SettingsView()
    }
}

public struct SettingsDimensionButton: View {

    public let dimension: Int
    @Binding public var selectedDimension: Int
    @Binding public var board: Board
    
    private var isSelected: Bool {
        dimension == selectedDimension
    }
    
    public var body: some View {
        Button(action: {
            self.selectedDimension = self.dimension
            GameConfig.dimension = self.dimension
            self.board.dimension = self.dimension
        }) {
            Text("\(dimension)x\(dimension)")
                .font(Font.system(size: 40, weight: .regular, design: .monospaced))
                .minimumScaleFactor(0.01)
                .padding(10)
                .foregroundColor(.white)
                .background(isSelected ? Color.darkGreen : Color.lightGreen)
                .cornerRadius(8.0)
                .offset(x: 0, y: isSelected ? 4 : 0)
                .shadow(color: .darkerGreen, radius: 0, x: 0, y:
                    isSelected ? -4 : 2)
        }
        .buttonStyle(CustomSettingsButtonStyle())
        .padding(10)
        .frame(maxWidth: GameSizes.SettingsView.maxBoardSizeButtonWidth)
    }
    
}

public struct SettingsPlayerButton: View {

    public let label: String
    @Binding public var selectedString: String
    
    private var isSelected: Bool {
        label == selectedString
    }
    
    public var body: some View {
        Button(action: {
            self.selectedString = self.label
            GameConfig.humanPlayer = self.label
        }) {
            Text(label)
                .font(Font.system(size: 40, weight: .regular, design: .monospaced))
                .minimumScaleFactor(0.005)
                .lineLimit(1)
                .foregroundColor(.white)
                .background(isSelected ? Color.darkGreen : Color.lightGreen)
                .cornerRadius(8.0)
                .offset(x: 0, y: isSelected ? 4 : 0)
                .shadow(color: .darkerGreen, radius: 0, x: 0, y:
                    isSelected ? -4 : 2)
        }
        .buttonStyle(CustomSettingsButtonStyle())
        .padding(5)
    }
    
}

public struct CustomSettingsButtonStyle: ButtonStyle {

  public func makeBody(configuration: Self.Configuration) -> some View {
    if configuration.isPressed {
        let impactLight = UIImpactFeedbackGenerator(style: .light)
        impactLight.impactOccurred()
    }
    
    return configuration.label
  }

}
