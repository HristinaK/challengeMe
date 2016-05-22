//
//  AddViewController.h
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/16/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController
- (IBAction)eventSelectedCloseAddView:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputChallenge;
@property (weak, nonatomic) IBOutlet UITextField *inputPunishment;
- (IBAction)eventSelectedSendChallenge:(id)sender;
- (IBAction)ventSelectedSendPunishment:(id)sender;

@end
