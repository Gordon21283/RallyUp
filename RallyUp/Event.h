//
//  Event.h
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface Event : NSObject

@property (nonatomic, strong) NSString *gameGroupName;
@property (nonatomic, strong) NSString *gameStartTime;
@property (nonatomic, strong) NSString *gameEndTime;
@property (nonatomic, strong) NSString *pickSport;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *uID;
@property (nonatomic, strong) CLLocation *gameLocationLongAndLat;

-(instancetype)initWithGameGroupName:(NSString *)gameGroupName andGameStartTime:(NSString *)gameStartTime andGameEndTime:(NSString *)gameEndTime andPickSport:(NSString *)pickSport andStreet:(NSString *)street andCity:(NSString *)city andState:(NSString *)state andZipCode:(NSString *)zipcode andGameLocationLongAndLat:(CLLocation *)gameLocationLongAndLat andUniqueID:(NSString *)uID;

@end
