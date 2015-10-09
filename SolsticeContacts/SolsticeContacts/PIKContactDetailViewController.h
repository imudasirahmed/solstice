//
//  PIKContactDetailViewController.h
//  SolsticeContacts
//
//  Created by Mudasir Ahmed on 10/9/15.
//  Copyright (c) 2015 Mudasir Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PIKContact;

@interface PIKContactDetailViewController : UIViewController

@property(nonatomic,strong) PIKContact *contact;

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneHomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end
