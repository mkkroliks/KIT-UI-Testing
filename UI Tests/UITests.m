//
//  UITests.m
//  solanum
//
//  Created by Maciej Krolikowski on 03/02/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

#import "UITests.h"

@implementation UITests
- (void)beforeAll {
//    [tester tapViewWithAccessibilityLabel:@"Settings"];
//    
//    [tester setOn:YES forSwitchWithAccessibilityLabel:@"Debug Mode"];
//    
//    [tester tapViewWithAccessibilityLabel:@"Clear History"];
//    [tester tapViewWithAccessibilityLabel:@"Cancel"];
}

-(void)test00TabBarButtons {
    [tester tapViewWithAccessibilityLabel:@"History"];
    [tester waitForViewWithAccessibilityLabel:@"History Label"];
    
    [tester tapViewWithAccessibilityLabel:@"Timer"];
    [tester waitForViewWithAccessibilityLabel:@"Task Name"];
    
    // 3
    [tester tapViewWithAccessibilityLabel:@"Settings"];
    [tester waitForViewWithAccessibilityLabel:@"Debug Mode"];
}

- (void)test10PresetTimer {
    // 1
    [tester tapViewWithAccessibilityLabel:@"Timer"];
    
    // 2
    [tester enterText:@"Set up a test" intoViewWithAccessibilityLabel:@"Task Name"];
    [tester tapViewWithAccessibilityLabel:@"done"];
    
    // 3
    [self selectPresetAtIndex:1];
    
    // 4
    UISlider *slider = (UISlider *)[tester waitForViewWithAccessibilityLabel:@"Work Time Slider"];
    STAssertEqualsWithAccuracy([slider value], 15.0f, 0.1, @"Work time slider was not set!");
}

- (void)selectPresetAtIndex:(NSInteger)index {
    [tester tapViewWithAccessibilityLabel:@"Timer"];
    
    [tester tapViewWithAccessibilityLabel:@"Presets"];
    [tester tapRowInTableViewWithAccessibilityLabel:@"Presets List"
                                        atIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    [tester waitForAbsenceOfViewWithAccessibilityLabel:@"Presets List"];
}


@end
