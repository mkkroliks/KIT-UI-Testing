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
    //perform actions before running test
}
/*********************************************************/
/***** ALL TESTS ARE RUNNING IN ALPHABETICAL ORDER!!! ****/
/***** AND HAVE TO START WITH KEYBOARD "TEST" ************/
/*********************************************************/

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
    UISlider *slider = (UISlider *)[tester waitForViewWithAccessibilityLabel:@"Work Time Slider"]
    ;//waitForViewWithAccessibilityLabel not only wait for view, but also return a pointer of that UISlider that's why we can easly cast it.
    STAssertEqualsWithAccuracy([slider value], 15.0f, 0.1, @"Work time slider was not set!");
    //test if slider value is equal to the second parameter value. Accuracy is 0.1 beacause sometimes float can't be 15.00 but 15.00000001.
}

- (void)selectPresetAtIndex:(NSInteger)index {
    [tester tapViewWithAccessibilityLabel:@"Timer"];
    
    [tester tapViewWithAccessibilityLabel:@"Presets"];
    [tester tapRowInTableViewWithAccessibilityLabel:@"Presets List"
                                        atIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    [tester waitForAbsenceOfViewWithAccessibilityLabel:@"Presets List"];
}

- (void)test20StartTimerAndWaitForFinish {
    [tester tapViewWithAccessibilityLabel:@"Timer"];
    [tester clearTextFromAndThenEnterText:@"Test the timer" intoViewWithAccessibilityLabel:@"Task Name"];
    [tester tapViewWithAccessibilityLabel:@"done"];
    
    [tester setValue:1 forSliderWithAccessibilityLabel:@"Work Time Slider"];
    [tester setValue:50 forSliderWithAccessibilityLabel:@"Work Time Slider"];
    [tester setValue:1 forSliderWithAccessibilityLabel:@"Work Time Slider"];
    [tester setValue:8 forSliderWithAccessibilityLabel:@"Work Time Slider"];
    
    [tester setValue:1 forSliderWithAccessibilityLabel:@"Break Time Slider"];
    [tester setValue:25 forSliderWithAccessibilityLabel:@"Break Time Slider"];
    [tester setValue:2 forSliderWithAccessibilityLabel:@"Break Time Slider"];
}

- (void)test30StepperIncrementationDecremantation {
    UIStepper *repsStepper = (UIStepper*)[tester waitForViewWithAccessibilityLabel:@"Reps Stepper"];
    CGPoint stepperCenter = [repsStepper.window convertPoint:repsStepper.center
                                                    fromView:repsStepper.superview];
    //center coordinates of the UIStepper relative to the window as a whole
    CGPoint centerMinusButton = stepperCenter;
    centerMinusButton.x -= CGRectGetWidth(repsStepper.frame) / 4;
    
    CGPoint centerPlusButton = stepperCenter;
    centerPlusButton.x += CGRectGetWidth(repsStepper.frame) / 4;
    
    [tester waitForTimeInterval:1];

    for (int i = 0; i < 20; i++) {
        [tester tapScreenAtPoint:centerMinusButton];
    }
    
    [tester waitForTimeInterval:1];
    [tester tapScreenAtPoint:centerPlusButton];
    [tester waitForTimeInterval:1];
    [tester tapScreenAtPoint:centerPlusButton];
    [tester waitForTimeInterval:1];
    
    [KIFUITestActor setDefaultTimeout:60];
    
    [tester tapViewWithAccessibilityLabel:@"Start Working"];
    // the timer is ticiking
    [tester waitForViewWithAccessibilityLabel:@"Start Working"];
    
    [KIFUITestActor setDefaultTimeout:10];
}


@end
