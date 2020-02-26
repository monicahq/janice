//
//  ContactListView.swift
//  Monica
//
//  Created by Julien Hamon on 2019-11-23.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct StickyHeader: View {

    func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
        // If scrolling up, yOffset will be a negative number
        if maxHeight + yOffset < minHeight {
            // SCROLLING UP
            // Never go smaller than our minimum height
            return minHeight
        }
        else if maxHeight + yOffset > maxHeight {
            // SCROLLING DOWN PAST MAX HEIGHT
            return maxHeight + (yOffset * 0.5) // Lessen the offset
        }

        // Return an offset that is between the min and max heights
        return maxHeight + yOffset
    }

    var body: some View {
        ScrollView {
            ZStack {
                // Bottom Layer
                VStack(spacing: 20) {
                    Tile(imageName: "Arches", tileLabel: "Arches")
                    Tile(imageName: "Arches", tileLabel: "Canyonlands")
                    Tile(imageName: "Arches", tileLabel: "Bryce Canyon")
                    Tile(imageName: "Arches", tileLabel: "Goblin Valley")
                    Tile(imageName: "Arches", tileLabel: "Zion")
                }
                .padding(.horizontal, 20)
                .padding(.top, 300)

                // Top Layer (Header)
                GeometryReader { gr in
                    VStack {
                        Image("Utah")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height:
                                           self.calculateHeight(minHeight: 120,
                                                                maxHeight: 300,
                                                                yOffset: gr.frame(in: .global).origin.y))
                            .overlay(
                                Text("UTAH")
                                    .font(.system(size: 70, weight: .black))
                                    .foregroundColor(.white)
                                    .opacity(0.8))
                            // Offset just on the Y axis
                            .offset(y: gr.frame(in: .global).origin.y < 0 // Is it going up?
                                ? abs(gr.frame(in: .global).origin.y) // Push it down!
                                : -gr.frame(in: .global).origin.y) // Push it up!
                        Spacer() // Push header to top
                    }
                }
            }
        }.edgesIgnoringSafeArea(.vertical)
    }
}

struct StickyHeader_Previews: PreviewProvider {
    static var previews: some View {
        StickyHeader()
    }
}

struct Tile: View {
    var imageName = ""
    var tileLabel = ""

    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200, alignment: .bottom)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10, x: 0, y: 5)
            .overlay(VStack {
                Spacer()
                Text(tileLabel)
                    .padding(.bottom, 20)
                    .opacity(0.85)
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
            })
    }
}

#if DEBUG
struct Tile_Previews: PreviewProvider {
    static var previews: some View {
        Tile(imageName: "turtlerock", tileLabel: "Arches")
    }
}
#endif

