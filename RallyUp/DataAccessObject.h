//
//  DataAccessObject.h
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <CoreLocation/CoreLocation.h>
@import Firebase;


@interface DataAccessObject : NSObject

@property BOOL isLoggingOut;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@property (nonatomic, strong) NSMutableArray *createEvent;

@property (nonatomic, strong) NSMutableArray *gameArray;

+(id)sharedManager;

-(void)sendGameToDatabase:(Event*) forEvent;
-(void)getGamesFromDatabase;
-(void)editGameFromDatabase:(Event*) eventToEdit;
-(void)deleteGameFromDatabase:(Event*) eventToDelete;


@end
