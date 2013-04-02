//
//  LPSearchBar.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 02.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPSearchBar.h"

@implementation LPSearchBar

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.clipsToBounds = YES;
    
    //to remove searchbar default background layer
    if ([[[self subviews] objectAtIndex:0] isKindOfClass:[UIImageView class]]){
        [[[self subviews] objectAtIndex:0] setAlpha:0.f];
        [[[self subviews] objectAtIndex:0] setBackgroundColor:[UIColor whiteColor]];
        [[[self subviews] objectAtIndex:0] setBackgroundImage:nil];
    }
    
    //to remove search icon. Note that objectAtIndex = 0 because background layer is already removed
    UITextField *textField;
    if ([[[self subviews] objectAtIndex:1] isKindOfClass:[UITextField class]]){
        textField = [[self subviews] objectAtIndex:1];
    }
    //    textField.leftView = nil;
    [textField setBackground:nil];
    
    CGRect frame = self.bounds;
    
    UIView *searchBackground = [[UIView alloc] initWithFrame:frame];
    searchBackground.backgroundColor = [UIColor whiteColor];
    
    frame.origin.y = frame.size.height-1.f;
    frame.size.height = 1.f;
    
    self.borderView = [[UIView alloc] initWithFrame:frame];
    self.borderView.backgroundColor = self.borderColor;
    [searchBackground addSubview:self.borderView];
    
    [self insertSubview:searchBackground atIndex:0];
}

@end
