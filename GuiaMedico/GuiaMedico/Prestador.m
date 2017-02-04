//
//  Prestador.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 11/7/11.
//  Copyright (c) 2011 InHouse. All rights reserved.
//

#import "Prestador.h"
#import "Endereco.h"
#import "Especialidade.h"


@implementation Prestador
@dynamic Telefone;
@dynamic Nome;
@dynamic Codigo;
@dynamic Favorito;
@dynamic Endereco;
@dynamic Especialidades;


- (void)addEspecialidadesObject:(Especialidade *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Especialidades"] addObject:value];
    [self didChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeEspecialidadesObject:(Especialidade *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Especialidades"] removeObject:value];
    [self didChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addEspecialidades:(NSSet *)value {    
    [self willChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Especialidades"] unionSet:value];
    [self didChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeEspecialidades:(NSSet *)value {
    [self willChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Especialidades"] minusSet:value];
    [self didChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
