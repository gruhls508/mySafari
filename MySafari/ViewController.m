//
//  ViewController.m
//  MySafari
//
//  Created by Meredith Packham on 7/23/14.
//  Copyright (c) 2014 Intradine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;


@end

@implementation ViewController

- (IBAction)onComingSoonButtonPressed:(UIButton *)sender {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New features" message:@"Coming soon.." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Oh, well that's cool." style:UIAlertActionStyleDefault handler:nil
        ]
     ];


    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
    
}

- (void)onViewTapped:(UITapGestureRecognizer *)sender {
}

- (IBAction)onReloadButtonPressed:(UIButton *)sender {

    [self.myWebView reload];
}

- (IBAction)onBackButtonPressed:(UIButton *)sender {

        [self.myWebView goBack];

}

- (IBAction)onForwardButtonPressed:(UIButton *)sender {

    [self.myWebView goForward];

}

- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.myWebView stopLoading];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
        
    if ([self.myWebView canGoBack]) {
        self.backButton.enabled = YES;
    }
    else (self.backButton.enabled = NO);
    if ([self.myWebView canGoForward]) {
        self.forwardButton.enabled = YES;
    }
    else (self.forwardButton.enabled = NO);
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSString *finalURL = self.myURLTextField.text;
    
    if (![self.myURLTextField.text hasPrefix:@"http://"]) {

        finalURL = [@"http://" stringByAppendingString:
                    self.myURLTextField.text];
    }

    NSURL *url = [NSURL URLWithString:finalURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:urlRequest];


    return YES;
}

@end
