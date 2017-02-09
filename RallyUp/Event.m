//
//  Event.m
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import "Event.h"

@implementation Event

-(instancetype)initWithGameGroupName:(NSString *)gameGroupName andGameStartTime:(NSString *)gameStartTime andGameEndTime:(NSString *)gameEndTime andPickSport:(NSString *)pickSport andStreet:(NSString *)street andCity:(NSString *)city andState:(NSString *)state andZipCode:(NSString *)zipcode andGameLocationLongAndLat:(CLLocation *)gameLocationLongAndLat andUniqueID:(NSString *)uID {
    
    self = [super init];
    
    _gameGroupName =gameGroupName;
    _gameStartTime = gameStartTime;
    _gameEndTime = gameEndTime;
    _pickSport = pickSport;
    _street = street;
    _city = city;
    _state = state;
    _zipCode = zipcode;
    _gameLocationLongAndLat = gameLocationLongAndLat;
    _uID = uID;
    
    return self;
    
}

@end
