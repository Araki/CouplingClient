//
//  FBManager.m
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "FBManager.h"

@implementation FBManager

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    NSArray *permissions = [NSArray arrayWithObjects:@"email", @"read_friendlists, "@"user_about_me", @"user_birthday", @"user_work_history", @"user_education_history", @"user_interests", nil];
    return [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:allowLoginUI completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
        [self sessionStateChanged:session state:state error:error];
    }];
}

/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    self.session = session;
    NSLog(@"@@@@@ sessionStateChanged: %d", session.state);
    switch (state) {
        case FBSessionStateOpen:
            break;
        case FBSessionStateClosed:
            NSLog(@"FBSessionStateClosed");
            break;
        case FBSessionStateCreatedTokenLoaded:
            NSLog(@"FBSessionStateCreatedTokenLoaded");
            break;
        case FBSessionStateClosedLoginFailed:
            NSLog(@"FBSessionStateClosedLoginFailed");
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FBSessionStateChangedNotification object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)closeSession {
    [FBSession.activeSession closeAndClearTokenInformation];
}

#pragma mark -




@end
