#include <stdio.h>



extern int calc_div(unsigned int x, unsigned int k);

int main(int argc, char** argv)
{
  unsigned int k; unsigned int x;
   scanf("%u", &k); scanf("%u", &x);
   calc_div(k,x);
  return 0;
}
int check(int x, int k){
	if (x<0)		
		return 0;
	if(k<=0||k>31)
		return 0;
	return 1;
	}