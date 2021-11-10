//
//  MapViewController.swift
//  RandomUser
//
//  Created by Ammar Khalil on 03/11/2021.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var userManager = UserManager()
    var users : [User] = []
    var annotations : [MKAnnotation] = []
    
    var showOneUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        mapView.delegate = self
        userManager.delegate = self
        
        
        
        if !showOneUser{
            userManager.fetchUserData()
        }else {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(users[0].location.coordinates.latitude)!, longitude: Double(users[0].location.coordinates.longitude)!)
            annotation.title = users[0].name.first
            annotations.append(annotation)
            mapView.addAnnotations(annotations)
            let coordinate = CLLocationCoordinate2D(
                latitude: Double(users[0].location.coordinates.latitude)! ,
                longitude: Double(users[0].location.coordinates.longitude)!
            )
            mapView.setRegion(MKCoordinateRegion(
                center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            ), animated: false)
        }
    
    }
    
}


extension MapViewController : UserManagerDelegate {
    func didUpdateUser(_ userManager: UserManager, user: [User]) {
        
        users = user
        
        for user in users {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(user.location.coordinates.latitude)!, longitude: Double(user.location.coordinates.longitude)!)
            annotation.title = user.name.first
            annotations.append(annotation)
            mapView.addAnnotations(annotations)
        }
     
    }
    
    func didFailWithError(error: Error) {
        
        print(error)
    }
    
    
    
}


extension MapViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        for user in users {
            
            if annotation.title == user.name.first{
                
                    annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
                
                    annotationView?.annotation = annotation
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
                
                    DispatchQueue.main.async {
                        mapView.selectAnnotation(annotation, animated: false)
                    }
                    
                let label = UILabel(frame : CGRect(x: 0, y: 70, width: 75, height: 30))
                label.backgroundColor = .black
                label.textColor = .white
                label.text = annotation.title as? String
                
                annotationView?.addSubview(label)
               
                
                DispatchQueue.main.async {
                    let url = URL(string: user.picture.medium)
                       if let data = try? Data(contentsOf: url!)
                       {
                       let userImage = UIImage(data: data)
                        
                        annotationView?.image = userImage
        
                       }
                }
            }
            
            
            
            
        }
        
        
        return annotationView
        
    }
    

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "UserProfile") as? UserProfileViewController{
            
            for user in users {
                
                if user.name.first == view.annotation?.title{
                    
                    vc.user = user
                }
            }
            present(vc, animated: true)
        }
    }

}
