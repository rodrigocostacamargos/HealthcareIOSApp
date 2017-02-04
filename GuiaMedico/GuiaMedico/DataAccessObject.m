//
//  DataAccessObject.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import "DataAccessObject.h"
#import "Prestador.h"
#import "Endereco.h"
#import "Especialidade.h"
#import "Bairro.h"
#import "Cidade.h"
#include "JSON.h"

@implementation DataAccessObject

@synthesize managedObjectModel, managedObjectContext, persistentStoreCoordinator;



-(void) updateDataBase {
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.0.142:8080/WcfRestService1/Service1/Hello" ];
    
	NSURL *url = [NSURL URLWithString:urlString];
    
	// Get the contents of the URL as a string, and parse the JSON into Foundation objects.
    //NSString *jsonString2 = [NSString stringWithString:@"{\"foo\": \"bar\"}"];
	NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	NSArray *results = [jsonString JSONValue];
    
    NSDictionary *objResult = [results objectAtIndex:0];
    NSLog(@"results: %@", [objResult objectForKey:@"Nome"]);
    NSLog(@"results: %@", [objResult objectForKey:@"SobreNome"]);

    
    NSDictionary *objResult1 = [results objectAtIndex:1];
    NSLog(@"results: %@", [objResult1 objectForKey:@"Nome"]);
    NSLog(@"results: %@", [objResult1 objectForKey:@"SobreNome"]);

}


-(void) insertCidade:(NSString*) fileName type:(NSString*) type  {
    
    Cidade *cidade;
    NSEntityDescription *entityCidade = [NSEntityDescription entityForName:@"Cidade" inManagedObjectContext:self.managedObjectContext];

    NSArray *lines = [self returnLines:fileName type:type];
    NSArray *fields;
    NSString *field;

    for (NSString *line in lines) {

        cidade = [[Cidade alloc] initWithEntity:entityCidade insertIntoManagedObjectContext:self.managedObjectContext];

        fields = [line componentsSeparatedByString:@";"];

        for (int i=0; i<[fields count]; i++) {

            field = [fields objectAtIndex:i];
            
            if (i == 0) {
                // IBGE
                cidade.IBGE = [[NSNumber alloc] initWithInt:[field intValue]];
            }
            
            if (i == 1) {
                // Nome
                cidade.Nome = field;
            }

            if (i == 2) {
                // UF
                cidade.UF = field;
            }
            
        }
        
        [self.managedObjectContext save:nil];
        cidade = nil;
        [cidade release];

    }
    

}


-(void) insertBairro:(NSString*) fileName type:(NSString*) type  {
    
    Bairro *bairro;
    NSEntityDescription *entityBairro = [NSEntityDescription entityForName:@"Bairro" inManagedObjectContext:self.managedObjectContext];
    
    NSArray *lines = [self returnLines:fileName type:type];
    NSArray *fields;
    NSString *field;
    
    NSArray *arrayCidade;
    
    for (NSString *line in lines) {
        
        bairro = [[Bairro alloc] initWithEntity:entityBairro insertIntoManagedObjectContext:self.managedObjectContext];
        
        fields = [line componentsSeparatedByString:@";"];
        
        for (int i=0; i<[fields count]; i++) {
            
            field = [fields objectAtIndex:i];
            
            if (i == 0) {
                // Cidade
                arrayCidade = [self fetchManagedObjectsForEntity:@"Cidade" withPredicate:[NSPredicate predicateWithFormat:@"IBGE = %d", [field intValue]]];
                bairro.Cidade = (Cidade*) [arrayCidade objectAtIndex:0];
            }
            
            if (i == 1) {
                // Nome
                bairro.Nome = field;
            }
            
            if (i == 2) {
                // CEP
                bairro.Cep = field;
            }
            
        }
        
        [self.managedObjectContext save:nil];
        bairro = nil;
        [bairro release];

    }
    
    
}


-(void) insertEspecialidade:(NSString*) fileName type:(NSString*) type  {
    
    Especialidade *especialidade;
    NSEntityDescription *entityEspecialidade = [NSEntityDescription entityForName:@"Especialidade" inManagedObjectContext:self.managedObjectContext];
    
    NSArray *lines = [self returnLines:fileName type:type];
    NSArray *fields;
    NSString *field;
    
    for (NSString *line in lines) {
        
        especialidade = [[Especialidade alloc] initWithEntity:entityEspecialidade insertIntoManagedObjectContext:self.managedObjectContext];
        
        fields = [line componentsSeparatedByString:@";"];
        
        for (int i=0; i<[fields count]; i++) {
            
            field = [fields objectAtIndex:i];
            
            if (i == 0) {
                // Codigo
                especialidade.Codigo = [[NSNumber alloc] initWithInt:[field intValue]];
            }
            
            if (i == 1) {
                // Nome
                especialidade.Nome = field;
            }
            
            
        }
        
        [self.managedObjectContext save:nil];
        especialidade = nil;
        [especialidade release];

    }
    
    
}


