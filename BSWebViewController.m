//
//  BSWebViewController.m
//  WeatherReadings
//
//  Created by Steve Baker on 11/24/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import "BSWebViewController.h"
#import <WebKit/WebKit.h>
#import "BSGlobalValues.h"

@implementation BSWebViewController

@synthesize latitudeField;
@synthesize longitudeField;

#pragma mark Methods Xcode generated for NSView
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

#pragma mark sbMethods
- (void) awakeFromNib {
    
    // Set an initial URL on the web view so we'll have something to display.
    // google maps free to use on free web sites.
    // [myWebView setMainFrameURL: @"http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=weather+station+KBFI"];
    
    // display open street map
    [myWebView setMainFrameURL: @"http://www.openstreetmap.org/?lat=47.530000&lon=-122.301972&zoom=12"];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

#pragma mark -
- (void)dealloc {
    
    // after release, best practice is set object = nil;
    // then if someone accidentally calls it,
    // they will get nil instead of a bad reference.
    // setting to nil will cause release also.
    
    [super dealloc];
}

- (void)reloadMap{
    
    DLog(@"latitude %@ longitude %@", latitudeField.stringValue, longitudeField.stringValue);
    NSString *mapURLString = 
      [NSString stringWithFormat:@"http://www.openstreetmap.org/?lat=%@&lon=%@&zoom=12",
      latitudeField.stringValue, longitudeField.stringValue];
    [myWebView setMainFrameURL:mapURLString];   
}

#pragma mark NSTabViewDelegate methods
- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    [self reloadMap];
}


@end
