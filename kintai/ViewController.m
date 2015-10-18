//
//  ViewController.m
//  kintai
//
//  Created by 鎌倉　和弘 on 2015/10/13.
//  Copyright © 2015年 鎌倉　和弘. All rights reserved.
//

#import "ViewController.h"


static NSString const *DATE=@"";

@interface ViewController ()
<MFMailComposeViewControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray *_textFieldArray;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // NSUserDefaultsからデータを読み込む
    self.toAddress.delegate = self;
    self.ccAddress.delegate = self;
    self.nameText.delegate = self;
    self.bossText.delegate = self;
    //NSDateFormatterクラスを出力する。
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    //Localeを指定。ここでは日本を設定。
    [format setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    //出力形式を文字列で指定する。
    [format setDateFormat:@"MM/dd"];
    // 現在時刻を取得しつつ、NSDateFormatterクラスをかませて、文字列を出力する。
    DATE = [format stringFromDate:[NSDate date]];
    [self showMainTextAndTitle];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)viewButton:(UIButton *)sender {

    //データの保存
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.toAddress.text forKey:@"TOADDRESS"];
    [ud setObject:self.ccAddress.text forKey:@"CCADDRESS"];
    [ud setObject:self.titleLabel.text forKey:@"TITLE"];
    [ud setObject:self.nameText.text forKey:@"NAME"];
    [ud setObject:self.bossText.text forKey:@"BOSS"];
    if ([ud synchronize]) {
        NSLog(@"%@", @"データの保存に成功しました。");
    }
    
    [self showMainTextAndTitle];
    

}

- (IBAction)sendButton:(id)sender {
    // メールビュー生成
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setToRecipients:[ NSArray arrayWithObject:self.toAddress.text ] ];
    // 半角スペースを区切りとして文字列を分割
    NSArray *ccAddressArray = [self.ccAddress.text componentsSeparatedByString:@","];
    for( NSString *ccAddress in ccAddressArray){
        
    }

    [picker setCcRecipients:[ NSArray arrayWithObjects:self.ccAddress.text, nil ] ];
    // メール件名
    [picker setSubject:self.titleLabel.text];
    // メール本文
    [picker setMessageBody:self.mainText.text isHTML:NO];
    // メールビュー表示
    [self presentViewController:picker animated:YES completion:nil];
}

// userdefaultに保存されている内容の表示
- (void)showMainTextAndTitle {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // UserDefaultsの取得
    NSString *udToAddress= [ud stringForKey:@"TOADDRESS"];
    NSString *udCcAddress= [ud stringForKey:@"CCADDRESS"];
    NSString *udTitle= [ud stringForKey:@"TITLE"];
    NSString *udName= [ud stringForKey:@"NAME"];
    NSString *udBoss= [ud stringForKey:@"BOSS"];
    
    self.toAddress.text = udToAddress;
    self.ccAddress.text = udCcAddress;
    self.titleLabel.text = udTitle;
    self.nameText.text = udName;
    self.bossText.text = udBoss;
    
    // タイトルの反映
    if([udTitle length] > 0){
        self.titleLabel.text = [NSString stringWithFormat:@"[勤怠] %@%@",DATE,udName];
    } else {
        self.titleLabel.text = [NSString stringWithFormat:@"[勤怠] %@",DATE];
    }
    // 本文の反映
    if ([udBoss length] > 0){
        self.mainText.text = [NSString stringWithFormat:@"%@さん\n\nお疲れ様です。%@です。\n本日体調不良のため、午前半休を取得させてください。\nご迷惑をおかけして申し訳ございません。\nどうぞよろしくお願いいたします。",udBoss,udName];
    } else {
        self.mainText.text = [NSString stringWithFormat:@"%@です。\n\n本日体調不良のため、午前半休を取得させてください。\nご迷惑をおかけして申し訳ございません。\nどうぞよろしくお願いいたします。",udName];
    }
}

// アプリ内メーラーのデリゲートメソッド
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            // キャンセル
            
            break;
        case MFMailComposeResultSaved:
            // 保存 (ここでアラート表示するなど何らかの処理を行う)
            
            break;
        case MFMailComposeResultSent:
            // 送信成功 (ここでアラート表示するなど何らかの処理を行う)
            
            break;
        case MFMailComposeResultFailed:
            // 送信失敗 (ここでアラート表示するなど何らかの処理を行う)
            
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
