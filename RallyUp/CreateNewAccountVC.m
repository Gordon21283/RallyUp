//
//  CreateNewAccountVC.m
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import "CreateNewAccountVC.h"

@interface CreateNewAccountVC ()

@end

@implementation CreateNewAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self textfieldReturnKey];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    DataAccessObject *DAO = [DataAccessObject sharedManager];
    if (DAO.isLoggingOut) {
        DAO.isLoggingOut = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)textfieldReturnKey {
    
    NSMutableArray *txtFieldArray = [@[self.txtCreateEmail, self.txtCreatePassword]mutableCopy];
    
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

-(void)login:(NSString *)email password:(NSString*)password {
    
    [[FIRAuth auth]signInWithEmail:email password:password completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"Logged In Successfully.");
            [self performSegueWithIdentifier:@"GoToMainVC" sender:self];
            
        }
        else {
            NSLog(@"ERROR : %@",error.localizedDescription);
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createBtn:(id)sender {
    
    NSString *email = self.txtCreateEmail.text;
    NSString *password = self.txtCreatePassword.text;
    
    if (email.length > 0 && password.length > 0) {
        
        [[FIRAuth auth]createUserWithEmail:email password:password completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            
            if (error == nil) {
                NSLog(@"User created.");
                NSLog(@"ERROR : %@",error.localizedDescription);
                UIAlertController *success = [UIAlertController
                                              alertControllerWithTitle:@"User Created"
                                              message:[NSString stringWithFormat:@"User for email %@ has been successfully created", email]                                     preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okLogIn = [UIAlertAction
                                          actionWithTitle:@"LOGIN"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action) {
                                              [self login:email password:password];
                                          }];
                
                [success addAction:okLogIn];
                
                [self presentViewController:success animated:YES completion:nil];
            }
            else {
                NSLog(@"ERROR : %@",error.localizedDescription);
                UIAlertController *error = [UIAlertController
                                            alertControllerWithTitle:@"oops"
                                            message:@"Your entered passwords do not match"                                     preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action) {
                                         
                                     }];
                
                [error addAction:ok];
                
                [self presentViewController:error animated:YES completion:nil];
            }
            
        }];
    }
}

- (IBAction)returnToLoginVC:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
