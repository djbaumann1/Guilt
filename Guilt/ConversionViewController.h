//
//  ConversionViewController.h
//  Guilt
//
//  Created by John Andrews on 10/29/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *valueQuestionLabel;

@property (weak, nonatomic) IBOutlet UITextField *userEnterDollarAmountTextField;

- (IBAction)scannerButton:(id)sender;

- (IBAction)conversionButton:(id)sender;

@end