//
//  PIKContact.m
//  
//
//  Created by Mudasir Ahmed on 10/9/15.
//
//

#import "PIKContact.h"


@implementation PIKContact

@dynamic name;
@dynamic employeeId;
@dynamic company;
@dynamic detailsURL;
@dynamic smallImageURL;
@dynamic birthdate;
@dynamic phone_work;
@dynamic phone_home;
@dynamic phone_mobile;

-(NSString *)birthdayTextToDisplay {
    static NSDateFormatter *dateFormatter;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM d"];
    }
    return [dateFormatter stringFromDate:self.birthdate];
}

@end
