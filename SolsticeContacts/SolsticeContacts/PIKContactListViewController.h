//
//  PIKContactListViewController.h
//  SolsticeContacts
//
//  Created by Mudasir Ahmed on 10/9/15.
//  Copyright (c) 2015 Mudasir Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface PIKContactListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
