//
//  LPPhoneBooth.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 02.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPPhoneBooth.h"

@implementation LPPhoneBooth

- (IBAction)callInfo:(id)sender
{
    [self placeCallTo:@"22591300"];
}

- (IBAction)callAmbulance:(id)sender
{
    [self placeCallTo:@"113"];
}

- (void)placeCallTo:(NSString *)number
{
    #if DEBUG
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ringer" message:number delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
    return;
    #endif
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"tel:%@", number];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    if([[UIApplication sharedApplication] canOpenURL:url])
        [[UIApplication sharedApplication] openURL:url];
    else
        NSLog(@"Could not call the number: %@", number);
}

@end
