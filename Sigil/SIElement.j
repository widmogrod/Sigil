@import <Foundation/CPObject.j>

/*
	Powiadomienie wysyłane gdy zmienia się stan zaznaczenia elementu
*/
var SIElementDidChangeSelection = @"SIElementDidChangeSelection";

/*
	Abstrakcyjna klasa elementu dokumentu,
	ma zaimplementowane wszystkie podstawowe metody
	
	TODO: zmienne klasowe są accessorami, czy settery
		  nie powinny zostać zaimplementowane?
		  - Zysk z takiego działania była by możliwośc 
		    wysłania wiadomość do metody o ponownym narysowaniy
		    
*/
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
	
	(BOOL) _selected = NO;
}

- (id)init
{
	self = [super init];
	if (self)
	{
	}

	return self;
}

/*
	Oznacz element jako zaznaczony
*/
- (void)setSelected:(BOOL)flag
{
	_selected = !!flag;
	
	// wyslij powiadomienie że zostało zmienione zaznaczenie elementu
	[[CPNotificationCenter defaultCenter] 
			postNotificationName:SIElementDidChangeSelection
						  object:self];
}

- (BOOL)selected
{
	return _selected;
}

/*
	Metoda odpowiada za rysowanie elementu 
	w widoku dokumentu {@see SIElementsView}
*/
- (void)viewWillDrawInView:(SIElementsView)anView
{
	alert("[SIElement viewWillDrawInView:] musi zostać zaimplementowana");
}

/*
	Tworzenie wymiaru elementu (CGRect) zrozumiałego dla CP
*/
- (CGRect)rect
{
	return CGRectMake(positionX, positionY, width, height);
}

@end
