//
//  ContentView.swift
//  Monica
//
//  Created by julien hamon on 2019-11-20.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var viewModel: DashboardViewModel
    @State var showContent = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Contacts")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Text(viewModel.contacts.count.description)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.leading, 60.0)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30.0) {
                        ForEach(viewModel.contacts) { item in
                            Button(action: { self.showContent.toggle() }) {
                                GeometryReader { geometry in
                                    ContactView(title: item.firstName,
                                                subtitle: item.lastName)
                                        .rotation3DEffect(Angle(degrees:
                                            Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                        .sheet(isPresented: self.$showContent) { ContactView(title: "",
                                                  image: ""
                                        ) }
                                }
                                .frame(width: 246, height: 360)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.top, 30)
                    .padding(.bottom, 70)
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Reminders")
                            .font(.largeTitle)
                            .fontWeight(.heavy)

                        Text(viewModel.reminders.count.description)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }.padding(.leading, 60.0)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30.0) {
                        ForEach(viewModel.reminders) { item in
                            Button(action: { self.showContent.toggle() }) {
                                GeometryReader { geometry in
                                    ContactView(title: item.title,
                                                subtitle: item.frequencyType)
                                        .rotation3DEffect(Angle(degrees:
                                            Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                        .sheet(isPresented: self.$showContent) { ContactView(title: "",
                                                  image: ""
                                        ) }
                                }
                                .frame(width: 246, height: 360)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.top, 30)
                    .padding(.bottom, 70)
                    Spacer()
                }

                HStack {
                    VStack(alignment: .leading) {
                        Text("Activities")
                            .font(.largeTitle)
                            .fontWeight(.heavy)

                        Text(viewModel.activities.count.description)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }.padding(.leading, 60.0)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30.0) {
                        ForEach(viewModel.activities) { item in
                            Button(action: { self.showContent.toggle() }) {
                                GeometryReader { geometry in
                                    ContactView(title: item.summary,
                                                subtitle: item.description ?? "")
                                        .rotation3DEffect(Angle(degrees:
                                            Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                        .sheet(isPresented: self.$showContent) { ContactView(title: "",
                                                  image: ""
                                        ) }
                                }
                                .frame(width: 246, height: 360)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.top, 30)
                    .padding(.bottom, 70)
                    Spacer()
                }

            }
            .padding(.top, 78)
        }.onAppear {
            self.viewModel.apply(.onAppear)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: .init())
    }
}
#endif



struct ContactView: View {
    
    var title = "Build an app with SwiftUI"
    var subtitle = "Build an app with SwiftUI"
    var image = "Illustration1"
    var color = Color("background3")
    var shadowColor = Color("backgroundShadow3")
    
    var body: some View {
        return VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 30)
                .padding(.horizontal, 30)
                .padding(.bottom, 0)
                .lineLimit(2)
            

            Text(subtitle)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 0)
                .padding(.horizontal, 30)
                .padding(.bottom, 0)
                .lineLimit(1)

            Spacer()

            Image(image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 246, height: 150)
                .padding(.bottom, 30)
        }
        .background(color)
        .cornerRadius(30)
        .frame(width: 246, height: 360)
        .shadow(color: shadowColor, radius: 20, x: 0, y: 20)
    }
}
