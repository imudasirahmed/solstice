//
//  PIKContactListViewController.m
//  SolsticeContacts
//
//  Created by Mudasir Ahmed on 10/9/15.
//  Copyright (c) 2015 Mudasir Ahmed. All rights reserved.
//

#import "PIKModel.h"
#import "PIKContact.h"
#import "PIKDefines.h"
#import "PIKContactTableViewCell.h"
#import "PIKContactListViewController.h"
#import "PIKContactDetailViewController.h"

@interface PIKContactListViewController ()
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation PIKContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Make N/W Call
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL * url = [[NSURL alloc] initWithString:kPIKSolsticeContactURL];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    __weak PIKContactListViewController*weakSelf = self;
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        PIKContact *contact;
        
        NSDictionary *dictionary;
        NSString *name;
        NSNumber *employeeId;
        NSString *company;
        NSDate *birthdate;
        NSString *detailsURL;
        NSString *phone_home;
        NSString *phone_work;
        NSString *phone_mobile;
        NSString *smallImageURL;
        NSString *epochTime;
        
        NSMutableArray *employeeIds = [NSMutableArray array];
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSArray *nonMutableContacts = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        for (int i=0; i < nonMutableContacts.count; i++) {
            dictionary = nonMutableContacts[i];
            employeeId = dictionary[kPIKContactJSONEmployeeIdField];
            [employeeIds addObject:employeeId];
        }
        
        // existing contacts
        NSMutableDictionary *existingEntities = [[PIKModel sharedInstance] getExistingContactsWithUIDs:employeeIds];
        NSManagedObjectContext *context = [PIKModel sharedInstance].managedObjectContext;
        
        
        for (int i=0; i < nonMutableContacts.count; i++) {
            dictionary = nonMutableContacts[i];
            employeeId = dictionary[kPIKContactJSONEmployeeIdField];
            contact = existingEntities[employeeId];
            
            if (contact) {
                continue;
            }
            else {
                contact = [NSEntityDescription insertNewObjectForEntityForName:kPIKContactDataModel inManagedObjectContext:context];
                contact.employeeId = employeeId;
                existingEntities[employeeId] = contact;
            }
            
            name = dictionary[kPIKContactJSONNameField];
            employeeId = dictionary[kPIKContactJSONEmployeeIdField];
            company = dictionary[kPIKContactJSONCompanyField];
            detailsURL = dictionary[kPIKContactJSONDetailsURLField];
            smallImageURL = dictionary[kPIKContactJSONSmallImageURLField];
            phone_home = [dictionary valueForKeyPath:kPIKContactJSONHomePhoneField];
            phone_work = [dictionary valueForKeyPath:kPIKContactJSONWorkPhoneField];
            phone_mobile = [dictionary valueForKeyPath:kPIKContactJSONMobilePhoneField];
            
            epochTime = [dictionary valueForKeyPath:kPIKContactJSONBirthdateField];
            NSTimeInterval seconds = [epochTime doubleValue];
            NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
            birthdate = epochNSDate;
            
            // update managed object
            contact.name = name;
            contact.employeeId = employeeId;
            contact.company = company;
            contact.detailsURL = detailsURL;
            contact.smallImageURL = smallImageURL;
            contact.phone_home = phone_home;
            contact.phone_mobile = phone_mobile;
            contact.phone_work = phone_work;
            contact.birthdate = birthdate;
        }
        
        // Save to Db
        [[PIKModel sharedInstance] saveChanges];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
    
    [task resume];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kPIKContactTableCell];
    PIKContact *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    PIKContactTableViewCell *contactTableCell = (PIKContactTableViewCell *)cell;
    contactTableCell.contact = contact;
    contactTableCell.iconView.image = [UIImage imageNamed:kPIKContactTableCellPlaceHolder];
    contactTableCell.backgroundColor = [UIColor grayColor];
    
    return cell;
}

#pragma mark Segues

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:kPIKContactDetailSegue]) {

        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        PIKContact *contact = [self.fetchedResultsController objectAtIndexPath:selectedIndexPath];
        
        PIKContactDetailViewController *contactDetailViewController = segue.destinationViewController;
        contactDetailViewController.contact = contact;
    }
}



#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kPIKContactTableCellRowHeight;
}

#pragma mark Fetched Results Controller to keep track of the Core Data BRDBirthday managed objects

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSManagedObjectContext *context = [PIKModel sharedInstance].managedObjectContext;
        NSEntityDescription *entity = [NSEntityDescription entityForName:kPIKContactDataModel inManagedObjectContext:context];
        fetchRequest.entity = entity;

        // sort
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kPIKContactDBSortKey ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        fetchRequest.sortDescriptors = sortDescriptors;
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        self.fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        if (![self.fetchedResultsController performFetch:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _fetchedResultsController;
}

#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
}

@end
