//
//  PIKContact.h
//  
//
//  Created by Mudasir Ahmed on 10/9/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PIKContact : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * employeeId;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * detailsURL;
@property (nonatomic, retain) NSString * smallImageURL;
@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSString * phone_work;
@property (nonatomic, retain) NSString * phone_home;
@property (nonatomic, retain) NSString * phone_mobile;

@property (nonatomic, readonly) NSString *birthdayTextToDisplay;

@end