-(void) insertPrestador:(NSString*) fileName type:(NSString*) type  {
    
    Prestador *prestador;
    Endereco *endereco;
    Bairro *bairro;
    NSManagedObjectID *bairroId;
    
    NSEntityDescription *entityPrestador = [NSEntityDescription entityForName:@"Prestador" inManagedObjectContext:self.managedObjectContext];

    NSEntityDescription *entityEndereco = [NSEntityDescription entityForName:@"Endereco" inManagedObjectContext:self.managedObjectContext];

    
    NSArray *lines = [self returnLines:fileName type:type];
    NSArray *fields;
    NSString *field;
    NSArray *arrayEnderecoBairro;
    NSArray *arrayEspecialidade;
    
    for (NSString *line in lines) {
        
        prestador = [[Prestador alloc] initWithEntity:entityPrestador insertIntoManagedObjectContext:self.managedObjectContext];

        endereco = [[Endereco alloc] initWithEntity:entityEndereco insertIntoManagedObjectContext:self.managedObjectContext];


        fields = [line componentsSeparatedByString:@";"];
        
        for (int i=0; i<[fields count]; i++) {
            
            field = [fields objectAtIndex:i];

            if (i == 0) {
                // Nome
                prestador.Codigo = [[NSNumber alloc] initWithInt:[field intValue]];
            }

            
            if (i == 1) {
                // Nome
                prestador.Nome = field;
            }
            
            if (i == 2) {
                // Telefone
                prestador.Telefone = field;
            }
            
            if (i == 3) {
                // Endereco - Rua
                endereco.Rua = field;
            }

            if (i == 4) {
                // Endereco - Numero
                endereco.Numero = [[NSNumber alloc] initWithInt:[field intValue]];
            }
            
            if (i == 5) {
                // Endereco - Complemento
                endereco.Complemento = field;
            }

            if (i == 6) {
                // Endereco - Lagitude
                endereco.Latitude = [[NSNumber alloc] initWithInt:[field intValue]];
            }

            if (i == 7) {
                // Endereco - Longitude
                endereco.Longitude = [[NSNumber alloc] initWithInt:[field intValue]];
            }
 
            if (i == 8) {
                // Endereco - Bairro
                arrayEnderecoBairro = [self fetchManagedObjectsForEntity:@"Bairro" withPredicate:[NSPredicate predicateWithFormat:@"Cep like %@", field]];
                
                bairro = (Bairro*) [arrayEnderecoBairro objectAtIndex:0];
                bairroId = [bairro objectID];
                endereco.Bairro = (Bairro*) [self.managedObjectContext objectWithID:bairroId];
                
            }
            
            if (i == 9) {
                // Especialidade (pode haver mais de uma)
                arrayEspecialidade = [self fetchManagedObjectsForEntity:@"Especialidade" withPredicate:[NSPredicate predicateWithFormat:@"Codigo IN %@", [field componentsSeparatedByString:@"," ]]];
                
                prestador.Especialidades = [[NSSet alloc] initWithArray:arrayEspecialidade];
 
                // Atualiza especialidades no bairro
                [bairro addEspecialidades:[[NSSet alloc] initWithArray:arrayEspecialidade]];

                // Atualiza o endereco do prestador
                prestador.Endereco = endereco;
                
                arrayEspecialidade = nil;
                [arrayEspecialidade release];
            }
            
        }
        
        [self.managedObjectContext save:nil];
        [prestador release];
        [endereco release];
        [bairro release];
        [bairroId release];
    }
    
    
}



-(NSArray*) returnLines:(NSString*) fileName type:(NSString*) type  {
    
    NSString *filePath = [self returnFilePath:fileName type:type];
    NSString *file = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [file componentsSeparatedByString:@"\n"];
    
    return lines;

}

-(NSString*) returnFilePath:(NSString*) fileName type:(NSString*) type  {

    NSString *filePath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [rootPath stringByAppendingPathComponent:[fileName stringByAppendingPathExtension:type]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    }


    return filePath;
}

-(void) createDataBase {
    
    [self insertCidade:@"CIDADE" type:@"txt"];
    [self insertBairro:@"BAIRRO" type:@"txt"];
    [self insertEspecialidade:@"ESPECIALIDADE" type:@"txt"];
    [self insertPrestador:@"PRESTADOR" type:@"txt"];

}

+(id) sharedInstance {
    
    static id instance;

    @synchronized(self) {
        
        if (instance == nil) {
            instance = [self new];
        }
    }

    return instance;
    
}


- (NSFetchedResultsController *)fetchedResultsControllerForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate keyName:(NSString*) keyName {
    
    NSFetchedResultsController *fetchedResultsController;
    
    /*
	 Set up the fetched results controller.
     */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:keyName ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
    // Add a predicate if we're filtering by user name
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:@"Root"];
	
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	return [fetchedResultsController autorelease];
}


- (NSArray *)fetchManagedObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate
{
	NSManagedObjectContext	*context = [self managedObjectContext];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
	
	NSFetchRequest	*request = [[NSFetchRequest alloc] init];
	request.entity = entity;
    
    if (predicate != nil) {
        request.predicate = predicate;
    }
	
	NSArray	*results = [context executeFetchRequest:request error:nil];
	[request release];
	
	return results;
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}

- (NSString *)databasePath
{
	return [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"temp.sqlite"];
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
	NSString	*path = [self databasePath];
    NSURL *storeUrl = [NSURL fileURLWithPath:path];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
	
    return persistentStoreCoordinator;
}

- (BOOL)databaseExists
{
	NSString	*path = [self databasePath];
    NSLog(@"database path: %@", path);
	BOOL		databaseExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
	
	return databaseExists;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    
    [super dealloc];
}


@end
