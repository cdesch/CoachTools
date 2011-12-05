//
//  PlayerImportFormDataSource.m
//  CoachTools
//
//  Created by Chris Desch on 12/1/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <IBAForms/IBAForms.h>
#import "PlayerImportFormDataSource.h"
#import "StringToNumberTransformer.h"
#import "FormFieldStyle.h"
#import "ShowcaseButtonStyle.h"

@implementation PlayerImportFormDataSource

- (id)initWithModel:(id)aModel {
	if (self = [super initWithModel:aModel]) {
        
        // Some basic form fields that accept text input
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"Player Form" footerTitle:nil];
        basicFieldSection.formFieldStyle =[[[FormFieldStyle alloc] init] autorelease];
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"playerNumber" title:@"Player Number"] autorelease]];

        IBAFormSection *buttonSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
		buttonSection.formFieldStyle = [[[ShowcaseButtonStyle alloc] init] autorelease];;
		[buttonSection addFormField:[[[IBAButtonFormField alloc] initWithTitle:@"Contact"
																		  icon:nil
																executionBlock:^{
																	[self displaySampleForm];
																}] autorelease]];      
        [buttonSection addFormField:[[[IBAButtonFormField alloc] initWithTitle:@"Emergancy Contact"
																		  icon:nil
																executionBlock:^{
																	[self displaySampleForm];
																}] autorelease]];  
    }
    
    return self;
}

- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath {
	[super setModelValue:value forKeyPath:keyPath];
	
	NSLog(@"%@", [self.model description]);
}

- (void)displaySampleForm {
	
    /*
    ShowcaseModel *showcaseModel = [self model];
	
	NSMutableDictionary *sampleFormModel = [[[NSMutableDictionary alloc] init] autorelease];
    
	// Values set on the model will be reflected in the form fields.
	[sampleFormModel setObject:@"A value contained in the model" forKey:@"readOnlyText"];
    
	SampleFormDataSource *sampleFormDataSource = [[[SampleFormDataSource alloc] initWithModel:sampleFormModel] autorelease];
	SampleFormController *sampleFormController = [[[SampleFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Sample Form";
	sampleFormController.shouldAutoRotate = showcaseModel.shouldAutoRotate;
	sampleFormController.tableViewStyle = showcaseModel.tableViewStyleGrouped ? UITableViewStyleGrouped : UITableViewStylePlain;
	sampleFormController
    [[IBAInputManager sharedIBAInputManager] setInputNavigationToolbarEnabled:showcaseModel.displayNavigationToolbar];
    
	UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	if (showcaseModel.modalPresentation) {
		UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
																					 target:self 
																					 action:@selector(dismissSampleForm)] autorelease];
		sampleFormController.navigationItem.rightBarButtonItem = doneButton;
		UINavigationController *formNavigationController = [[[UINavigationController alloc] initWithRootViewController:sampleFormController] autorelease];
		formNavigationController.modalPresentationStyle = showcaseModel.modalPresentationStyle;
		[rootViewController presentModalViewController:formNavigationController animated:YES];
	} else {
        if ([rootViewController isKindOfClass:[UINavigationController class]]) {
			[(UINavigationController *)rootViewController pushViewController:sampleFormController animated:YES];
		}
	}*/
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	picker.modalPresentationStyle = UIModalPresentationFormSheet;
	picker.displayedProperties = displayedItems;
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    //UINavigationController *formNavigationController = [[[UINavigationController alloc] initWithRootViewController:picker] autorelease];
    //formNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    //[rootViewController presentModalViewController:formNavigationController animated:YES];
    [(UINavigationController *)rootViewController pushViewController:picker animated:YES];
	// Show the picker 
	//[self presentModalViewController:picker animated:YES];
    [picker release];
    
}

- (void)dismissSampleForm {
	[[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissModalViewControllerAnimated:YES];
}

// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{

    [super setModelValue:(NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty) forKeyPath:@"firstName"];
    [super setModelValue:(NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty) forKeyPath:@"lastName"];
    [super setModelValue:[NSNumber numberWithInt:ABRecordGetRecordID(person)]	 forKeyPath:@"contactIdentifier"];

    //[self dismissModalViewControllerAnimated:YES];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissModalViewControllerAnimated:YES];
    
	return NO;
}

// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person 
								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return YES;
}

// Dismisses the people picker and shows the application when users tap Cancel. 
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person{
    
}


@end
