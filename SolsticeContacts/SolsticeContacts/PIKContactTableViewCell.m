//
//  PIKContactTableViewCell.m
//  SolsticeContacts
//
//  Created by Mudasir Ahmed on 10/9/15.
//  Copyright (c) 2015 Mudasir Ahmed. All rights reserved.
//

#import "PIKContactTableViewCell.h"
#import "PIKContact.h"

@implementation PIKContactTableViewCell

-(void)setContact:(PIKContact *)contact {
    
    _contact = contact;
    
    self.nameLabel.text = contact.name;
    self.phoneLabel.text = contact.phone_work;
    
    NSURL *url = [[NSURL alloc] initWithString:contact.smallImageURL];
    [self downloadContactPhotoWithURL:url];
}


-(void) downloadContactPhotoWithURL: (NSURL *) url {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconView.image = image;
        });
    }];
    
    [task resume];
}


@end
