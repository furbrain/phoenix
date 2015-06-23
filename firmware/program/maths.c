#include <math.h>
#include "maths.h"
/* return AxB in C, where A B and C are all pointers to double[3] */
void cross_product(double *a, double *b, double *c) {
	c[0] = (a[1]*b[2]) - (a[2]*b[1]);
	c[1] = (a[2]*b[0]) - (a[0]*b[2]);
	c[2] = (a[0]*b[1]) - (a[1]*b[0]);
}

/* returns vector A multiplied by Matrix B in vector C, where A and B are pointers to double[3]
 * and B is a pointer to double[16] */
void apply_matrix(double *a, double *b, double *c) {
}

void normalise(double *a) {
	double magnitude;
	magnitude = sqrt(a[0]*a[0]+a[1]*a[1]+a[2]*a[2]);
	a[0] /= magnitude;
	a[1] /= magnitude;
	a[2] /= magnitude;
	
}

int16_t find_median(int16_t array[],int16_t len) {
	int16_t swap;
	int c,d;
	for (c = 0 ; c < ( len - 1 ); c++) {
		for (d = 0 ; d < len - c - 1; d++) {
			if (array[d] > array[d+1]) {
				swap       = array[d];
				array[d]   = array[d+1];
				array[d+1] = swap;
			}
		}
	}
	return array[len/2];
}

