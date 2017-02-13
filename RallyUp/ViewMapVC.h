//
//  ViewMapVC.h
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "DataAccessObject.h"
#import "Event.h"
#import "DetailViewVC.h"
#import "WebViewVC.h"



@interface ViewMapVC : UIViewController <UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *annArray;
@property (strong, nonatomic) NSMutableArray *eventAnnArray;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSMutableDictionary *pinURLs;


@end
