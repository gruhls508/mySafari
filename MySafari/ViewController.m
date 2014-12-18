//
//  ViewController.m
//  MySafari
//
//  Created by Meredith Packham on 7/23/14.
//  Copyright (c) 2014 Intradine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIView *backdropView;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;


@end

@implementation ViewController {

    NSArray *viewsArray;
    CGFloat lastContentOffset;
    CGFloat yVelocity;
}


#pragma mark Initialization

- (void)viewDidLoad {

    [super viewDidLoad];

    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;

    viewsArray = [[NSArray alloc]initWithObjects:self.webView,self.urlTextField,self.backButton,self.forwardButton,self.backdropView,
    self.stopButton, nil];

    self.webView.scrollView.delegate = self;
}


#pragma mark Button methods

- (IBAction)onComingSoonButtonPressed:(UIButton *)sender {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New features" message:@"Coming soon.." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Oh, well that's cool." style:UIAlertActionStyleDefault handler:nil
        ]
     ];

    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
    
}

- (IBAction)onReloadButtonPressed:(UIButton *)sender {

    [self.webView reload];
}

- (IBAction)onBackButtonPressed:(UIButton *)sender {

        [self.webView goBack];

}

- (IBAction)onForwardButtonPressed:(UIButton *)sender {

    [self.webView goForward];

}

- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {

    [self.webView stopLoading];

}


#pragma mark Handling WebView load

-(void)webViewDidFinishLoad:(UIWebView *)webView{
        
    if ([self.webView canGoBack]) {
        self.backButton.enabled = YES;
    }
    else (self.backButton.enabled = NO);
    if ([self.webView canGoForward]) {
        self.forwardButton.enabled = YES;
    }
    else (self.forwardButton.enabled = NO);
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSString *finalURL = self.urlTextField.text;
    
    if (![self.urlTextField.text hasPrefix:@"http://"]) {

        finalURL = [@"http://" stringByAppendingString:
                    self.urlTextField.text];
    }

    NSURL *url = [NSURL URLWithString:finalURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];


    return YES;
}


/*  Just got this detecting scroll events. Just need to detect whether the scrollView
    is going upward or not. */

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    if([scrollView isEqual:_webView.scrollView]) {
//
//
//
//    }
//}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    if([scrollView isEqual:self.webView.scrollView]) {

        NSLog(@"%f", scrollView.contentOffset.y);

    }
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//
//    if(([scrollView isEqual:self.webView.scrollView]) && (lastContentOffset > (int)scrollView.contentOffset.y)) {
//
//    }
//
//}


@end
