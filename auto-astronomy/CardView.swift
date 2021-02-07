//
//  CardView.swift
//  auto-astronomy
//
//  Created by Arpan Dhatt on 2/7/21.
//

import SwiftUI

struct CardView : View {
    
    @Binding var data : Card
    @Binding var hero : Bool
    
    @Binding var heroBinding: Bool
    
    var body: some View{
        ZStack(alignment: .topTrailing){
            VStack{
                Image(self.data.image)
                .resizable()
                .frame(height: self.data.expand ? 350 : 250)
                .cornerRadius(self.data.expand ? 0 : 25)
                if self.data.expand{
                    HStack{
                        Text(self.data.title).font(.title).fontWeight(.bold)
                        Spacer()
                    }.padding()
                    Text(self.data.details).padding(.horizontal)
                    Button(action: {
                        self.heroBinding.toggle()
                        self.hero.toggle()
                    }) {
                        Text("Create Job")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .background(LinearGradient(gradient: .init(colors: [.blue,.purple]), startPoint: .leading, endPoint: .trailing))
                            .clipShape(Capsule())
                    }
                    .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 15)
                }
            }
            .padding(.horizontal, self.data.expand ? 0 : 20).contentShape(Rectangle())
            if self.data.expand{
                Button(action: {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)){
                        self.data.expand.toggle()
                        self.heroBinding.toggle()
                        self.hero.toggle()
                    }
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.trailing,10)
            }
        }
    }
}

struct Card : Identifiable {
    
    var id : Int
    var image : String
    var title : String
    var details : String
    var expand : Bool
}
