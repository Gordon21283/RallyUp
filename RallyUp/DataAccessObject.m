//
//  DataAccessObject.m
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import "DataAccessObject.h"
#import "Event.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <CoreLocation/CoreLocation.h>


static DataAccessObject *sharedMyManager = nil;

#pragma mark - Singleton Method

@implementation DataAccessObject
- (id)init {
    if (self = [super init]) {
        
        self.ref = [[FIRDatabase database] reference];
    }
    return self;
}

+ (id)sharedManager {
    //ensures object is created only once
    @synchronized (self) {
        
        if(sharedMyManager == nil){
            sharedMyManager = [[super allocWithZone:NULL] init];
            
        }
    }
    return sharedMyManager;
}

-(id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - Send Data to Firebase

-(void)sendGameToDatabase:(Event*) forEvent {
    
    NSNumber *latitude = [NSNumber numberWithDouble:forEvent.gameLocationLongAndLat.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithDouble:forEvent.gameLocationLongAndLat.coordinate.longitude];
    
    NSDictionary *eventToSend = @{ @"event" : forEvent.gameGroupName,
                                   @"startTime" : forEvent.gameStartTime,
                                   @"endTime" : forEvent.gameEndTime,
                                   @"sport" : forEvent.pickSport,
                                   @"street": forEvent.street,
                                   @"city": forEvent.city,
                                   @"state": forEvent.state,
                                   @"zipCode": forEvent.zipCode,
                                   @"longitude": longitude,
                                   @"latitude": latitude                        };
    
    [[[[[_ref child:@"users"] child:[FIRAuth auth].currentUser.uid]child:@"games"] child:forEvent.uID]
     setValue:eventToSend];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadGames" object:nil];
    });

    //first see if these breakpoints are getting hit (this one and the one in viewgames VC)
    
}

#pragma mark - Retreive Data to Firebase

-(void)getGamesFromDatabase {
    
    NSLog(@"CURRENT USER YOU ARE LOADING GMAES FOR: %@", [FIRAuth auth].currentUser.email);
    NSString *currentUser = [FIRAuth auth].currentUser.uid;
    [[[[_ref child:@"users"]child:currentUser]child:@"games"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        
        NSDictionary *databaseGames = snapshot.value;
        
        if ([databaseGames respondsToSelector:@selector(allValues)]) {
            NSArray *databaseGamesArray = [databaseGames allValues];
            
            NSLog(@"THIS IS THE SNAPSHOT GORDON %@", databaseGames.allKeys[0]);
            NSMutableArray *databaseEvents = [[NSMutableArray alloc]init];
            
            int i = 0;
            for (NSDictionary *gameDict in databaseGamesArray) {
                NSLog(@"GAMEDICT = %@", gameDict);
                ///get value for long/lat keys and then make CLLocation Object and then plug that object into initializer
                NSNumber *latitude = [gameDict valueForKey:@"latitude"];
                NSNumber *longitude = [gameDict valueForKey:@"longitude"];
                CLLocation *gameLoc = [[CLLocation alloc]initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
                
                Event *thisEvent = [[Event alloc]initWithGameGroupName:
                                    [gameDict valueForKey:@"event"] andGameStartTime:[gameDict valueForKey:@"startTime"] andGameEndTime:[gameDict valueForKey:@"endTime"] andPickSport:[gameDict valueForKey:@"sport"]andStreet:[gameDict valueForKey:@"street"] andCity:[gameDict valueForKey:@"city"] andState:[gameDict valueForKey:@"state"] andZipCode:[gameDict valueForKey:@"zipCode"] andGameLocationLongAndLat:gameLoc
                                                           andUniqueID:databaseGames.allKeys[i]]
                
                ;
                [databaseEvents addObject:thisEvent];
                i++;
                
            }
            
            self.gameArray = [[NSMutableArray alloc]initWithArray:databaseEvents];
            
            //notify the viewgameVC to reloadTableview;
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"loadedGames"
             object:self];
        }
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
}

#pragma mark - Edit Data in Firebase

-(void)editGameFromDatabase:(Event*) eventToEdit {
    
    NSNumber *latitude = [NSNumber numberWithDouble:eventToEdit.gameLocationLongAndLat.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithDouble:eventToEdit.gameLocationLongAndLat.coordinate.longitude];
    
    
    NSDictionary *editedEvent = @{ @"event": eventToEdit.gameGroupName,
                                   @"startTime": eventToEdit.gameStartTime,
                                   @"endTime": eventToEdit.gameEndTime,
                                   @"sport": eventToEdit.pickSport,
                                   @"street": eventToEdit.street,
                                   @"city": eventToEdit.city,
                                   @"state": eventToEdit.state,
                                   @"zipCode":eventToEdit.zipCode,
                                   @"longitude": longitude,
                                   @"latitude": latitude
                                   };
    
    
    [[[[[_ref child:@"users"] child:[FIRAuth auth].currentUser.uid]child:@"games"] child:eventToEdit.uID]
     setValue:editedEvent];
    
}

#pragma mark - Delete Data in Firebase

-(void)deleteGameFromDatabase:(Event*) eventToDelete {
    
    
    NSString *currentUser = [FIRAuth auth].currentUser.uid;
    
    
    [[[[[_ref child:@"users"]child:currentUser]child:@"games"] child:eventToDelete.uID] removeValue];
    
}

@end
