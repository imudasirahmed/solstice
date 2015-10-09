//
//  PIKDefines.m
//  SolsticeContacts
//
//  Created by Mudasir Ahmed on 10/9/15.
//  Copyright (c) 2015 Mudasir Ahmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PIKDefines.h"

NSString *const kPIKSolsticeContactURL            = @"https://solstice.applauncher.com/external/contacts.json";
NSString *const kPIKContactDataModel              = @"PIKContact";

NSString *const kPIKContactJSONNameField          = @"name";
NSString *const kPIKContactDBSortKey              = @"name";

NSString *const kPIKContactJSONEmployeeIdField    = @"employeeId";
NSString *const kPIKContactJSONCompanyField       = @"company";
NSString *const kPIKContactJSONDetailsURLField    = @"detailsURL";
NSString *const kPIKContactJSONSmallImageURLField = @"smallImageURL";
NSString *const kPIKContactJSONHomePhoneField     = @"phone.home";
NSString *const kPIKContactJSONWorkPhoneField     = @"phone.work";
NSString *const kPIKContactJSONMobilePhoneField   = @"phone.mobile";
NSString *const kPIKContactJSONBirthdateField     = @"birthdate";

NSString *const kPIKContactTableCell              = @"ContactCell";
NSString *const kPIKContactTableCellPlaceHolder   = @"placeholder";
NSString *const kPIKContactDetailSegue            = @"ContactDetail";


NSString *const kPIKContactJSONLargeImageURLField       = @"largeImageURL";
NSString *const kPIKContactJSONEmailField               = @"email";
NSString *const kPIKContactJSONAddressStreetField       = @"address.street";
NSString *const kPIKContactJSONAddressCityField         = @"address.city";
NSString *const kPIKContactJSONAddressStateField        = @"address.state";
NSString *const kPIKContactJSONAddressCountryField      = @"address.country";
NSString *const kPIKContactJSONAddressZipField          = @"address.zip";
NSString *const kPIKContactJSONAddressLatField          = @"address.latitude";
NSString *const kPIKContactJSONAddressLonField          = @"address.longitude";

CGFloat const kPIKContactTableCellRowHeight             = 70.f;
