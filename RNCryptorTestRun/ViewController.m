//
//  ViewController.m
//  RNCryptor Test Run
//
//  Created by Ian Alexander Rahman on 4/16/16.
//  Copyright © 2016 Ian Alexander Rahman. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@import RNCryptor;

@interface ViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UIStackView *stackView;
@property (strong, nonatomic) UITextField *textToConvert;
@property (strong, nonatomic) UITextField *result;
@property (strong, nonatomic) UIButton *convertButton;
@property (nonatomic) BOOL direction;
@property (strong, nonatomic) NSData *dataToConvert;
@property (strong, nonatomic) NSData *convertedData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize and setup subviews
    self.password = [[UITextField alloc] init];
    self.password.placeholder = @"Input your password here";
    self.password.backgroundColor = [UIColor lightGrayColor];
    self.password.textColor = [UIColor whiteColor];
    
    self.textToConvert = [[UITextField alloc] init];
    self.textToConvert.placeholder = @"Text to Convert";
    self.textToConvert.backgroundColor = [UIColor colorWithRed:0.36 green:0.80 blue:0.83 alpha:1.0];
    
    self.result = [[UITextField alloc]init];
    self.result.placeholder = @"Result of Conversion";
    self.result.backgroundColor = [UIColor colorWithRed:0.36 green:0.80 blue:0.83 alpha:1.0];
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.distribution = UIStackViewDistributionEqualSpacing;
    self.stackView.alignment = UIStackViewAlignmentCenter;
    self.stackView.spacing = 5;
    
    [self.stackView addArrangedSubview:self.textToConvert];
    [self.stackView addArrangedSubview:self.result];
    
    self.convertButton = [[UIButton alloc] init];
    [self.convertButton setTitle:@"Encrypt" forState:UIControlStateNormal];
    self.convertButton.backgroundColor = [UIColor redColor];
    
    // Add the text field views and convert button to the main view
    [self.view addSubview:self.password];
    [self.view addSubview:self.stackView];
    [self.view addSubview:self.convertButton];
    
    // Turn off taslation of autoresizing masks into constraints
    [self.password setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.textToConvert setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.result setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.convertButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Set constraints and apperance for subviews
    [self.password.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.password.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
    [self.password.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    [self.password.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.05].active = YES;
    [self.password.layer setCornerRadius:14.0f];
    
    [self.stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.stackView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    [self.stackView.topAnchor constraintEqualToAnchor:self.password.bottomAnchor constant:10].active = YES;
    [self.stackView.bottomAnchor constraintEqualToAnchor:self.convertButton.topAnchor constant:-10].active = YES;
    
    [self.convertButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.convertButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20].active = YES;
    [self.convertButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.4].active = YES;
    [self.convertButton.heightAnchor constraintEqualToAnchor:self.password.heightAnchor].active = YES;
    self.convertButton.layer.cornerRadius = 10;
    self.convertButton.clipsToBounds = YES;
    
    // Add gestures recognizer to Convert button
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(convertButtonTapped:)];
    [self.convertButton addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.delegate = self;
}

-(IBAction)convertButtonTapped:(UIButton *)sender {
    
    NSLog(@"Convert button tapped! Conversion direction is %d", self.direction);
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (!self.direction) {
            [self encrypttextToConvert];
            [self.convertButton setTitle:@"Decrypt" forState:UIControlStateNormal];
        } else {
            [self decryptresult ];
            [self.convertButton setTitle:@"Encrypt" forState:UIControlStateNormal];
        }
    }
    
    self.direction = !self.direction;
}

// Encryption
-(void)encrypttextToConvert {
    
    NSLog(@"Encrypting the following text: %@", self.textToConvert.text);
    
    self.dataToConvert = [self.textToConvert.text dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Data to encrypt: %@", self.dataToConvert);
    
    NSString *password = self.password.text;
    
    self.convertedData = [RNCryptor encryptData:self.dataToConvert password:password];
    
    NSLog(@"Encrypted data returned from RNCryptor: %@", self.convertedData);
    
    NSString *encryptedString = [[NSString alloc] initWithData:self.convertedData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Encrypted string: %@", encryptedString);
    
    [self updateResultTextWithString:encryptedString];
}

// Decryption
-(void)decryptresult {
    
    NSLog(@"Decrypting the following string: %@", self.textToConvert.text);
    
    self.dataToConvert = [self.textToConvert.text dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Data to decrypt: %@", self.dataToConvert);
    
    NSString *password = self.password.text;
    
    NSError *error = nil;
    
    self.convertedData = [RNCryptor decryptData:self.dataToConvert password:password error:&error];
    
    NSLog(@"Decrypted data returned from RNCryptor: %@", self.convertedData);
    
    NSString *decryptedString = [[NSString alloc] initWithData:self.convertedData encoding:NSUTF8StringEncoding];
    
    if (error != nil) {
        NSLog(@"ERROR:%@", error);
    }
    
    NSLog(@"Decrypted string: %@", decryptedString);
    
    [self updateResultTextWithString:decryptedString];
}

-(void)updateResultTextWithString:(NSString *)result {
    self.result.text = result;
}

@end
