//
//  DetailViewVC.h
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "EditGameVC.h"
#import <MessageUI/MessageUI.h>


@interface DetailViewVC : UIViewController  <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) Event *chosenEvent;


@property (strong, nonatomic) IBOutlet UILabel *lblSport;
@property (strong, nonatomic) IBOutlet UILabel *lblGroupName;
@property (strong, nonatomic) IBOutlet UILabel *lblStartTime;
@property (strong, nonatomic) IBOutlet UILabel *lblEndTime;
@property (strong, nonatomic) IBOutlet UILabel *lblStreet;
@property (strong, nonatomic) IBOutlet UILabel *lblCity;
@property (strong, nonatomic) IBOutlet UILabel *lblState;
@property (strong, nonatomic) IBOutlet UILabel *lblZipCode;

- (IBAction)editBtn:(id)sender;
- (IBAction)sendEmailBtn:(id)sender;


@end
