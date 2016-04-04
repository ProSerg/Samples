#include <stdio.h>
#include "functions.h"

int toFact(int number) {
	if (number <= 1 )
		return 1;
	return number *toFact(number - 1); 
}
