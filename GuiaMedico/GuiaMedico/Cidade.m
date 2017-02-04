//
//  Cidade.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright (c) 2011 InHouse. All rights reserved.
//

#import "Cidade.h"
#import "Bairro.h"


@implementation Cidade
@dynamic IBGE;
@dynamic Nome;
@dynamic UF;
@dynamic Bairros;

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


@end
