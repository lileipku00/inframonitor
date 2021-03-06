function x = rgumbel(n,a,u)
%PGUMBEL  Random numbers from the Gumbel distribution
%
%         x = rgumbel(n, a, u)
%
%	  Defaults are a = 1 and m = 0. The parameter  a  is 
%	  proportional to the inverse of the standard deviation
%	  and the parameter  u  is the position.

%       GPL Copyright (c) Anders Holtsberg, 1999

if nargin < 2
   a = 1;
end
if nargin < 3
   u = 0;
end
if any(any(a<=0))
   error('Parameter a is wrong')
end
if size(n)==1
   n = [n 1];
end

x = -log(-log(rand(n)));
x = (x+u) ./ a;
