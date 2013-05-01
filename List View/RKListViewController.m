//
//  RKListViewController.m
//  FlashScan
//
//  Created by Rishi Kapadia on 4/23/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKListViewController.h"

@interface RKListViewController ()

@end

@implementation RKListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }
    return self;
}

-(void) dealloc
{
    [_model release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _model = [RKModel sharedModel];
    [_model retain];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
        initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    [lpgr release];
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
    return [[_model lists] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    //cell.textLabel.text = [[[_model lists] objectAtIndex: indexPath.row] name];
    cell.textLabel.text = [_model getListName:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //cell.detailTextLabel.text = [[[_model lists] objectAtIndex: indexPath.row] name];
    //[self.tableView insertRowsAtIndexPaths:[_model lists] withRowAnimation:UITableViewRowAnimationFade];
    //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle) tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(indexPath);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [toDelete release];
        toDelete = indexPath;
        [toDelete retain];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning:" message:[[@"Are you sure you want to delete " stringByAppendingString:[_model getListName:indexPath.row]] stringByAppendingString:@"?"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        alert.tag = 1;
        [alert show];
        [alert release];
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
//        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        if (buttonIndex != [alertView cancelButtonIndex])
        {
            //delete from the data source
            [_model removeListAtIndex:toDelete.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:toDelete] withRowAnimation:UITableViewRowAnimationFade];
            
        }
    }
    else if (alertView.tag == 2)
    {
        if (buttonIndex == 0)
            return;
        else if (buttonIndex == 1)
        {
            NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
            //change list's name
            [_model changeNameOfListAtIndex:listIndexToChange toName:[[alertView textFieldAtIndex:0] text]];
            [self.tableView reloadData];
        }
    }
}


- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint p = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
        
        if (indexPath == nil)
        {
            NSLog(@"long press on table view but not on a row");
        }
        else
        {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if (cell.isHighlighted)
            {
                NSLog(@"long press on table view at section %d row %d", indexPath.section, indexPath.row);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Change List Name:" message:[@"Enter the new name of: " stringByAppendingString:[_model getListName:indexPath.row]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Change", nil];
                alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                UITextField * alertTextField = [alert textFieldAtIndex:0];
                alertTextField.keyboardType = UIKeyboardTypeDefault;
                alertTextField.placeholder = @"Enter new name";
                alert.tag = 2;
                listIndexToChange = indexPath.row;
                [alert show];
                [alert release];
            }
        }
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

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [toDelete release];
    toDelete = indexPath;
    [toDelete retain];
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [toDelete release];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    RKListSelectViewController *lsvc = [[RKListSelectViewController alloc] initWithNibName:@"RKListSelectViewController" bundle:nil];
    [lsvc listIndex:indexPath.row];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:lsvc animated:YES];
    [lsvc release];
}

@end
