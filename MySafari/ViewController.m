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
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (weak, nonatomic) IBOutlet UIButton *comingSoonButton;

@end



@implementation ViewController {

    NSArray *toolbarViews;
    int webViewLoads;
}

    /*  Next I want to add the method that will update the textField to reflect the URL
    whatever webpage is displayed within the webView. Looks like the answer lies
    with UIWebViewDelegate's "didStartLoad" method. */


#pragma mark Initialization

- (void)viewDidLoad {

    [super viewDidLoad];


    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;

    toolbarViews = [[NSArray alloc]initWithObjects:self.urlTextField,
                  self.backButton,self.forwardButton,self.backdropView,
                  self.stopButton, nil];

    self.webView.scrollView.delegate = self;

    NSString *initialWebpage = @"http://www.google.com";

    [self requestWithURL:initialWebpage];
    self.urlTextField.text = initialWebpage;

    self.backdropView.layer.borderColor = [UIColor blackColor].CGColor;
    self.backdropView.layer.borderWidth = 0.35;
//    self.backdropView.frame = CGRectMake(, 0, 325, 82);
    self.backdropView.layer.cornerRadius = 2.5;
    self.backdropView.layer.masksToBounds = YES;
}


#pragma mark Button methods

- (IBAction)onComingSoonButtonPressed:(UIButton *)sender {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New features"
                                                                             message:@"Coming soon.."
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Oh, well that's cool."
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];

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

- (IBAction)onClearButtonPressed:(id)sender {

    self.urlTextField.text = @"";
    self.urlTextField.placeholder = @"enter site address here";
}



#pragma mark Webview management methods


- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSString *finalURL = self.urlTextField.text;
    
    if (![self.urlTextField.text hasPrefix:@"http://"]) {

        finalURL = [@"http://" stringByAppendingString:
                    self.urlTextField.text];
    }


    [self requestWithURL:finalURL];

    return YES;
}


- (void)requestWithURL:(NSString *)aURL {

    NSURL *url = [NSURL URLWithString:aURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint translation = [scrollView.panGestureRecognizer
                           translationInView:scrollView.superview];

        for (UIView *view in toolbarViews) {

            view.hidden = translation.y < 0 ? YES : NO;
        }
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

        self.urlTextField.text = [NSString stringWithFormat:@"%@", request.URL];

        return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    if ([self.webView canGoBack]) {
        self.backButton.enabled = YES;
    }
    else (self.backButton.enabled = NO);
    if ([self.webView canGoForward]) {
        self.forwardButton.enabled = YES;
    }
    else (self.forwardButton.enabled = NO);

    self.urlTextField.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

}

@end
