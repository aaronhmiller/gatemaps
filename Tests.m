//
//  Tests.m
//  Gate Maps
//
//  Created by Aaron Miller on 2/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#include "TargetConditionals.h"
#if !TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

#import "Tests.h"
#import "RootViewController.h"
#import "AirportViewController.h"
#import "DetailViewController.h"

@implementation Tests

-(void)testAirportViewController {
	RootViewController *rvc = [[RootViewController alloc] init];
	rvc.airportList = [[NSMutableArray alloc] init]; //Item 1, Item 2...
	[rvc loadArray];
	
	for (int i=0; i<rvc.airportList.count; i++) {
		NSString *mainImage = [[rvc.airportList objectAtIndex:i] objectForKey:@"Main Image"];
		AirportViewController *localAVC = [[AirportViewController alloc] initWithAirportCode:[[rvc.airportList objectAtIndex:i] objectForKey:@"Code"]];
		localAVC.dvc = nil;
		rvc.avc = localAVC;
		[localAVC release];
		STAssertNotNil([[rvc avc] airportMap],@"Missing %@ file from bundle", mainImage);
		//traverse submaps
		NSDictionary *submaps = [[rvc.airportList objectAtIndex:i] objectForKey:@"submaps"];
		NSLog(@"submaps: %@", submaps);
		NSEnumerator *objEnumerator = [submaps objectEnumerator];
		id obj;
		while ((obj = [objEnumerator nextObject])) {
			NSString *detailImage = [obj objectForKey:@"image"];
			NSLog(@"Detail image name: %@", detailImage);
			DetailViewController *dvc = [[DetailViewController alloc] initWithDetails:detailImage terminal:nil url:@"http://www.apple.com"];
			STAssertNotNil(dvc.detailMapImage, @"Missing %@ file from bundle", detailImage);			
		}
	}
}

@end
#endif
