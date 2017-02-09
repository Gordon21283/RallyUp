//
//  LoginVC.h
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "ViewGameVC.h"


@interface LoginVC : UIViewController  <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *txtLoginEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtLoginPassword;
- (IBAction)createNewAccountBtn:(id)sender;
- (IBAction)loginBtn:(id)sender;



@end
