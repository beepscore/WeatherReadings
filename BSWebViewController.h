//
//  BSWebViewController.h
//  WeatherReadings
//
//  Created by Steve Baker on 11/24/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class WebView;

@interface BSWebViewController : NSView {
    
    IBOutlet WebView *myWebView;
    NSTextField * latitudeField;
    NSTextField * longitudeField;
}

@property (nonatomic, retain) IBOutlet NSTextField * latitudeField;
@property (nonatomic, retain) IBOutlet NSTextField * longitudeField;

- (IBAction)reloadMap:(id)sender;

@end
