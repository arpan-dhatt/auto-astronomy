//
//  GallaryView.swift
//  auto-astronomy
//
//  Created by user175571 on 2/6/21.
//

import SwiftUI

struct GallaryView: View {
    @ObservedObject var model: ViewModel
    
    @State var selection = "Galaxies"
    @State var hideTitle = false
    
    var body: some View {
        VStack {
            if !hideTitle {
                HStack {
                    Text("Galaxies").font(selection == "Galaxies" ? .title : .body).foregroundColor(selection == "Galaxies" ? .primary : .blue).onTapGesture {
                        withAnimation {
                            selection = "Galaxies"
                        }
                    }
                    Spacer()
                    Text("Nebulae").font(selection == "Nebulae" ? .title : .body).foregroundColor(selection == "Nebulae" ? .primary : .blue).onTapGesture {
                        withAnimation {
                            selection = "Nebulae"
                        }
                    }
                }.padding()
            }
            if selection == "Galaxies" {
                GalaxyView(heroBinding: $hideTitle)
            } else {
                NebulaView(heroBinding: $hideTitle)
            }
        }
        
    }
}

struct GallaryView_Previews: PreviewProvider {
    static var previews: some View {
        GallaryView(model: ViewModel())
    }
}
