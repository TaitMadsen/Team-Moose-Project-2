//
//  SeminarTableViewController.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/11/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "SeminarTableViewController.h"
#import "SeminarStore.h"
#import "SeminarTableViewCell.h"
#import "Seminar.h"
#import "EditSeminarViewController.h"

@implementation SeminarTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        // The navigation bar
        UINavigationItem *n = [self navigationItem];
        [n setTitle:@"Logs"];
        
        [n setLeftBarButtonItem:[self editButtonItem]];
        
        // The add button
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewSeminar)];
        [n setRightBarButtonItem:bbi];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register the cell nib
    UINib *nib = [UINib nibWithNibName:@"SeminarTableViewCell" bundle:nil];
    
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"SeminarTableViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[SeminarStore seminarStore] allSeminars] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeminarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeminarTableViewCell" forIndexPath:indexPath];
    Seminar *thisSeminar = [[[SeminarStore seminarStore] allSeminars] objectAtIndex:[indexPath row]];
    
    // Configure the cell...
    
    [[cell titleLabel] setText:[thisSeminar whatAbout]];
    [[cell foodLabel] setText:[thisSeminar availableFood]];
    [[cell locationLabel] setText:[thisSeminar location]];
    [[cell timeLabel] setText:[thisSeminar dateAsStringWithStyle:NSDateFormatterShortStyle]];
    
    return cell;
}

- (void) createNewSeminar
{
    EditSeminarViewController *newSeminarController = [[EditSeminarViewController alloc] initAsNew];
    [newSeminarController setSaveBlock:^{
        [[self tableView] reloadData];
    }];
    
    [self presentViewController:newSeminarController animated:YES completion:nil];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the approriate Seminar object from the store
    Seminar *thisSeminar = [[[SeminarStore seminarStore] allSeminars] objectAtIndex:indexPath.row];
    
    // Initialize the editor view with that Seminar
    EditSeminarViewController *editViewController = [[EditSeminarViewController alloc] initAsEditOfSeminar:thisSeminar];
    [editViewController setSaveBlock:^{
        [[self tableView] reloadData];
    }];
    
    [self presentViewController:editViewController animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[SeminarStore seminarStore] deleteSeminarAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
