#ifndef MATHS_H
#define MATHS_H

/* return AxB in C, where A B and C are all pointers to double[3] */
void cross_product(double *a, double *b, double *c);

/* returns vector A multiplied by Matrix B in vector C, where A and B are pointers to double[3]
 * and B is a pointer to double[16] */
void apply_matrix(double *a, double *b, double *c);
#endif