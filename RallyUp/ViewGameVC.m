//
//  ViewGameVC.m
//  RallyUp
//
//  Created by Gordon Kung on 2/8/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import "ViewGameVC.h"

@interface ViewGameVC ()

@end

@implementation ViewGameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LogoutBtn];
    
    self.dao = [DataAccessObject sharedManager];
    self.dao.reloadDelegate = self;
    [self.gamesTV setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.gamesTV setSeparatorColor:[UIColor lightGrayColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"loadedGames"
                                               object:nil];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    self.searchResult = [NSMutableArray arrayWithArray:self.dao.createEvent];
    [self.dao getGamesFromDatabase];
    [self.gamesTV reloadData];
    
}

-(void)reloadUI{
    [self.gamesTV reloadData];

}


-(void)LogoutBtn {
    
    UIBarButtonItem *logoutBtn = [[UIBarButtonItem alloc]init];
    logoutBtn.action = @selector(signOut);
    logoutBtn.tintColor = [UIColor whiteColor];
    logoutBtn.title = @"Logout";
    logoutBtn.target = self;
    
    self.navigationItem.leftBarButtonItem = logoutBtn;
    
}

-(void)signOut {
    
    NSLog(@"CURRENT USER BEFORE SIGN OUT: %@", [[FIRAuth auth] currentUser].email);
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    } else {
        NSLog(@"CURRENT USER AFTER SIGN OUT: %@", [[FIRAuth auth] currentUser].email);
        // navigate back
        [[self.dao gameArray] removeAllObjects];
        self.dao.isLoggingOut = YES;
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
                
    }
    
}


-(void) receiveTestNotification:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"loadedGames"]){
        NSLog (@"Successfully received the notification!");
        [self.gamesTV reloadData];
    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dao.gameArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"MyCell";
    UITableViewCell *cell = (UITableViewCell *)[self.gamesTV dequeueReusableCellWithIdentifier: cellID forIndexPath:indexPath];
    
    Event* currentEvent = [self.dao.gameArray objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = currentEvent.gameGroupName;
    cell.detailTextLabel.text = currentEvent.pickSport;
    cell.imageView.image = [UIImage imageNamed:@"Star_48X48"];
    


    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedEvent = [self.dao.gameArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier: @"DetailView" sender:self];
    
}

#pragma mark - Delete Row from Table View

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Event *thisEvent = [self.dao.gameArray objectAtIndex:indexPath.row];
        [self.dao deleteGameFromDatabase:thisEvent];
        
        [self.dao.gameArray removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailView"]) {
        
        DetailViewVC *detailViewController = segue.destinationViewController;
        detailViewController.chosenEvent = self.selectedEvent;
        
    }
    
}

@end
