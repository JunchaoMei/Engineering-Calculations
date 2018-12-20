%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Internal functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x, w] = Jacobi(n,a,b)
% Generates the abscissa and weights for a Gauss-Legendre quadrature.
% Reference:  Numerical Recipes in Fortran 77, Cornell press.

%Preallocations
x = zeros(n,1); 	%output abscissae
w = zeros(n,1); 	%output weights

xp = zeros(n*(b-a)*100,1);  %subdivide interval spanned by integration limits
epsilon = 1e-6;             %criterion for finding root
index = 1;

%In lieu of an efficient root finder, do Newton's method
%from all the points on the subdivided interval and use the
%peaks of the histogram of the results to determine the roots
%This is not really necessary for low-order quadrature and very
%computationally inefficient, but it produces
%accurate results for 7th and 9th order quadrature in a simple manner.

for i=a:(b-a)/100:b
  for ii=1:n
    z = i; %initial guess
    z1 = z+1;
    while abs(z-z1)>epsilon
      p1 = sqrt(1+2*n+1)*jp(n,1,0,1-2*z);
      pp = -2*sqrt(1+2*n+1)*(1/2)*(n+1+0+1)*jp(n-1,2,1,1-2*z);
      z1 = z;
      z = z1-p1/pp;
    end
    xp(index) = z;
    index = index + 1;
  end
end
[dummy,x] = hist(xp,length(xp)*1e4);
[a,b] = sort(dummy);
dummy2 = x(b);
x = dummy2(length(dummy2)-n+1:length(dummy2));

% roots of jacobi polynomial
x = sort(x);

%Now determine the weights
dummy = zeros(1,n-1);
for j=1:length(x)
  for i=0:n-1
    dummy(i+1) = sqrt(1+2*i+1)*jp(i,1,0,1-2*x(j)); 
  end
  w(j) = 1/sum(dummy.^2);                     % Build up the weights.
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = jp (n,alpha,beta,x)
%function output = jp (n,alpha,beta,x)
%This function will return the jacobi polynomial
%From Abramowitz and Stegum page 775 in explicit expressions

s_identify = 'jacobi_poly.m';

dummy = zeros(1,n+1);
for m=0:n
  dummy(m+1) = bnml(n+alpha,m)*bnml(n+beta,n-m)* ...
      (x-1)^(n-m)*(x+1)^m;
end
output = 1/(2^n)*sum(dummy);

end

function bc = bnml(n,m)
% Returns generalized binomial coefficients, integer arguments not required
%
% Given nonnegative integers n and m with m<=n, compute the
% binomial coefficient n choose m.

num = gamma(n+1);
denom = gamma(n-m+1).*gamma(m+1);
bc = num./denom;

end
