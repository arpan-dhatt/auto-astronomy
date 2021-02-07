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
                    Text(selection).font(.title)
                    Spacer()
                    Button(action: {
                        if selection == "Galaxies" {
                            selection = "Nebulae"
                        } else {
                            selection = "Galaxies"
                        }
                    }) {
                        if selection == "Galaxies" {
                            Text("Nebulae")
                        } else {
                            Text("Galaxies")
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
