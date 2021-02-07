//
//  GallaryView.swift
//  auto-astronomy
//
//  Created by user175571 on 2/6/21.
//

import SwiftUI

struct GallaryView: View {
    @ObservedObject var model: ViewModel
    var body: some View {
        GalaxyView()
    }
}

struct GallaryView_Previews: PreviewProvider {
    static var previews: some View {
        GallaryView(model: ViewModel())
    }
}
