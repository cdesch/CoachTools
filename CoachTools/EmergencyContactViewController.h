//
//  EmergencyContactViewController.h
//  CoachTools
//
//  Created by Chris Desch on 12/9/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import <AddressBookUI/AddressBookUI.h>

@interface EmergencyContactViewController : UITableViewController <ABPersonViewControllerDelegate> {
    
    Person*     item;
    NSMutableArray*    itemsArray;
    
}

@property (nonatomic, retain) Person*    item;
@property (nonatomic, retain) NSMutableArray*   itemsArray;

- (id)initWithStyle:(UITableViewStyle)style player:(Person*)player;

@end
