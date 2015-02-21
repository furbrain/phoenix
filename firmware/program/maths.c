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
