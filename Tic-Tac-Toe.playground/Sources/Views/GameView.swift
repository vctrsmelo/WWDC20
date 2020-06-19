//
//  GameView.swift
//  TicTacToe
//
//  Created by Victor Melo on 11/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import SwiftUI

public struct GameView: View {
    
    @Environment(\.presentationMode) public var presentationMode: Binding<PresentationMode>
    
    @State public var gameState: GameState = .playerPlaying

    @Binding public var board: Board
    @State public var currentShiftingDirection: ShiftPlay.ShiftDirection = .none
    @State public var isAnimating: Bool = false
    
    private let robot = Robot()

    public var boardView: BoardView {
        BoardView(board: $board, currentShiftingDirection: $currentShiftingDirection, gameState: $gameState)
    }
    
    public var body: some View {
        
        return ZStack {
            Color.green
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    RobotFaceView(imageName: robot.faceImageName)
                    RobotChatView(text: robot.getMessage(gameState))
                }
                .padding(.top, 10)
                Spacer()
                    .frame(height: GameSizes.GameView.fixedSpacerHeight)
                ZStack {
                    boardView
                    boardOverlayView
                    
                }.frame(width: CGFloat(boardView.board.dimension*GameConfig.cellWidth),
                        height: CGFloat(boardView.board.dimension*GameConfig.cellWidth),
                        alignment: .center)
                
                Group {
                    Text(middleTextMessage)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 18, weight: .medium, design: .default))
                        .opacity((board.terminal() || currentShiftingDirection != .none) ? 1 : 0)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Play Again")
                            .font(Font.system(size: 18))
                    }
                    .buttonStyle(CustomButtonStyle(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)))
                    .opacity(board.terminal() ? 1 : 0)
                }
                Spacer()
                Group {
                    Text("Hacks Available:")
                    .foregroundColor(.white)
                    .font(Font.system(size: 20, weight: .bold, design: .default))
                        .padding(.bottom, 5)
                    HStack {
                        getHackingButton("ArrowTop", direction: .top)
                        getHackingButton("ArrowBottom", direction: .bottom)
                        getHackingButton("ArrowLeft", direction: .left)
                        getHackingButton("ArrowRight", direction: .right)
                    }
                }
                .opacity(board.terminal() || board.isBoardEmpty ? 0.5 : 1)
                Spacer()
                    .frame(height: GameSizes.GameView.fixedSpacerHeight)
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)

    }
    
    private var middleTextMessage: String {
        if (gameState == GameState.playerWin) {
            return "You won!🎉👯‍♀️\nHumanity is proud of you"
        } else if gameState == .robotWin {
            return "You lost!🤕😿\nHumanity couldn't beat robots again"
        } else if gameState == .draw {
            return "Draw!🤕😿\nHumanity couldn't beat robots again"
        } else if currentShiftingDirection != .none {
            if currentShiftingDirection == .left || currentShiftingDirection == .right {
                return "Touch the row to shift it"
            } else {
                return "Touch the column to shift it"
            }
        }
        
        return ""
    }
    
    public var boardOverlayView: some View {
        
        let delay: (Int, Int) -> Double = { x, y in
            switch self.currentShiftingDirection {
            case .top: return (Double(x)/2 + Double(GameConfig.dimension - y)/8)
            case .bottom: return (Double(x)/2 + Double(y)/8)
            case .right: return (Double(x)/8 + Double(y)/2)
            case .left: return (Double(GameConfig.dimension - x)/8 + Double(y)/2)
            case .none: return 0
            }
        }
        
        return HStack(spacing: 0) {
            ForEach((0 ..< GameConfig.dimension), id: \.self) { x in
                VStack(spacing: 0) {
                    ForEach((0 ..< GameConfig.dimension), id: \.self) { y in
                        Color.yellow
                            .frame(width: CGFloat(GameConfig.cellWidth),
                                   height: CGFloat(GameConfig.cellWidth),
                                   alignment: .center)
                                   .opacity(self.isAnimating ? 1 : 0)
                                   .border(Color.black, width: 1)
                                        .allowsHitTesting(false)
                                        .animation(
                                            Animation.easeOut(duration: 1)
                                                .repeatCount(1, autoreverses: true)
                                                .delay(delay(x, y))
                                        )
                    }
                }
            }
        }
    }

    private func getHackingButton(_ imageName: String, direction: ShiftPlay.ShiftDirection) -> some View {
        
        VStack {
            Button(action: {
                guard self.board.terminal() == false && self.board.isBoardEmpty == false && self.gameState == .playerPlaying else { return }
                self.gameState = self.gameState.getNext(self.board, nextExpected: .playerHacking)
                self.currentShiftingDirection = direction
                self.isAnimating.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isAnimating = false
                }
            }) {
                Image(uiImage: UIImage(named: imageName)!)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }.buttonStyle(CustomButtonStyle(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)))
                .padding(.bottom, 5)
            
            Text("Shift  \(direction.rawValue)")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 18, weight: .medium, design: .default))
                .frame(width: 115)
        }
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
