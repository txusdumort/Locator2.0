//
//  DetailViewController.swift
//  Locator2.0
//
//  Created by Txus duMort on 14/12/14.
//  Copyright (c) 2014 Txus duMort. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var MapView: MKMapView!
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            
            
            
            
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var latitude: CLLocationDegrees = 48.399193
        var longitude: CLLocationDegrees = 9.993341
        
        var latDelta: CLLocationDegrees = 0.01
        var longDelta: CLLocationDegrees = 0.01
        
        var theSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var bagLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var theRegion: MKCoordinateRegion = MKCoordinateRegionMake(bagLocation, theSpan)
        
        println(theRegion)
        self.MapView.setRegion(theRegion, animated: true)
        var ann = MKPointAnnotation()
        ann.coordinate = bagLocation
        ann.title = "algo"
        ann.subtitle = "mas"
        
        self.MapView.addAnnotation(ann)

        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

