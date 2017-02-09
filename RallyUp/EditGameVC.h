//
//  EditGameVC.h
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Event.h"
#import "DetailViewVC.h"
#import <CoreLocation/CoreLocation.h>


@interface EditGameVC : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate>
{
    UIDatePicker *editStartTimePicker;
    UIDatePicker *editEndTimePicker;
    UIDatePicker *editDatePicker;
    UIPickerView *editPickerView;
    NSArray *editPickerArray;
}

@property (strong, nonatomic) Event *eventToEdit;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;

@property CLLocation *eventLocation;
@property (strong, nonatomic) IBOutlet UITextField *txtEditPickSport;
@property (strong, nonatomic) IBOutlet UITextField *txtEditGroupName;
@property (strong, nonatomic) IBOutlet UITextField *txtEditStartTime;
@property (strong, nonatomic) IBOutlet UITextField *txtEditEndTime;
@property (strong, nonatomic) IBOutlet UITextField *txtEditStreet;
@property (strong, nonatomic) IBOutlet UITextField *txtEditCity;
@property (strong, nonatomic) IBOutlet UITextField *txtEditState;
@property (strong, nonatomic) IBOutlet UITextField *txtEditZipCode;

- (IBAction)doneEditBtn:(id)sender;

@end
