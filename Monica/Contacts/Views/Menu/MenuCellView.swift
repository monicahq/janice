//
//  MenuCellView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-30.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct MenuCellView: View {

    let data: String
    let cornerRadius:CGFloat
    let corners:UIRectCorner
    var body: some View {
        GeometryReader { r in
            VStack{
                Text(self.data)
                    .padding(10)
                    .foregroundColor(Color("Body"))
                    .font(.system(size: 15,
                                  weight: .regular,
                                  design: .rounded))
            }
            .frame(width: r.size.width - 30 ,height: 50)
            .background(Color.white)
            .cornerRadius(self.cornerRadius, corners: self.corners)
            .padding(.horizontal, 15)

        }
        .frame(height: 50)

    }
}

#if DEBUG
struct MenuCellView_Previews: PreviewProvider {
    static var previews: some View {
        MenuCellView(data: "test",
                     cornerRadius: 0,
                     corners: .allCorners)
    }
}
#endif

struct MenuCellData: Identifiable {
    var id:Int
    var name: String
    var action:((Any) -> Void)?
}
