//
//  LoginVC.m
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self textfieldReturnKey];
    
}

-(void)textfieldReturnKey {
    
    NSMutableArray *txtFieldArray = [@[self.txtLoginEmail, self.txtLoginPassword]mutableCopy];
    
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

- (IBAction)createNewAccountBtn:(id)sender {
    
}

- (IBAction)loginBtn:(id)sender {
    
    [[FIRAuth auth] signInWithEmail: self.txtLoginEmail.text
                           password:self.txtLoginPassword.text
                         completion:^(FIRUser *user, NSError *error) {
                             
                             if (error == nil) {
                                 [self performSegueWithIdentifier:@"LoginToMainVC" sender:self];
                             } else {
                                 NSLog(@"Invalid Username and/or Password");
                                 UIAlertController *error = [UIAlertController
                                                             alertControllerWithTitle:@"Oops!"
                                                             message:@"The email or password is incorrect"                                     preferredStyle:UIAlertControllerStyleAlert];
                                 
                                 UIAlertAction *ok = [UIAlertAction
                                                      actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          
                                                      }];
                                 
                                 [error addAction:ok];
                                 
                                 [self presentViewController:error animated:YES completion:nil];
                                 
                             }
                             NSLog(@"USER: %@", user);
                             
                         }];
    
}

@end
