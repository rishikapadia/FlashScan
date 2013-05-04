//
//  RKCardViewController.m
//  FlashScan
//
//  Created by Rishi Kapadia on 4/24/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKCardViewController.h"

@interface RKCardViewController ()

@end

@implementation RKCardViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)listIndex:(UInt32)index
{
    _listIndex = index;
    cards = [_model getCardListAtIndex:_listIndex];
    NSLog(@"%@%u%@", @"There are ", [cards count], @" elements in this list.");
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
}

-(void)dealloc
{
    [_model release];
    [super dealloc];
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
    return [cards count];
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
    
    if ([[cards objectAtIndex:indexPath.row] _frontText] != nil)
    {
        cell.textLabel.text = [[cards objectAtIndex:indexPath.row] _frontText];
    }
    else
    {
        cell.textLabel.text = [@"Card " stringByAppendingString:[NSString stringWithFormat:@"%u", indexPath.row]];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self listIndex:_listIndex];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [toDelete release];
        toDelete = indexPath;
        [toDelete retain];
        NSString* cardNumber = [NSString stringWithFormat:@"%u", (unsigned int)((RKFlashCard*)[cards objectAtIndex:indexPath.row]).cardNumberInList];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning:" message:[[@"Are you sure you want to delete Card " stringByAppendingString:cardNumber] stringByAppendingString:@"?"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        toDelete = indexPath;
        alert.tag = 1;
        [alert show];
        [alert release];
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        //NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        //NSLog(path);
        if (buttonIndex != [alertView cancelButtonIndex])
        {
            //delete from the data source
            [_model removeCardFromListIndex:_listIndex cardIndex:toDelete.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:toDelete] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    RKNormalViewController *nvc = [[RKNormalViewController alloc] initWithNibName:@"RKNormalViewController" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [nvc loadListIndex:_listIndex];
    [nvc loadCardIndex:indexPath.row];
    [self.navigationController pushViewController:nvc animated:YES];
    [nvc release];
}

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

@end
