//
//  PIKContactDetailViewController.m
//  SolsticeContacts
//
//  Created by Mudasir Ahmed on 10/9/15.
//  Copyright (c) 2015 Mudasir Ahmed. All rights reserved.
//

#import "PIKContactDetailViewController.h"
#import "PIKContact.h"
#import "PIKDefines.h"

@implementation PIKContactDetailViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL * url = [[NSURL alloc] initWithString:self.contact.detailsURL];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSString *largeImageURLStr;
        NSString *email;
        
        NSString *street;
        NSString *city;
        NSString *state;
        NSString *zip;
        NSNumber *lat;
        NSNumber *lon;
        
        largeImageURLStr = responseDictionary[kPIKContactJSONLargeImageURLField];
        NSURL *largeImageURL = [NSURL URLWithString:largeImageURLStr];
        email = responseDictionary[kPIKContactJSONEmailField];
        street = [responseDictionary valueForKeyPath:kPIKContactJSONAddressStreetField];
        city = [responseDictionary valueForKeyPath:kPIKContactJSONAddressCityField];
        state = [responseDictionary valueForKeyPath:kPIKContactJSONAddressStateField];
        zip = [responseDictionary valueForKeyPath:kPIKContactJSONAddressZipField];
        lat = [responseDictionary valueForKeyPath:kPIKContactJSONAddressLatField];
        lon = [responseDictionary valueForKeyPath:kPIKContactJSONAddressLonField];
        
        NSString *address = [NSString stringWithFormat:@"%@\r%@ %@ %@", street, city, state, zip];

        __weak PIKContactDetailViewController*weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf updateContactImage:largeImageURL email:email address:address];
        });
    }];
    
    [task resume];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = self.contact.name;
    
    self.nameLabel.text = self.contact.name;
    self.companyLabel.text = self.companyLabel.text;
    self.phoneHomeLabel.text = self.contact.phone_home;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, yyyy"];
    NSString *birthdate = [dateFormatter stringFromDate:self.contact.birthdate];

    self.birthDateLabel.text = birthdate;
}

-(void) updateContactImage:(NSURL *) imageURL email:(NSString *)email address:(NSString *) address{
    self.emailLabel.text = email;
    self.addressLabel.text = address;
    [self downloadContactPhotoWithURL:imageURL];
}

-(void) downloadContactPhotoWithURL: (NSURL *) url {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photoView.image = image;
        });
    }];
    
    [task resume];
}


@end
