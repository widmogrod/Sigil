@import <Foundation/CPObject.j>

/*
		    
*/
@implementation SIOption : CPObject
{
	(unsigned int) height @accessors;

	SIElement _element;
}

- (id)initWithElement:(SIElement)anElement
{
	self = [super init];
	if (self)
	{
		[self setElement:anElement];
	}

	return self;
}

- (void)willDrawInView:(CPView)aView
{
	alert("[SIOption willDrawInView:] musi zostać zaimplementowana");
}

- (void)setElement:(SIElement)anElement
{
	_element = anElement;
}

- (SIElement)element
{
	return _element;
}

@end
