//
//  WLAppStyle.m
//  iWave2
//
//  Created by Marco Lorenz on 03.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLAppStyle.h"
#import "CommonSettings.h"

@implementation WLAppStyle

/**--------------------------------------------------------------
*@name Designing the Application
*----------------------------------------------------------------
*/
/** The mehtod to design the appearance of controls in the application.

This method is used like a css file and called on launching the application.
@see UIAppearance
*/
+(void)applyStyle{
    
    CommonSettings *settings = [CommonSettings MR_findFirst];
    
    if(!settings)
    {
        NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
        
        settings.design = [NSNumber numberWithInteger:SIDION_LIGHT];
        settings.usability = [NSNumber numberWithInt:BOTH];
        
        [managedObjectContext MR_saveToPersistentStoreAndWait];
    }
    
    int design = [settings.design intValue];
    
       
    //the Views
    //Table View
    UITableView *tableViewAppearance = [UITableView appearance];
    [tableViewAppearance setBackgroundColor:[WLColorDesign getMainBackgroundColor:design]];
    
       
    //Collection View
    UICollectionView *collectionViewController = [UICollectionView appearance];
    [collectionViewController setBackgroundColor:[WLColorDesign getMainBackgroundColor: design]];
    
    //Page Controlls
    UIPageControl *pageControllAppearance = [UIPageControl appearance];
    [pageControllAppearance setCurrentPageIndicatorTintColor:[WLColorDesign getSecondFontColor:design]];
    [pageControllAppearance setPageIndicatorTintColor:[WLColorDesign getMainBackgroundColor:design]];
    
    //Labels
    UILabel *labelAppearance = [UILabel appearance];
    [labelAppearance setFont:[WLColorDesign getFontNormal:design  withSize:14.]];
    //labelAppearance.textColor = [WLColorDesign getMainFontColor:design];
    
    //Textfields tut nicht wie es soll!!!
    //UITextField *textAppearance = [UITextField appearance];
    //[textAppearance setBackgroundColor:[UIColor greenColor]];//[WLColorDesign :design]];
    
    //TextView
    UITextView *textViewAppearance = [UITextView appearance];
    [textViewAppearance setTextColor:[WLColorDesign getMainFontColor:design]];
    
    //Buttons / label
    UIButton *buttonAppearance = [UIButton appearance];
    [buttonAppearance setTitleColor:[WLColorDesign getSecondFontColor:design ] forState:UIControlStateNormal];
    
    
    //the Navigation
    //NavBar
    UINavigationBar *navbarAppearance = [UINavigationBar appearance];
    [navbarAppearance setTintColor:[WLColorDesign getMainFontColor:design]];
    
    //BarButtonItems
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
    [barButtonItemAppearance setTintColor:[WLColorDesign getNavigationColor:design]];
    NSDictionary *bbAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,[WLColorDesign getFontNormal:design withSize:14.],UITextAttributeFont, nil];
    [barButtonItemAppearance setTitleTextAttributes:bbAttributes forState:UIControlStateNormal];
    
    //ToolBar
    UIToolbar *toolBarAppearance = [UIToolbar appearance];
    [toolBarAppearance setTintColor:[WLColorDesign getNavigationColor:design]];
    
    //TabBar
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setTintColor:[WLColorDesign getNavigationColor:design]];
    
       
}

@end
