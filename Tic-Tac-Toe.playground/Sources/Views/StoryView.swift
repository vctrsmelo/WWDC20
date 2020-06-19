import Foundation
import SwiftUI

public struct StoryView: View {
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.green
            Text(kasparovBin)
                .kerning(5)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 25, weight: .medium, design: .monospaced))
                .opacity(0.15)
                .frame(width: UIScreen.main.bounds.width * 1.5)
            VStack {
                Text("Story:")
                    .font(Font.system(size: 30, weight: .bold, design: .default))
                    .padding(.top, 10)
                    .foregroundColor(.white)
                Spacer()
                Image(uiImage: UIImage(named: "Kasparov")!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                Text("Image: STAN HONDA/AFP via Getty Images")
                    .foregroundColor(.white)
                    .font(Font.system(size: 16, weight: .light, design: .monospaced))
                
                Spacer()
                Text("      In 1997, world chess champion Garry Kasparov was defeated by AI Deep Blue. The event was a shame for humanity, and since then the machines have been bragging about that victory, laughing at humans saying 'easy game'.\n     We will not accept this anymore! You, representing humanity, will face the world champion tic-tac-toe robot. However, we hacked the game and you will have some super powers that the robot does not know the existence.\n\n        Are you ready to regain glory for humanity?")
                    .font(Font.system(size: 18, weight: .medium, design: .default))
                    .frame(width: 400)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.green)
                    Spacer()
                    NavigationLink(destination: SettingsView()) {
                        Text("I'm Ready!")
                            .foregroundColor(.white)
                            .font(Font.system(size: 20, weight: .bold, design: .default))
                    }
                    .buttonStyle(CustomButtonStyle(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)))
                    Spacer()
                        .frame(height: 20)
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
