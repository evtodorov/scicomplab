function x = Newton(G,dGdx,x0,thres)
%NEWTON Method calculates the roots of the input function using interation
% G is a function handle of the equation to solve 
% dGdx is a function handle of the derivitive of G
% x0 is the initial guess
%thres is the desired accuracy for the output
iterations=50;
%If the solution doesn't converge return nan
x=nan;
for i = 1:iterations
  % Computes the next x value using Newton's method
  xi = x0 - G(x0)/dGdx(x0);
  if abs(xi)==Inf || isnan(xi)
      break
  end
  if abs(xi - x0) <= thres    
  % Stop when the previous result and the current result have a difference
  % equal to the threshold
    x=xi;
    break                      
  end
  
  x0 = xi;                    
end

end

