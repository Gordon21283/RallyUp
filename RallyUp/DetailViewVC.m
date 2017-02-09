//
//  DetailViewVC.m
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import "DetailViewVC.h"


@interface DetailViewVC ()

@end

@implementation DetailViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self populateDetails];
    NSLog(@"UUID = %@", self.chosenEvent.uID);
}

-(void)populateDetails
{
    self.lblGroupName.text = self.chosenEvent.gameGroupName;
    self.lblStartTime.text = self.chosenEvent.gameStartTime;
    self.lblEndTime.text = self.chosenEvent.gameEndTime;
    self.lblSport.text = self.chosenEvent.pickSport;
    self.lblStreet.text = self.chosenEvent.street;
    self.lblCity.text = self.chosenEvent.city;
    self.lblState.text = self.chosenEvent.state;
    self.lblZipCode.text = self.chosenEvent.zipCode;
    
}


- (IBAction)editBtn:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    EditGameVC *editViewVC = [storyboard instantiateViewControllerWithIdentifier:@"editVC"];
    
    editViewVC.eventToEdit = self.chosenEvent;
    [self.navigationController pushViewController: editViewVC animated:YES];
    
}

- (IBAction)sendEmailBtn:(id)sender {
    
    NSString *emailTitle = @"";
    NSString *messageBody = [NSString stringWithFormat:@"Hey Come Play: %@ \n Start Time: %@ \n End Time: %@ \n Address: %@ %@ %@ %@", self.chosenEvent.pickSport, self.chosenEvent.gameStartTime, self.chosenEvent.gameEndTime, self.chosenEvent.street, self.chosenEvent.city, self.chosenEvent.state, self.chosenEvent.zipCode];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
