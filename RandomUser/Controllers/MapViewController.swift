//
//  MapViewController.swift
//  RandomUser
//
//  Created by Ammar Khalil on 03/11/2021.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users : [User] = []
    var annotations : [MKAnnotation] = []
    
    var showOneUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
       mapView.delegate = self
        
        
       
        if !showOneUser{
            loadUsers()
            showUsersOnMap()
        }else {
            showSelectedUserOnMap()
        }
    
    }
    
    func loadUsers(){
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
            users = try context.fetch(request)
            
        }catch{
            print("error fetching data from DB \(error)")
        }
    }
    
    func showUsersOnMap(){
       
        for user in users{
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(user.latitude!)!, longitude: Double(user.longitude!)!)
            annotation.title = user.firstName
            annotations.append(annotation)
            mapView.addAnnotations(annotations)
        }
    }
    
    func showSelectedUserOnMap(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(users[0].latitude!)!, longitude: Double(users[0].longitude!)!)
        annotation.title = users[0].firstName
        annotations.append(annotation)
        mapView.addAnnotations(annotations)
        let coordinate = CLLocationCoordinate2D(
            latitude: Double(users[0].latitude!)! ,
            longitude: Double(users[0].longitude!)!
        )
        mapView.setRegion(MKCoordinateRegion(
            center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        ), animated: false)
    }
}



extension MapViewController : MKMapViewDelegate{

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        for user in users {

            if annotation.title == user.firstName{

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
                    let url = URL(string: user.imageMedium!)
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

                if user.firstName == view.annotation?.title{

                    vc.user = user
                }
            }
            present(vc, animated: true)
        }
    }

}
