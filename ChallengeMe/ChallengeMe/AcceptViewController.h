//
//  AcceptViewController.h
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/9/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface AcceptViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>

- (IBAction)eventSelectedCamera:(id)sender;
- (IBAction)eventSelectedClose:(id)sender;
- (IBAction)eventSelectedTwitterShare:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *capturedImage;
//- (IBAction)eventSelectedFacebookShare:(id)sender;
@property (nonatomic, strong) FBSDKShareButton *fbShare;
@property (weak, nonatomic) IBOutlet UIView *fbButtonView;
@property (weak, nonatomic) IBOutlet UILabel *lblCamera;

@end
