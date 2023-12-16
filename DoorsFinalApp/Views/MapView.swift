//
//  MapView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var buildings: [Building]
    @Binding var selectedBuilding: Building?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        configureInitialRegion(on: mapView)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateAnnotations(on: uiView)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(selectedBuilding: $selectedBuilding)
    }

    private func configureInitialRegion(on mapView: MKMapView) {
        let ottawaCoordinates = CLLocationCoordinate2D(latitude: 45.4215, longitude: -75.6972)
        let region = MKCoordinateRegion(center: ottawaCoordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
    }

    private func updateAnnotations(on mapView: MKMapView) {
        let newAnnotations = buildings.map(BuildingAnnotation.init)
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(newAnnotations)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var selectedBuildingBinding: Binding<Building?>

        init(selectedBuilding: Binding<Building?>) {
            self.selectedBuildingBinding = selectedBuilding
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let buildingAnnotation = annotation as? BuildingAnnotation else { return nil }
            let identifier = "BuildingAnnotation"
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true

            if let image = UIImage(named: buildingAnnotation.iconName) {
                let size = CGSize(width: 30, height: 30)
                UIGraphicsBeginImageContext(size)
                image.draw(in: CGRect(origin: .zero, size: size))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                view.image = resizedImage
            }
            
            let infoButton = UIButton(type: .infoLight)
            view.rightCalloutAccessoryView = infoButton
            
            return view
        }

        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if let buildingAnnotation = view.annotation as? BuildingAnnotation {
                selectedBuildingBinding.wrappedValue = buildingAnnotation.building
            }
        }
    }
}
