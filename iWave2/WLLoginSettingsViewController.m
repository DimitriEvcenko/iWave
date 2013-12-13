//
//  WLLoginSettingsViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 10.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLLoginSettingsViewController.h"
#import "CommonSettings.h"
#import "WLTableCellDesignCell.h"
#import "WLSettingsChoiseController.h"
#import "User.h"
#import "WLAppDelegate.h"
#import "WLTableHeaderLabel.h"


@implementation WLLoginSettingsViewController
int design;
int choise;

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing design and configuration on view did load. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    [self adaptStyle];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeDesign) name:DESIGN_NOTIFICATION object:nil];
}

/**---------------------------------------------------------------------------------------
 * @name Configuring the View
 *  ---------------------------------------------------------------------------------------
 */
/** Setting the models in this method. */
-(void)configureView{
    
    self.loginSettings = [LoginSettings MR_findFirst];
    self.commonSettings = [CommonSettings MR_findFirst];
    
}
/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** This Method handles special designed controls on view controller
 i.e. the table views backgroundcolor is changed here.
 */
-(void)adaptStyle{
        
    design = [self.commonSettings.design intValue];
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundView = [[UIView alloc]init];
    
    self.tableView.backgroundView.backgroundColor = [WLColorDesign getMainBackgroundColor:design];
}

/** On changes in common design settings this method is called.
 The method delegates the changes down the line.
 */
-(void)didChangeDesign{
    [self.tableView reloadData];
}

/**---------------------------------------------------------------------------------------
 * @name Show and Change Settings
 *  ---------------------------------------------------------------------------------------
 */
/** On pressing the remember me change cell the value in login settings is changed.
 @param sender The autoremember cell.
 */
- (void)rememberMeChanged: (UITableViewCell*)cell{
    
    self.loginSettings.rememberMe = [[NSNumber alloc] initWithBool: ![self.loginSettings.rememberMe boolValue]];
    [self setCheckCell:cell];
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
}

/** Changing the cells checkmark apending to the login settings remember me property. 
 @param cell The cell to change. */
-(void)setCheckCell: (UITableViewCell*)cell{
    
    if([self.loginSettings.rememberMe boolValue]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

#pragma mark - Table view delegate
/**---------------------------------------------------------------------------------------
 * @name Configuring the Table View
 *  ---------------------------------------------------------------------------------------
 */
/** Configures the cells in table view in a particular location.
 @param tableView The table view requesting the cell.
 @param indexPath An index path location row in tableView.
 @return An WLTableCellDesignCelll Object that is used from tableView for the specific indexPath.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WLTableCellDesignCell *cell = (WLTableCellDesignCell*)[super tableView: tableView cellForRowAtIndexPath:indexPath];
    [cell.textLabel setFont:[WLColorDesign getFontBold:design withSize:16.]];
    [cell.detailTextLabel setFont: [WLColorDesign getFontItalic:design withSize:12.]];
    
    if(indexPath.section == 0){
        
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = self.loginSettings.userId;
                break;
            case 2:
                [self setCheckCell:cell];
                break;
            case 3:{
                User *user = [User MR_findFirstByAttribute:USERID withValue:session.sessionUserId];
                
                if(user.lastLogin == nil)
                    user.lastLogin = [[NSDate alloc]init];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
                [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                [dateFormatter setLocale:[NSLocale currentLocale]];
                
                cell.detailTextLabel.text = [dateFormatter stringFromDate: user.lastLogin];
            }
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = [self.commonSettings getDesign];
                break;
            case 1:
                cell.detailTextLabel.text = [self.commonSettings getUsability];
                break;        
        }
    }
    return cell;
    
}

/** Returns the header title in table view  for a section
 @param section The section the header is returned
 @return The header title for section.
 */
-(NSString*)titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return NSLocalizedString(@"LoginSettings", @"");
        case 1:
            return NSLocalizedString(@"UsabilitySettings", @"");
        default:
            return @"";
    }
    
}

/** Creates and returns the header for section in table view.
 @param tableView The tabe view calling the data source.
 @param section The section the header view should be returned.
 @return The created header view.
 @see WLTableHeaderLabel
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    WLTableHeaderLabel *textLabel = [[WLTableHeaderLabel alloc]init];
    
    textLabel.text = [self titleForHeaderInSection:section];
    [headerView addSubview:textLabel];
    
    return headerView;
    
}

/**---------------------------------------------------------------------------------------
 * @name Managing Selections
 *  ---------------------------------------------------------------------------------------
 */
/** Dooing some action on selection a table view cell.
 @warning On adding a second selection to the table view design and usability can be changed.
 @param tableView The table view a row is selected.
 @param indexPath An index path specifies the selected row in tableView.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UIAlertView *aView = [[UIAlertView alloc]initWithTitle:@"Nicht implementiert" message:@"Diese Funktion ist noch nicht implementiert" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    choise = NOTHING;
    
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                //[aView show];
                break;
            case 1:                
                //[aView show];
                break;            
            default:
                [self rememberMeChanged: cell];
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
                choise = DESIGN;
                [self performSegueWithIdentifier:@"tableSelection" sender:self];
                break;
            case 1:
                choise = USABILITY;
                [self performSegueWithIdentifier:@"tableSelection" sender:self];
                break;            
            default:
                break;
        }
    }
    
}

/**--------------------------------------------------------
 *@name Using a Storyboard
 *---------------------------------------------------------
 */
/** On preparing to leave the view controller the destination view controller is set.
 @param segue The segue object containing information about the view controllers involved in the segue.
 @param sender The object, that initiated the segue.
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if(choise == NOTHING){
        return;
    }
    
    WLSettingsChoiseController *vc = (WLSettingsChoiseController*)[segue destinationViewController];
    
    vc.choise =  choise;
    
}


@end
