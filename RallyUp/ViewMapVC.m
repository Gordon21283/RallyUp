//
//  ViewMapVC.m
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import "ViewMapVC.h"

@interface ViewMapVC ()

@end

@implementation ViewMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self TapGesture];
    
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    
    self.annArray = [[NSMutableArray alloc]init];
    self.eventAnnArray = [[NSMutableArray alloc]init];
    self.mapView.delegate = self;
    self.searchBar.delegate = self;
    [self.mapView setShowsUserLocation:YES];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self addEventAnnotations];
    
}

-(void)TapGesture {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

- (void) dismissKeyboard {
    
    [self.view endEditing:YES];
}


-(void)addEventAnnotations {
    
    DataAccessObject *DAO = [DataAccessObject sharedManager];
    for (Event *currEvent in DAO.gameArray) {
        Annotation *ann = [[Annotation alloc]init];
        ann.coordinate = currEvent.gameLocationLongAndLat.coordinate;
        ann.title = currEvent.gameGroupName;
        ann.currentEvent = currEvent;
        [self.eventAnnArray addObject:ann];
    }
    [self.mapView addAnnotations:self.eventAnnArray];
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    if(annotation != self.mapView.userLocation)
    {
        static NSString *defaultPinID = @"pin";
        pinView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.canShowCallout = YES;
        pinView.image = [UIImage imageNamed:@"map-marker.png"];
        pinView.tintColor = [UIColor redColor];
        
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
    }
    else {
        [self.mapView.userLocation setTitle:@"I am here"];
    }
    return pinView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    Annotation *currentAnn = view.annotation;
    Event *tappedEvent = currentAnn.currentEvent;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailViewVC *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"detail"];
    detailVC.chosenEvent = tappedEvent;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [self.mapView setRegion:region animated:YES];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    if (!self.annArray) {
        self.annArray = [[NSMutableArray alloc]init];
    } else {
        [self.mapView removeAnnotations:self.annArray];
        [self.annArray removeAllObjects];
    }
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchBar.text;
    request.region = self.mapView.region;
    
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            for (MKMapItem *mapItem in [response mapItems]) {
                CLLocationCoordinate2D coord = [[[mapItem placemark]location] coordinate];
                Annotation *ann = [[Annotation alloc]init];
                ann.coordinate = coord;
                ann.title = [mapItem name];
                [self.annArray addObject:ann];
            }
            [self.mapView addAnnotations:self.annArray];
        } else {
            NSLog(@"Search Request Error: %@", [error localizedDescription]);
        }
        
        [searchBar resignFirstResponder];
        
    }];
}


- (IBAction)setMap:(id)sender {
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
    
}

@end
