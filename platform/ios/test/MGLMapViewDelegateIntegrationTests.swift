import XCTest
import Mapbox

class MGLMapViewDelegateIntegrationTests: XCTestCase {

    func testCoverage() {
        MGLSDKTestHelpers.checkTestsContainAllMethods(testClass: MGLMapViewDelegateIntegrationTests.self, in: MGLMapViewDelegate.self)
    }

}

extension MGLMapViewDelegateIntegrationTests: MGLMapViewDelegate {

    func mapViewRegionIsChanging(_ mapView: GCLMapView) {}

    func mapView(_ mapView: GCLMapView, didChange mode: MGLUserTrackingMode, animated: Bool) {}

    func mapViewDidFinishLoadingMap(_ mapView: GCLMapView) {}

    func mapViewDidStopLocatingUser(_ mapView: GCLMapView) {}

    func mapViewWillStartLoadingMap(_ mapView: GCLMapView) {}

    func mapViewWillStartLocatingUser(_ mapView: GCLMapView) {}

    func mapViewWillStartRenderingMap(_ mapView: GCLMapView) {}

    func mapViewWillStartRenderingFrame(_ mapView: GCLMapView) {}

    func mapView(_ mapView: GCLMapView, didFinishLoading style: MGLStyle) {}

    func mapView(_ mapView: GCLMapView, didSelect annotation: MGLAnnotation) {}

    func mapView(_ mapView: GCLMapView, didDeselect annotation: MGLAnnotation) {}

    func mapView(_ mapView: GCLMapView, regionDidChangeAnimated animated: Bool) {}

    func mapView(_ mapView: GCLMapView, regionWillChangeAnimated animated: Bool) {}

    func mapViewDidFailLoadingMap(_ mapView: GCLMapView, withError error: Error) {}

    func mapView(_ mapView: GCLMapView, didUpdate userLocation: MGLUserLocation?) {}

    func mapViewDidFinishRenderingMap(_ mapView: GCLMapView, fullyRendered: Bool) {}

    func mapView(_ mapView: GCLMapView, didFailToLocateUserWithError error: Error) {}

    func mapView(_ mapView: GCLMapView, tapOnCalloutFor annotation: MGLAnnotation) {}

    func mapViewDidFinishRenderingFrame(_ mapView: GCLMapView, fullyRendered: Bool) {}

    func mapView(_ mapView: GCLMapView, didAdd annotationViews: [MGLAnnotationView]) {}

    func mapView(_ mapView: GCLMapView, didSelect annotationView: MGLAnnotationView) {}

    func mapView(_ mapView: GCLMapView, didDeselect annotationView: MGLAnnotationView) {}

    func mapView(_ mapView: GCLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat { return 0 }

    func mapView(_ mapView: GCLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? { return nil }

    func mapView(_ mapView: GCLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? { return nil }

    func mapView(_ mapView: GCLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool { return false }

    func mapView(_ mapView: GCLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? { return nil }

    func mapView(_ mapView: GCLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor { return .black }

    func mapView(_ mapView: GCLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor { return .black }

    func mapView(_ mapView: GCLMapView, leftCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? { return nil }

    func mapView(_ mapView: GCLMapView, lineWidthForPolylineAnnotation annotation: GCLPolyline) -> CGFloat { return 0 }

    func mapView(_ mapView: GCLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? { return nil }

    func mapView(_ mapView: GCLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {}

    func mapView(_ mapView: GCLMapView, shouldChangeFrom oldCamera: MGLMapCamera, to newCamera: MGLMapCamera) -> Bool { return false }

}
