//
//  ViewGameVC.h
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Event.h"
#import "DetailViewVC.h"
#import <FirebaseAuth/FirebaseAuth.h>

@import FirebaseAuth;

@interface ViewGameVC : UIViewController  <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *gamesTV;
@property (strong, nonatomic) DataAccessObject *dao;
@property (strong, nonatomic) Event *selectedEvent;
@property (strong, nonatomic) NSMutableArray *searchResult;


@end
