//
//  AppDelegate.m
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/MagicalRecord+ShorthandMethods.h>
#import <MagicalRecord/MagicalRecordShorthandMethodAliases.h>

#import "AudioQuestion.h"
#import "DrawingQuestion.h"
#import "DrawingAudioQuestion.h"
#import "Answer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MagicalRecord enableShorthandMethods];
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    [Question MR_truncateAll];
    [Answer MR_truncateAll];
    
    NSArray * qs = @[
//                          @{
//                              @"order": @1,
//                              @"text": @"I want you to draw a line from the number to the letter in an ascending order. For example, 1 to A is drawn here, now draw A to 2, and 2 to B, and continue this pattern."
//                            },
                          @{
                              @"order": @2,
                              @"text": @"I want you to now draw and copy this cube. Please copy the cube you see in this picture. Draw it on the next screen. Thank you."
                              }
                         ,
                          @{
                              @"order": @3,
                              @"text": @"Please draw a clock with your finger. Make a big circle and put all the numbers of a clock where they are supposed to be. Please set the time for the clock for 10 past 11."
                              }
                          ];
    for (NSDictionary * q in qs) {
        DrawingQuestion * question = [DrawingQuestion MR_createEntity];;
        question.order = q[@"order"];
        question.text = q[@"text"];
        NSString * fileNumber = [[NSNumber numberWithInt:[question.order integerValue] + 1] stringValue];
        question.audioBinary = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileNumber ofType:@"mp3"]];
        
        if ([question.order intValue] == 2) {
            question.drawingBinary = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[question.order stringValue] ofType:@"png"]];
        }
    }
    
    qs = @[
           @{
               @"order": @6,
               @"text": @"Good job! Last animal to name. Please speak into the phone the name of this animal."
               }
           ];
    
    for (NSDictionary * q in qs) {
        DrawingAudioQuestion * question = [DrawingAudioQuestion MR_createEntity];;
        question.order = q[@"order"];
        question.text = q[@"text"];
        NSString * fileNumber = [[NSNumber numberWithInt:[question.order integerValue] + 1] stringValue];
        question.audioBinary = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileNumber ofType:@"mp3"]];
        question.drawingBinary = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[question.order stringValue] ofType:@"png"]];
    }
    
    qs = @[
           @{
               @"order": @16,
               @"text": @"The numbers are: 7, 4, 2. Please speak into the phone these numbers back to me backwards."
               }
           ];
    for (NSDictionary * q in qs) {
        AudioQuestion * question = [AudioQuestion MR_createEntity];;
        question.order = q[@"order"];
        question.text = q[@"text"];
        NSString * fileNumber = [[NSNumber numberWithInt:[question.order integerValue] + 1] stringValue];
        question.audioBinary = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileNumber ofType:@"mp3"]];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

@end
