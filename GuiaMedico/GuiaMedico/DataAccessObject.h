//
//  DataAccessObject.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataAccessObject : NSObject {
    
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


// Singleton instance
+(id) sharedInstance;
// Return a NSFetchedResultsController for a table view's data
- (NSFetchedResultsController *)fetchedResultsControllerForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate keyName:(NSString*) keyName;
// Return a NSArray with entity's objects
- (NSArray *)fetchManagedObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate;
// Return the name of application's directory
- (NSString *)applicationDocumentsDirectory;
// Return TRUE if database existis
- (BOOL)databaseExists;
-(void) createDataBase;
-(NSString*) returnFilePath:(NSString*) fileName type:(NSString*) type;
-(NSArray*) returnLines:(NSString*) fileName type:(NSString*) type;
-(void) insertCidade:(NSString*) fileName type:(NSString*) type;
-(void) updateDataBase;
@end
