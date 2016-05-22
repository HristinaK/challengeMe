//
//  AcceptViewController.m
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/9/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import "AcceptViewController.h"
#import <Social/Social.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation AcceptViewController {
     NSData *profilePictureData;
     UIImage *captureToImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fbShare = [[FBSDKShareButton alloc] init];
    self.fbShare.alpha = 1.0;
    self.fbShare.center = self.fbButtonView.center;
    self.fbShare.frame = CGRectMake(0, 0, self.fbButtonView.frame.size.width, self.fbButtonView.frame.size.height);
    //self.fbShare.frame = CGRectMake(0, 0, 100, 100);
    //self.fbShare.center = CGPointMake(self.fbShare.center.x, self.fbShare.center.y - 50);
    [self.fbButtonView addSubview:self.fbShare];
    self.capturedImage.layer.borderWidth = 2;
    self.capturedImage.layer.borderColor = [UIColor whiteColor].CGColor;
    

}


- (IBAction)eventSelectedCamera:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take photo", @"Choose photo", nil];
     [actionSheet showInView:self.view];

}

- (IBAction)eventSelectedClose:(id)sender
{
     [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)eventSelectedTwitterShare:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        if (captureToImage != nil)
        {
            [tweetSheet addImage:captureToImage];
        }
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self chooseExistingPhoto];
            break;
            
        default:
            break;
    }
}

- (void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)chooseExistingPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    captureToImage = chosenImage;
    self.capturedImage.image = captureToImage;
    self.capturedImage.contentMode = UIViewContentModeScaleAspectFill;
    self.capturedImage.clipsToBounds = YES;
    profilePictureData = UIImageJPEGRepresentation(chosenImage, 1.0);
    
    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.lblCamera.hidden = YES;
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = captureToImage;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    self.fbShare.shareContent = content;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
