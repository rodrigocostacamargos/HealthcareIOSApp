//
//  Especialidade.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/25/11.
//  Copyright (c) 2011 InHouse. All rights reserved.
//

#import "Especialidade.h"
#import "Bairro.h"
#import "Prestador.h"


@implementation Especialidade
@dynamic Nome;
@dynamic Codigo;
@dynamic Bairros;
@dynamic Prestadores;

- (void)addBairrosObject:(Bairro *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Bairros" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Bairros"] addObject:value];
    [self didChangeValueForKey:@"Bairros" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeBairrosObject:(Bairro *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Bairros" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Bairros"] removeObject:value];
    [self didChangeValueForKey:@"Bairros" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addBairros:(NSSet *)value {    
    [self willChangeValueForKey:@"Bairros" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Bairros"] unionSet:value];
    [self didChangeValueForKey:@"Bairros" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeBairros:(NSSet *)value {
    [self willChangeValueForKey:@"Bairros" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Bairros"] minusSet:value];
    [self didChangeValueForKey:@"Bairros" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addPrestadoresObject:(Prestador *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Prestadores" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Prestadores"] addObject:value];
    [self didChangeValueForKey:@"Prestadores" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removePrestadoresObject:(Prestador *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Prestadores" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Prestadores"] removeObject:value];
    [self didChangeValueForKey:@"Prestadores" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addPrestadores:(NSSet *)value {    
    [self willChangeValueForKey:@"Prestadores" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Prestadores"] unionSet:value];
    [self didChangeValueForKey:@"Prestadores" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removePrestadores:(NSSet *)value {
    [self willChangeValueForKey:@"Prestadores" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Prestadores"] minusSet:value];
    [self didChangeValueForKey:@"Prestadores" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
