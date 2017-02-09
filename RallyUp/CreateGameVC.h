//
//  CreateGameVC.h
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Event.h"
#import <CoreLocation/CoreLocation.h>


@interface CreateGameVC : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate>
{
    UIDatePicker *datePicker;
    UIDatePicker *startTimeDatePicker;
    UIDatePicker *endTimeDatePicker;
    UIPickerView *myPickerView;
    NSArray *pickerArray;
}

@property (nonatomic, strong) DataAccessObject *DAO;

@property (strong, nonatomic) IBOutlet UITextField *txtPickSport;
@property (strong, nonatomic) IBOutlet UITextField *txtCreateGroupName;
@property (strong, nonatomic) IBOutlet UITextField *txtCreateStartTime;
@property (strong, nonatomic) IBOutlet UITextField *txtCreateEndTime;
@property (strong, nonatomic) IBOutlet UITextField *txtCreateStreet;
@property (strong, nonatomic) IBOutlet UITextField *txtCreateCity;
@property (strong, nonatomic) IBOutlet UITextField *txtCreateState;
@property (strong, nonatomic) IBOutlet UITextField *txtCreateZipCode;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property CLLocation *eventLocation;

- (IBAction)doneBtn:(id)sender;



@end
