@import <AppKit/CPDocument.j>

@import "Views/SIElementsWindowController.j";
@import "Views/SIOptionsWindowController.j";

@import "Sigil/SIElementText.j";

@implementation SIDocument : CPDocument
{
	CPSet _elements;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
    	_elements = [CPSet set];

    	var firstElement = [[SIElementText alloc] init];
    	[firstElement setValue:@"To jest testowa wartość1111"];
    	//[firstElement setFontFamily:]
    	//[firstElement setFontSize:]
    	[firstElement setWidth:200];
    	[firstElement setHeight:60];
    	[firstElement setPositionX:100];
    	[firstElement setPositionY:100];
    	
    	[_elements addObject:firstElement];
    	
    	var secondElement = [[SIElementText alloc] init];
    	[secondElement setValue:@"To jest testowa wartość2222"];
    	//[firstElement setFontFamily:]
    	//[firstElement setFontSize:]
    	[secondElement setWidth:200];
    	[secondElement setHeight:60];
    	[secondElement setPositionX:200];
    	[secondElement setPositionY:300];
    	[secondElement setSelected:YES];
    	
		[_elements addObject:secondElement];		
    }
    
    return self;
}

/*
	Zestaw elementów wchodzących w skład SIDocument
*/
- (CPSet)elements
{
	return _elements;
}

/*
	Zwracanie zestawu elementów, które są zaznaczone
*/
- (CPSet)selectedElements
{
	var selected = [_elements copy];
	var elements = [selected allObjects];
	for(var i=0; i < [elements count]; i++)
	{
		var element = [elements objectAtIndex:i];
		if (![element selected])
		{
			[selected removeObject:element];
		}
	}

	return selected;
}

- (void)makeWindowControllers
{
	/*
		TODO: Czy te okna w kontrolerze nie powinny być sinlegonem?
			  - okno opcji wydaje mi się że powinno być jak najbardziej,
			  - nie jestem pewien co do okna wizualizacji elementów..
	*/

	// dodaj kontroler okna wizualizacji elementów
	var elementsWindowController = [[SIElementsWindowController alloc] init];
	[self addWindowController: elementsWindowController];
	
	// dodaj kontroler okna edycji opcji zaznaczonego elementu
	var optionsWindowController = [[SIOptionsWindowController alloc] init];
	[self addWindowController: optionsWindowController];	
}

@end
