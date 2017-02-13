//
//  CreateGameVC.m
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import "CreateGameVC.h"

@interface CreateGameVC ()

@end

@implementation CreateGameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startDateAndTimePicker];
    [self endDateAndTimePicker];
    [self pickSport];
    [self textfieldReturnKey];
    
}

#pragma mark - Method for Textfield Return Key

-(void)textfieldReturnKey {
    
    NSMutableArray *txtFieldArray = [@[self.txtCreateGroupName, self.txtCreateStartTime, self.txtCreateEndTime, self.txtPickSport, self.txtCreateStreet, self.txtCreateStreet, self.txtCreateState, self.txtCreateCity, self.txtCreateZipCode]mutableCopy];
    
    for(UITextField *textfield in txtFieldArray){
        textfield.delegate = self;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    
}

#pragma mark - Picker for StartDate & StartTime


-(void)startDateAndTimePicker {
    
    startTimeDatePicker = [[UIDatePicker alloc]init];
    startTimeDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    [self.txtCreateStartTime setInputView:startTimeDatePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(changeStartDateAndTime)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    
    [self.txtCreateStartTime setInputAccessoryView:toolBar];
    
}

-(void)changeStartDateAndTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM/dd/YYYY HH:mm"];
    
    self.txtCreateStartTime.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:startTimeDatePicker.date]];
    
    [self.txtCreateStartTime resignFirstResponder];
    
}

#pragma mark - Picker for EndDate & EndTime


-(void)endDateAndTimePicker {
    
    endTimeDatePicker = [[UIDatePicker alloc]init];
    endTimeDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    [self.txtCreateEndTime setInputView:endTimeDatePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(changeEndDatAndTime)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    
    [self.txtCreateEndTime setInputAccessoryView:toolBar];
    
}

-(void)changeEndDatAndTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM/dd/YYYY HH:mm"];
    
    self.txtCreateEndTime.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:endTimeDatePicker.date]];
    
    [self.txtCreateEndTime resignFirstResponder];
    
}


#pragma mark - Picker for Pick Sport

-(void)pickSport {
    
    pickerArray = [[NSArray alloc]initWithObjects:@"None",@"Badminton",
                   @"Basketball",@"Football",@"Hockey",@"Softball",@"Tennis", nil];
    
    myPickerView = [[UIPickerView alloc]init];
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(pickerDoneClicked:)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     datePicker.frame.size.height-50, 320, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    self.txtPickSport.inputView = myPickerView;
    self.txtPickSport.inputAccessoryView = toolBar;
    
}

-(void)pickerDoneClicked:(id)sender {
    
    [self.txtPickSport resignFirstResponder];
    
}

#pragma mark - Picker View Data source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    return [pickerArray count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component {
    
    [self.txtPickSport setText:[pickerArray objectAtIndex:row]];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
    return [pickerArray objectAtIndex:row];
    
}

-(IBAction)doneBtn:(id)sender {
    
    [self populateCreateEvent];
    
}

-(void)createNewEvent {
    
    self.DAO = [DataAccessObject sharedManager];
    NSString *uuid = [[NSUUID UUID] UUIDString];
    
    
    Event *newEvent = [[Event alloc]initWithGameGroupName:self.txtCreateGroupName.text andGameStartTime:self.txtCreateStartTime.text andGameEndTime:self.txtCreateEndTime.text andPickSport:self.txtPickSport.text andStreet:self.txtCreateStreet.text andCity:self.txtCreateCity.text andState:self.txtCreateState.text andZipCode:self.txtCreateZipCode.text andGameLocationLongAndLat:self.eventLocation andUniqueID:uuid];
    
    [self.DAO.gameArray addObject:newEvent];
    
    [self.DAO sendGameToDatabase:newEvent];
    
    
    
}

-(void)populateCreateEvent {
    
    if ([self.txtCreateGroupName.text isEqualToString:@""] || [self.txtCreateStreet.text isEqualToString:@""] || [self.txtCreateCity.text isEqualToString:@""] ||[self.txtCreateState.text isEqualToString:@""] || [self.txtCreateZipCode.text isEqualToString:@""])  {
        
        UIAlertController * error = [UIAlertController
                                     alertControllerWithTitle:@"oops"
                                     message:@"You must complete all fields"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 
                             }];
        
        [error addAction:ok];
        
        [self presentViewController:error animated:YES completion:nil];
    }else if(self.geocoder == nil)
        
    {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@", self.txtCreateStreet.text, self.txtCreateCity.text, self.txtCreateState.text, self.txtCreateZipCode.text];
    
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(placemarks.count > 0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            NSLog(@"Longitude:%.8f", coordinate.longitude);
            NSLog(@"Latitude:%.8f", coordinate.latitude);
            
            self.eventLocation = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
            
        }
        [self createNewEvent];
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
