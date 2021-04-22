
#include <stdio.h>

double factorial(int n)
{
	double fact = 1;

	for (int i = 1; i <= n; ++i){
		fact *= i;
	}
	return fact;

}

int main()
{
	double N = 110;
	double euler_partial = 0;
	double fact;
	for (double i = 0; i < N; ++i)
	{
		fact = factorial(i);
		euler_partial += 1 / fact;
	}
		
	printf("%.9lf\n", euler_partial);
	return 0;
}