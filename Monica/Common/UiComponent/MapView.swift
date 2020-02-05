//
//  MapView.swift
//  Monica
//
//  Created by julien hamon on 2019-12-01.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView

    @State var latitude: Double
    @State var longitude: Double

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
               annotation.coordinate = coordinate
               annotation.title = "Home"
               uiView.addAnnotation(annotation)
    }
}
#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(latitude:0, longitude: 0)
    }
}
#endif
