//
//  AddViewController.swift
//  Project_EPN
//
//  Created by Aidan Smith on 2016-09-26.
//  Copyright © 2016 ShamothSoft. All rights reserved.
//

import UIKit
import MapKit

class AddViewController: UIViewController, UISearchBarDelegate, MKLocalSearchCompleterDelegate, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {

    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    var radius = 50.0
    
    var searchResultsView: UITableView?
    let searchCompleter = MKLocalSearchCompleter ()
    var circleOverlay: MKCircle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.searchCompleter.delegate = self
        self.mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.searchResultsView = UITableView (frame: mapView.frame )
        self.searchResultsView?.dataSource = self
        self.searchResultsView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAddFence(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        self.searchResultsView?.removeFromSuperview()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: clear placemark
        if (searchText.characters.count == 0)
        {
            self.searchResultsView?.removeFromSuperview()
        }
        else
        {
            searchCompleter.queryFragment = searchBar.text!
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchResultsView?.removeFromSuperview()
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: - MKLocalSearchCompletionDelegate
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        if (nil == self.searchResultsView?.superview)
        {
            self.view.addSubview(self.searchResultsView!)
        }

        self.searchResultsView?.reloadData ()
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchCompleter.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var viewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if nil == viewCell {
            viewCell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        let searchCompletion = self.searchCompleter.results [indexPath.last!]
        let cellTextView = UILabel(frame: (viewCell?.contentView.frame)!)
        cellTextView.text = searchCompletion.title + " " + searchCompletion.subtitle
        for subview: UIView in (viewCell?.contentView.subviews)! {
            subview.removeFromSuperview()
        }
        viewCell?.contentView.addSubview( cellTextView )
        return viewCell!
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchResultsView?.removeFromSuperview()
        self.searchView.resignFirstResponder()
        self.searchView.text = nil
        let searchRequest = MKLocalSearchRequest (completion: self.searchCompleter.results[indexPath.last!])
        let localSearch = MKLocalSearch (request: searchRequest)
        localSearch.start { (response, error) in
            
            guard let response = response else {
                return
            }
            
            guard let mapItem = response.mapItems.last else {
                return
            }
            
            let center = mapItem.placemark.coordinate
            let span = MKCoordinateSpan (latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion (center: center, span: span)
            self.mapView.setRegion (region, animated: true)
            self.mapView.showAnnotations ([(mapItem.placemark)], animated: true)
            
            self.circleOverlay = MKCircle (center: center, radius: CLLocationDistance(self.radius))
            self.mapView.add(self.circleOverlay!)
        }
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let aCircleRenderer = MKCircleRenderer(overlay: overlay)
        aCircleRenderer.fillColor = UIColor.cyan.withAlphaComponent (0.2)
        aCircleRenderer.strokeColor = UIColor.cyan.withAlphaComponent (0.7)
        aCircleRenderer.lineWidth = 2;
        
        return aCircleRenderer
    }
    
    @IBAction func radiusChanged(_ sender: AnyObject) {
        guard let center = self.circleOverlay?.coordinate else {
            return
        }

        let slider = sender as! UISlider
        self.radius = Double (slider.value)
        
        self.mapView.remove (self.circleOverlay!)
        self.circleOverlay = MKCircle (center: center, radius: CLLocationDistance(radius))
        self.mapView.add (self.circleOverlay!)
    }
    
    @IBOutlet weak var gracePeriod: UITextField!

}
