//
//  BSWebViewController.h
//  WeatherReadings
//
//  Created by Steve Baker on 11/24/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class WebView;

@interface BSWebViewController : NSView <NSTabViewDelegate> {
    
    IBOutlet WebView *myWebView;
    NSTextField * latitudeField;
    NSTextField * longitudeField;
    NSTabView * myTabView;
}

@property (assign) IBOutlet NSTextField *latitudeField;
@property (assign) IBOutlet NSTextField *longitudeField;
@property (assign) IBOutlet NSTabView *myTabView;

- (void)reloadMap;

@end
