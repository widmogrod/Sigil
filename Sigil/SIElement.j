@import <Foundation/CPObject.j>

@implementation SIElement : CPObject
{
	// wartość elementu
	CPString value @accessors;
	
	// wysokość i szerokość
	(unsigned int) width @accessors;
	(unsigned int) height @accessors;

	// położenie (x,y)
	(unsigned int) positionX @accessors;
	(unsigned int) positionY @accessors;
}

- (id)init
{
	self = [super init];
	
	if (self)
	{
	}

	return self;
}

@end
