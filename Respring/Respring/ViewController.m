//
//  ViewController.m
//  Respring
//
//  Created by Mattiello, Joseph R on 5/27/15.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)respring:(id)sender {
    NSString *notificationString = @" effective.\nPower\n\u0644\u064f\u0644\u064f\u0635\u0651\u0628\u064f\u0644\u064f\u0644\u0635\u0651\u0628\u064f\u0631\u0631\u064b \u0963 \u0963h \u0963 \u0963\n\u5197";

    UILocalNotification *notification = [UILocalNotification new];
    notification.alertTitle = notificationString;
    notification.alertBody = notificationString;
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];

    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

    UIApplication *app = [UIApplication sharedApplication];
    [app performSelector:@selector(suspend)];
}
@end
