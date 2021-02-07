//
//  MapView.swift
//  auto-astronomy
//
//  Created by user175571 on 2/6/21.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel: ViewModel
    @State var showLoader = false
    @State var message = ""
    @State var webTitle = ""
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            VStack{
                WebView(url: .localUrl, viewModel: viewModel)
            }
            VStack{
                Spacer()
                Button(action: {
                    showAlert = true
                }) {
                    Text("Create Job")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .background(LinearGradient(gradient: .init(colors: [.blue,.purple]), startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                }
                .padding()
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Custom Coordinates"), message: Text("A custom set of coordinates have been requested. Check Jobs"), dismissButton: .default(Text("Done")))
            }
            .padding(.horizontal).contentShape(Rectangle())
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: ViewModel())
    }
}
