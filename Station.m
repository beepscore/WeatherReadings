// 
//  Station.m
//  WeatherReadings
//
//  Created by Steve Baker on 11/11/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import "Station.h"
#import "Observation.h"
#import "BSGlobalValues.h"

@implementation Station 

#pragma mark Accessors
// replaced @dynamic with @synthesize to override setIdCode
@synthesize idCode;

@dynamic name;
@dynamic latitude;
@dynamic longitude;
@dynamic observations;

@synthesize isImportingStation;
@synthesize isImportingObservation;

// init
- (id)init {
    if (self = [super init]) {
        [self setIsImportingStation:NO];
        [self setIsImportingObservation:NO];
    }
    return self;
}

- (void)setIdCode:(NSString *)anIdCode {
    
    if ( idCode == anIdCode)
        return;
    
    // increment retain count on the object 'anIdCode' points to.  See Hillegass pg 69
    [anIdCode retain];
    
    [idCode release];
    
    // point 'idCode' to the same object as 'anIdCode'
    idCode = anIdCode;
    
    [self populateStationAttributes];    
}

- (void)populateStationAttributes {
    DLog(@"populateStationAttributes %@", self);
    DLog(@"%@", self.URLStringForWeatherUndergroundLocation);
    
    [self setIsImportingStation:YES];    
    NSError *error;
    NSXMLDocument *xmlDoc = 
    [[NSXMLDocument alloc] initWithContentsOfURL:self.URLForWeatherUndergroundLocation
                                         options:0
                                           error:&error];
    
    [self setIsImportingStation:NO];
    DLog(@"%@", xmlDoc);
    
    self.name = [[[[xmlDoc rootElement] elementsForName:@"city"] objectAtIndex:0] stringValue];
    
    NSXMLElement *latitudeElement = 
    [[[xmlDoc rootElement] elementsForName:@"lat"] objectAtIndex:0];
    self.latitude = [NSNumber numberWithFloat:latitudeElement.stringValue.floatValue];
    
    NSXMLElement *longitudeElement = 
    [[[xmlDoc rootElement] elementsForName:@"lon"] objectAtIndex:0];
    self.longitude = [NSNumber numberWithFloat:longitudeElement.stringValue.floatValue];
    
    DLog(@"%@ %@ %@ %@", self.idCode, self.name, self.latitude, self.longitude);    
    
    // SB added to remove memory leak
    [xmlDoc release];    
}
#pragma mark -

#pragma mark URL Methods
- (NSString *)URLStringForWeatherUndergroundLocation {
    return [NSString
            stringWithFormat:@"%@%@", BSWULocationString, self.idCode];
}

- (NSURL *)URLForWeatherUndergroundLocation {
    return [NSURL URLWithString:self.URLStringForWeatherUndergroundLocation];
}

- (NSString *)URLStringForWeatherUndergroundConditions {
    return [NSString
            stringWithFormat:@"%@%@", BSWUObservationString, self.idCode];
}

- (NSURL *)URLForWeatherUndergroundConditions {
    return [NSURL URLWithString:self.URLStringForWeatherUndergroundConditions];
}

#pragma mark -
// Ref Hillegass Ch 30 pg 369
- (void)addObservationsObject:(Observation *)value {
    DLog(@"Station %@ adding observation %@",
         [self name], [value observationTime]);
    
    NSSet *aSet = [NSSet setWithObject:value];
    [self willChangeValueForKey:BSObservationsKey
                withSetMutation:NSKeyValueUnionSetMutation
                   usingObjects:aSet];
    [[self primitiveValueForKey:BSObservationsKey] addObject:value];
    [self didChangeValueForKey:BSObservationsKey
               withSetMutation:NSKeyValueUnionSetMutation
                  usingObjects:aSet];
}

- (void)removeObservationsObject:(Observation *)value {
    DLog(@"Station %@ removing observation %@",
         [self name], [value observationTime]);

    NSSet *aSet = [NSSet setWithObject:value];
    [self willChangeValueForKey:BSObservationsKey
                withSetMutation:NSKeyValueMinusSetMutation
                   usingObjects:aSet];
    [[self primitiveValueForKey:BSObservationsKey] removeObject:value];
    [self didChangeValueForKey:BSObservationsKey
               withSetMutation:NSKeyValueMinusSetMutation
                  usingObjects:aSet];
}


- (void)updateCurrentConditions:(id)sender {
    DLog(@"updateCurrentConditions %@", self);
    DLog(@"%@", self.URLStringForWeatherUndergroundConditions);
    
    [self setIsImportingObservation:YES];
    NSError *error;
    NSXMLDocument *xmlDoc = 
    [[NSXMLDocument alloc] initWithContentsOfURL:self.URLForWeatherUndergroundConditions
                                         options:0
                                           error:&error];
    [self setIsImportingObservation:NO];
    
    DLog(@"%@", xmlDoc);
    DLog(@"%@", [[xmlDoc rootElement] elementsForName:@"observation_time"]);
    DLog(@"%@ %@", [[xmlDoc rootElement] elementsForName:@"temp_f"],
          [[xmlDoc rootElement] elementsForName:@"observation_epoch"]);
    
    Observation *newObservation =
    [NSEntityDescription insertNewObjectForEntityForName:@"Observation"
                                  inManagedObjectContext:self.managedObjectContext];
    NSXMLElement *temperatureElement = 
    [[[xmlDoc rootElement] elementsForName:@"temp_f"] objectAtIndex:0];
    newObservation.temperature = [NSNumber numberWithInt:temperatureElement.stringValue.intValue];
    
    NSXMLElement *timeElement = 
    [[[xmlDoc rootElement] elementsForName:@"observation_epoch"] objectAtIndex:0];
    DLog(@"%@ %f", timeElement.stringValue, timeElement.stringValue.doubleValue);
    NSDate *timeObserved = [NSDate dateWithTimeIntervalSince1970:timeElement.stringValue.doubleValue];
    DLog(@"%@", timeObserved);
    newObservation.observationTime = timeObserved;
    
    newObservation.station = self;
    
    // SB added to remove memory leak
    [xmlDoc release];
}



@end
