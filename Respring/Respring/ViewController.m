//
//  ViewController.m
//  Respring
//
//  Created by Mattiello, Joseph R on 5/27/15.
//
//

#import "ViewController.h"


NSString *kCrashString = @"\u0635\u0651\u0628\u064f\u0631\u0631\u064b \u0963 \u0963h \u0963 \u0963\n\u5197";

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)crashMe:(id)sender{
    //    This will crash the app immediatly
    self.label.text = kCrashString;
}

-(IBAction)respring:(id)sender {
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertTitle = kCrashString;
    notification.alertBody = kCrashString;
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];

    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

    UIApplication *app = [UIApplication sharedApplication];
    [app performSelector:@selector(suspend)];
}

-(IBAction)sendClicked:(id)sender {
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"This device doesn't support sending messages"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }

    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    messageController.body = kCrashString;

        // Present message view controller on screen
    [self presentViewController:messageController
                       animated:YES
                     completion:nil];
}

-(IBAction)copyToClipboard:(id)sender {
    UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
    appPasteBoard.persistent = YES;
    appPasteBoard.string = kCrashString;
}

-(IBAction)share:(id)sender {

    NSArray *items = @[kCrashString];
    UIActivityViewController *shareController = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                                  applicationActivities:nil];

    [self presentViewController:shareController animated:YES completion:nil];
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Failed to send message"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            break;
        }
        case MessageComposeResultSent:
            break;
        default:
            break;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
