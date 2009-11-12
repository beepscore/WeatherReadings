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

@dynamic lat;
@dynamic name;
@dynamic lon;
@dynamic idCode;
@dynamic observations;

// TODO: override keyPathsForValuesAffectingName similar to Hillegass pg 368?
//+ (NSSet *)keyPathsForValuesAffectingName {
//    return [NSSet setWithObjects:BSIdCodeKey];
//}

// Ref Hillegass Ch 30 pg 369
- (void)addObservationsObject:(Observation *)value {
    DLog(@"Station %@ adding observation %@",
         [self name], [value time]);
    
    NSSet *s = [NSSet setWithObject:value];
    [self willChangeValueForKey:BSObservationsKey
                withSetMutation:NSKeyValueUnionSetMutation
                   usingObjects:s];
    [[self primitiveValueForKey:BSObservationsKey] addObject:value];
    [self didChangeValueForKey:BSObservationsKey
               withSetMutation:NSKeyValueUnionSetMutation
                  usingObjects:s];
}

- (void)removeObservationsObject:(Observation *)value {
    DLog(@"Station %@ removing observation %@",
         [self name], [value time]);

    NSSet *s = [NSSet setWithObject:value];
    [self willChangeValueForKey:BSObservationsKey
                withSetMutation:NSKeyValueMinusSetMutation
                   usingObjects:s];
    [[self primitiveValueForKey:BSObservationsKey] removeObject:value];
    [self didChangeValueForKey:BSObservationsKey
               withSetMutation:NSKeyValueMinusSetMutation
                  usingObjects:s];
}
@end
