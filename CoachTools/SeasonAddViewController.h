
#import "Team.h"

@protocol SeasonAddDelegate;
@class Season;

@interface SeasonAddViewController : UIViewController <UITextFieldDelegate> {
    @private
        Season *season;
        UITextField *nameTextField;
        id <SeasonAddDelegate> delegate;
    
        Team    *team;
}

@property (nonatomic, retain) Season *season;
@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, assign) id <SeasonAddDelegate> delegate;
@property (nonatomic, retain) Team      *team;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil teamSelected:(Team *)aTeam;

- (void)save;
- (void)cancel;
- (BOOL)validateSeason;

@end


@protocol SeasonAddDelegate <NSObject>

- (void)seasonAddViewController:(SeasonAddViewController *)seasonAddViewController didAddSeason:(Season *)aSeason;

@end
