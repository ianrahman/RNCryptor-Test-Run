//
//  ViewController.m
//  RNCryptor Test Run
//
//  Created by Ian Alexander Rahman on 4/16/16.
//  Copyright © 2016 Ian Alexander Rahman. All rights reserved.
//

#import "ViewController.h"

@import RNCryptor;

@interface ViewController ()

@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *plaintext;
@property (strong, nonatomic) UITextField *ciphertext;
@property (strong, nonatomic) UIButton *convertButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize and set the placeholder text of the text fields and convert button
    self.password = [[UITextField alloc] init];
    self.password.text = @"Input your password here";
    self.password.backgroundColor = [UIColor redColor];
    
    self.plaintext = [[UITextField alloc] init];
    self.plaintext.text = @"Input the text to be encrypted here";
    self.plaintext.backgroundColor = [UIColor colorWithRed:0.36 green:0.80 blue:0.83 alpha:1.0];
    
    self.convertButton = [[UIButton alloc] init];
    [self.convertButton setTitle:@"Convert" forState:UIControlStateNormal];
    self.convertButton.backgroundColor = [UIColor redColor];
    
    // Add the text field views and convert button to the main view
    [self.view addSubview:self.password];
    [self.view addSubview:self.plaintext];
    [self.view addSubview:self.ciphertext];
    [self.view addSubview:self.convertButton];
    
    [self.password setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.plaintext setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.ciphertext setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.convertButton setTranslatesAutoresizingMaskIntoConstraints:NO];
 
    
    
    // Turn off taslation of autoresizing masks into constraints
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Set constraings for text fields
    [self.password.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.password.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10].active = YES;
    [self.password.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    [self.password.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.1].active = YES;
    
    [self.plaintext.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.plaintext.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    [self.plaintext.topAnchor constraintEqualToAnchor:self.password.bottomAnchor constant:10].active = YES;
    [self.plaintext.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.1].active = YES;
    
    [self.ciphertext.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.ciphertext.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    [self.ciphertext.topAnchor constraintEqualToAnchor:self.plaintext.bottomAnchor constant:10].active = YES;
    [self.ciphertext.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.1].active = YES;
    
    // Set constraints for convert button
    [self.convertButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.convertButton.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-100].active = YES;
    [self.convertButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    [self.convertButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.1].active = YES;
}

// Encryption
-(NSString *)encryptPlaintext {
    
    NSData *data = [self.plaintext.text dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *password = self.password.text;
    
    NSData *ciphertext = [RNCryptor encryptData:data password:password];
    
    NSString *ciphertextString = [[NSString alloc] initWithData:ciphertext encoding:NSUTF8StringEncoding];
    
    return ciphertextString;
}

// Decryption
-(NSString *)decryptCiphertext {
    
    NSData *ciphertext = [self.ciphertext.text dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *password = self.password.text;
    
    NSError *error = nil;
    
    NSData *plaintext = [RNCryptor decryptData:ciphertext password:password error:&error];
    
    NSString *plaintextString = [[NSString alloc] initWithData:plaintext encoding:NSUTF8StringEncoding];
    
    if (error != nil) {
        NSLog(@"ERROR:%@", error);
        return error.description;
    }
    
    return plaintextString;
}

-(void)addPasswordTextField {
    
    
}

@end
