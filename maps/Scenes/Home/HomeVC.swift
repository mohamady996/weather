//
//  HomeVC.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import UIKit
import MapKit

class HomeVC: BaseViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapKit: MKMapView!
    
    var viewModel: HomeVM!
    let popupView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 210))
    let stack = UIStackView(frame: CGRect(x: 0, y: 0, width: 190, height: 200))
    let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 180, height: 25))
    let addressLabel = UILabel(frame: CGRect(x: 10, y: 40, width: 180, height: 100))
    let categoryLabel = UILabel(frame: CGRect(x: 10, y: 150, width: 180, height: 50))


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = HomeVM()
        setupSideMenu()
        setupSegmentedControl()
        setupTableView()
        setupMapView()
        
        self.tableView.isHidden = false
        self.mapKit.isHidden = true
    }
    
    private
    func setupTableView(){
        self.tableView.register(mapCell.nib(), forCellReuseIdentifier: mapCell.identifier)
        
        viewModel.mapPointers.bind(to: tableView.rx.items(cellIdentifier: "mapCell", cellType: mapCell.self)) { (row,item,cell) in
            cell.nameLabel?.text = item.name
            cell.addreddLabel?.text = item.address
            cell.categoriesLabel?.text = item.categories
        }.disposed(by: disposeBag)
    }
    
    private
    func setupSegmentedControl() {
        segmentControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .subscribe{ [self] _ in
                switch self.segmentControl.selectedSegmentIndex {
                case 0:
                    self.tableView.isHidden = false
                    self.mapKit.isHidden = true
                case 1:
                    self.tableView.isHidden = true
                    self.mapKit.isHidden = false
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
    
    private
    func setupMapView(){
        mapKit.delegate = self

        
        self.viewModel.mapPointers.subscribe(onNext: { value in
            for location in value {
//                let annotation = MKPointAnnotation()
                let annotation = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.lat ?? 0.0, longitude: location.lng ?? 0.0))
                annotation.title = location.name
                annotation.address = location.address ?? ""
                annotation.category = location.categories ?? ""
                
                self.mapKit.addAnnotation(annotation)
                
            }
        }).disposed(by: disposeBag)
        
    }
    
    private
    func showCustomPopup(for annotation: CustomAnnotation, at annotationView: MKAnnotationView) {
        popupView.center = CGPoint(x: annotationView.frame.midX, y: annotationView.frame.minY - 110)
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 8
        popupView.layer.shadowColor = UIColor.black.cgColor
        popupView.layer.shadowOpacity = 0.2
        popupView.layer.shadowOffset = CGSize(width: 0, height: 2)
        popupView.layer.shadowRadius = 4
        
        // Title label
        titleLabel.text = annotation.title ?? "No Title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        
        // Address label
        addressLabel.text = annotation.address
        addressLabel.font = UIFont.systemFont(ofSize: 14)
        addressLabel.textColor = .black
        addressLabel.numberOfLines = 0
        addressLabel.textAlignment = .center
        
        // Category label
        categoryLabel.text = annotation.category
        categoryLabel.font = UIFont.systemFont(ofSize: 14)
        categoryLabel.textColor = .black
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .center
        
        //Stack View
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        //add labels to stack
        stack.addSubview(titleLabel)
        stack.addSubview(addressLabel)
        stack.addSubview(categoryLabel)
        
        //add stack to popup view
        popupView.addSubview(stack)
        
        // Add popup view as a subview to the map view
        mapKit.addSubview(popupView)
        
        // Hide popup when deselecting
        mapKit.deselectAnnotation(annotation, animated: true)
    }
}

extension HomeVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? CustomAnnotation else { return }
        
        // Show custom popup
        showCustomPopup(for: annotation, at: view)
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.popupView.removeFromSuperview()
    }
}

