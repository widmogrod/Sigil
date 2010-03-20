@import <Foundation/CPObject.j>

/*
	Klasa zarządzająca i wspomagająca pewne operacje
	na elementach widoku ...
		    
*/
@implementation SIElementManager : CPObject
{}

/*
	Sprawdza czy punk zawiera się w kwadraturze elementu (w polu elementu)
*/
+ (BOOL)element:(SIElement)element containsPoint:(CGPoin)point
{
	// sprawdź czy punk jest w polu obiektu
	return CGRectContainsPoint([element rect], point);
}

@end
