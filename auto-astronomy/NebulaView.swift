//
//  NebulaView.swift
//  auto-astronomy
//
//  Created by Arpan Dhatt on 2/7/21.
//

import SwiftUI

struct NebulaView : View {
    
    @State var data = [
        Card(id: 0, image: "nebula/1", name: "VdB 152", title: "USA", details: "Described as dusty curtain of ghostly apparitions, this is a very faint nebula, located almost 1,400 light-years from earth. It lies on teh nothern Milky Way, near the edge of a large molecular cloud in the constellation Cepheus. It is distinct wiht its blue tint coming from a nearby star and also has a slight red tint due to the nearby nebular dust.", expand: false),
        Card(id: 1, image: "nebula/2", name: "Sh-126", title: "Sh-126", details: "Also known as Sharpless 1, this reflection nebula lies in the constellation of Scorpius, apearing in moderate brightness making it one of the easier objects to see in its region. It lies around 650 light years from earth and is irregular in shape, forming a 180 degree arc around a nearby star.", expand: false),
        Card(id: 2, image: "nebula/3", name: "M20", title: "Trifid Nebula", details: "Located in the north-west Sagittarius region about 4,500 light years from earth, it is a collection of stars, an emission nebula (dense and red-yellow in color), and a reflection nebula (blue in color). It's size and postion make it easily viewable from smaller telescopes and it has quickly become a favorite of amateur astronomers", expand: false),
        Card(id: 3, image: "nebula/4", name: "M31", title: "Germany", details: "Germany is a Western European co`duntry with a landscape of forests, rivers, mountain ranges and North Sea beaches. It has over 2 millennia of history. Berlin, its capital, is home to art and nightlife scenes, the Brandenburg Gate and many sites relating to WWII. Munich is known for its Oktoberfest and beer halls, including the 16th-century Hofbräuhaus. Frankfurt, with its skyscrapers, houses the European Central Bank.", expand: false),
        Card(id: 4, image: "nebula/5", name: "M31", title: "Dubai", details: "Dubai is a city and emirate in the United Arab Emirates known for luxury shopping, ultramodern architecture and a lively nightlife scene. Burj Khalifa, an 830m-tall tower, dominates the skyscraper-filled skyline. At its foot lies Dubai Fountain, with jets and lights choreographed to music. On artificial islands just offshore is Atlantis, The Palm, a resort with water and marine-animal parks.", expand: false),
        Card(id: 5, image: "nebula/6", name: "M31", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false),
        Card(id: 6, image: "nebula/7", name: "M31", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false),
        Card(id: 7, image: "nebula/8", name: "M31", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false),
        Card(id: 8, image: "nebula/9", name: "M31", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false)
    ]
    
    @State var hero = false
    @Binding var heroBinding: Bool
    
    var body: some View{
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    ForEach(0..<self.data.count){i in
                        GeometryReader{g in
                            CardView(data: self.$data[i], hero: self.$hero, heroBinding: self.$heroBinding)
                                .offset(y: self.data[i].expand ? -g.frame(in: .global).minY : 0)
                                .opacity(self.hero ? (self.data[i].expand ? 1 : 0) : 1)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)){if !self.data[i].expand{
                                            self.hero.toggle()
                                            self.heroBinding.toggle()
                                            self.data[i].expand.toggle()
                                        }
                                    }
                                }
                            }
                        .frame(height: self.data[i].expand ? UIScreen.main.bounds.height : 250)
                        .simultaneousGesture(DragGesture(minimumDistance: self.data[i].expand ? 0 : 500).onChanged({ (_) in
                            print("dragging")
                        }))
                    }
                }.padding(.bottom)
            }
        }
    }
}


struct NebulaView_Previews: PreviewProvider {
    static var previews: some View {
        NebulaView(heroBinding: .constant(false))
    }
}
