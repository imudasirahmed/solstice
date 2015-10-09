//
//  PIKContactTableViewCell.h
//  SolsticeContacts
//
//  Created by Mudasir Ahmed on 10/9/15.
//  Copyright (c) 2015 Mudasir Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PIKContact;

@interface PIKContactTableViewCell : UITableViewCell

@property(nonatomic,strong) PIKContact *contact;
@property (nonatomic, weak) IBOutlet UIImageView* iconView;
@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UILabel* phoneLabel;

@end
