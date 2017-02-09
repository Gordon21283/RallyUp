//
//  EditGameVC.m
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import "EditGameVC.h"

@interface EditGameVC ()

@end

@implementation EditGameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self editStartDateAndTimePicker];
    [self editEndDateAndTimePicker];
    [self editPickSport];
    [self populateFromDetailView];
    [self textFieldReturnKey];
    
}

#pragma mark - Method for Textfield Return Key

-(void)textFieldReturnKey {
    
    NSMutableArray *txtFieldArray = [@[self.txtEditGroupName, self.txtEditStartTime, self.txtEditEndTime, self.txtEditPickSport, self.txtEditStreet, self.txtEditCity, self.txtEditState, self.txtEditZipCode]mutableCopy];
    
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


-(void)populateFromDetailView {
    
    self.txtEditGroupName.text = self.eventToEdit.gameGroupName;
    self.txtEditStartTime.text = self.eventToEdit.gameStartTime;
    self.txtEditEndTime.text = self.eventToEdit.gameEndTime;
    self.txtEditPickSport.text = self.eventToEdit.pickSport;
    self.txtEditStreet.text = self.eventToEdit.street;
    self.txtEditCity.text = self.eventToEdit.city;
    self.txtEditState.text = self.eventToEdit.state;
    self.txtEditZipCode.text = self.eventToEdit.zipCode;
    
    
}

#pragma mark - Picker for Edit StartDate & Time

-(void)editStartDateAndTimePicker {
    
    editStartTimePicker  = [[UIDatePicker alloc]init];
    editStartTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    [self.txtEditStartTime setInputView:editStartTimePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(editStartDateAndTime)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    
    [self.txtEditStartTime setInputAccessoryView:toolBar];
    
    
}

-(void)editStartDateAndTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM/dd/YYYY HH:mm"];
    
    self.txtEditStartTime.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:editStartTimePicker.date]];
    
    [self.txtEditStartTime resignFirstResponder];
    
}

#pragma mark - Picker for Edit EndDate & Time


-(void)editEndDateAndTimePicker {
    
    editEndTimePicker  = [[UIDatePicker alloc]init];
    editEndTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    [self.txtEditEndTime setInputView:editEndTimePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(editEndDateAndTime)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    
    [self.txtEditEndTime setInputAccessoryView:toolBar];
    
}

-(void)editEndDateAndTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM/dd/YYYY HH:mm"];
    
    self.txtEditEndTime.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:editEndTimePicker.date]];
    
    [self.txtEditEndTime resignFirstResponder];
    
}

#pragma mark - Picker for Edit Sport

-(void)editPickSport {
    
    editPickerArray = [[NSArray alloc]initWithObjects:@"None",@"Badminton", @"Basketball",@"Football",@"Hockey",@"Softball",@"Tennis", nil];
    
    editPickerView = [[UIPickerView alloc]init];
    editPickerView.dataSource = self;
    editPickerView.delegate = self;
    editPickerView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(pickerDoneClicked:)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     editDatePicker.frame.size.height-50, 320, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    self.txtEditPickSport.inputView = editPickerView;
    self.txtEditPickSport.inputAccessoryView = toolBar;
    
}

-(void)pickerDoneClicked:(id)sender {
    
    [self.txtEditPickSport resignFirstResponder];
    
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    return [editPickerArray count];
    
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component {
    
    [self.txtEditPickSport setText:[editPickerArray objectAtIndex:row]];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component {
    
    return [editPickerArray objectAtIndex:row];
    
}

- (IBAction)doneEditBtn:(id)sender {
    
    [self populateEditEvent];
    
}

-(void)editEvent {
    
    self.eventToEdit.gameGroupName = self.txtEditGroupName.text;
    self.eventToEdit.gameStartTime = self.txtEditStartTime.text;
    self.eventToEdit.gameEndTime = self.txtEditEndTime.text;
    self.eventToEdit.pickSport = self.txtEditPickSport.text;
    self.eventToEdit.street = self.txtEditStreet.text;
    self.eventToEdit.city = self.txtEditCity.text;
    self.eventToEdit.state = self.txtEditState.text;
    self.eventToEdit.zipCode = self.txtEditZipCode.text;
    self.eventToEdit.gameLocationLongAndLat = self.eventLocation;
    
    DataAccessObject *dataManager = [DataAccessObject sharedManager];
    [dataManager editGameFromDatabase:self.eventToEdit];
    
}

-(void)populateEditEvent {
    
    if ([self.txtEditGroupName.text isEqualToString:@""] || [self.txtEditStreet.text isEqualToString:@""] || [self.txtEditState.text isEqualToString:@""] || [self.txtEditCity.text isEqualToString:@""] || [self.txtEditZipCode.text isEqualToString:@""])  {
        
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
    }
    else if(self.geocoder == nil)
    {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@", self.txtEditStreet.text, self.txtEditCity.text, self.txtEditState.text, self.txtEditZipCode.text];
    
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
        
        [self editEvent];
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
