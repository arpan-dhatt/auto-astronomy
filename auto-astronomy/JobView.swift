//
//  JobView.swift
//  auto-astronomy
//
//  Created by Arpan Dhatt on 2/7/21.
//

import SwiftUI

struct JobView: View {
    var body: some View {
        ScrollView {
            VStack {
                JobCardView(object: "M31", image: UIImage(named: "galaxies/1")!, updates: ["Cooling Telescope", "Aligning Telescope", "Calibrating Focus", "Beginning Exposure"], timeRemaining: 1600, status: "Running", location: "Southlake, TX", weather: "Clear")
                JobCardView(object: "M31", image: UIImage(named: "galaxies/1")!, updates: ["Cooling Telescope", "Aligning Telescope", "Calibrating Focus", "Beginning Exposure"], timeRemaining: 1600, status: "Running", location: "Southlake, TX", weather: "Clear")
                JobCardView(object: "M31", image: UIImage(named: "galaxies/1")!, updates: ["Cooling Telescope", "Aligning Telescope", "Calibrating Focus", "Beginning Exposure"], timeRemaining: 1600, status: "Running", location: "Southlake, TX", weather: "Clear")
                JobCardView(object: "M31", image: UIImage(named: "galaxies/1")!, updates: ["Cooling Telescope", "Aligning Telescope", "Calibrating Focus", "Beginning Exposure"], timeRemaining: 1600, status: "Running", location: "Southlake, TX", weather: "Clear")
            }
        }
    }
}

struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView()
    }
}
