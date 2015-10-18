//
//  ViewController.h
//  kintai
//
//  Created by 鎌倉　和弘 on 2015/10/13.
//  Copyright © 2015年 鎌倉　和弘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController<MFMailComposeViewControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *toAddress;
@property (weak, nonatomic) IBOutlet UITextField *ccAddress;
@property (weak, nonatomic) IBOutlet UITextView *mainText;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *bossText;

- (IBAction)viewButton:(UIButton *)sender;
- (IBAction)sendButton:(id)sender;


@end

