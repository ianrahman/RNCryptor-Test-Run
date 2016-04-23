//
//  ViewController.m
//  RNCryptor Test Run
//
//  Created by Ian Alexander Rahman on 4/16/16.
//  Copyright © 2016 Ian Alexander Rahman. All rights reserved.
//

#import "ViewController.h"
#import "RNCryptor/RNCryptor.h"

@interface ViewController ()

@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *plaintext;
@property (strong, nonatomic) UITextField *ciphertext;
@property (strong, nonatomic) UIButton *convertButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the placeholder text of the text fields and convert button
    self.password.text = @"Input your password here";
    self.plaintext.text = @"Input the text to be encrypted here";
    self.convertButton.titleLabel.text = @"Convert";
    
    // Add the text field views and convert button to the main view
    [self.view addSubview:self.password];
    [self.view addSubview:self.plaintext];
    [self.view addSubview:self.ciphertext];
    [self.view addSubview:self.convertButton];
    
    // Turn off taslation of autoresizing masks into constraints
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Set constraings for text fields
    [self.password.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.password.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:30].active = YES;
    [self.password.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    [self.plaintext.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.plaintext.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    [self.plaintext.topAnchor constraintEqualToAnchor:self.password.bottomAnchor constant:20].active = YES;
    [self.plaintext.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.3].active = YES;
    [self.ciphertext.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.ciphertext.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    [self.ciphertext.topAnchor constraintEqualToAnchor:self.plaintext.bottomAnchor constant:20].active = YES;
    [self.ciphertext.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.3].active = YES;
    
    // Set constraints for convert button
    [self.convertButton.topAnchor constraintEqualToAnchor:self.ciphertext.bottomAnchor constant:10].active = YES;
    [self.convertButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
}

@end
