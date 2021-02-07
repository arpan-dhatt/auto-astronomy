//
//  JobView.swift
//  auto-astronomy
//
//  Created by Arpan Dhatt on 2/7/21.
//

import SwiftUI

struct JobView: View {
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            VStack {
                HStack {
                    Text("Jobs").font(.title)
                    Spacer()
                }.padding(.leading)
                JobCardView(object: "M31", image: UIImage(named: "galaxies/processing")!, updates: ["Cooling Telescope"], timeRemaining: 1600, status: "Running", location: "Southlake, TX", weather: "Clear")
                JobCardView(object: "LD-1251", image: UIImage(named: "nebula/6")!, updates: ["Cooling Telescope", "Aligning Telescope", "Calibrating Focus", "Beginning Exposure", "Ending Exposure", "Completed Processing"], timeRemaining: 0, status: "Completed", location: "Southlake, TX", weather: "Clear")
                JobCardView(object: "NGC 981", image: UIImage(named: "galaxies/4")!, updates: ["Cooling Telescope", "Aligning Telescope", "Calibrating Focus", "Beginning Exposure", "Ending Exposure", "Completed Processing"], timeRemaining: 0, status: "Completed", location: "Southlake, TX", weather: "Clear")
            }
        }
    }
}

struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView()
    }
}
