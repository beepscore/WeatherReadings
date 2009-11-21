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

@dynamic latitude;
@dynamic name;
@dynamic longitude;
@dynamic idCode;
@dynamic observations;

// TODO: override keyPathsForValuesAffectingName similar to Hillegass pg 368?
//+ (NSSet *)keyPathsForValuesAffectingName {
//    return [NSSet setWithObjects:BSIdCodeKey];
//}

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

// Methods from Hal
- (NSString *)URLStringForWeatherUndergroundConditions {
    return [NSString
            stringWithFormat:@"%@%@", BSWUObservationString, self.idCode];
}

- (NSURL *)URLForWeatherUndergroundConditions {
    return [NSURL URLWithString:self.URLStringForWeatherUndergroundConditions];
}

- (void)updateCurrentConditions:(id)sender {
    DLog(@"updateCurrentConditions %@", self);
    DLog(@"%@", self.URLStringForWeatherUndergroundConditions);
    
    NSError *error;
    NSXMLDocument *xmlDoc = 
    [[NSXMLDocument alloc] initWithContentsOfURL:self.URLForWeatherUndergroundConditions
                                         options:0
                                           error:&error];
    
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
