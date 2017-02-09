//
//  CreateNewAccountVC.h
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginVC.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import "DataAccessObject.h"


@interface CreateNewAccountVC : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *txtCreateEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtCreatePassword;
- (IBAction)createBtn:(id)sender;
- (IBAction)returnToLoginVC:(id)sender;


@end
