function p = pexact(dt, tend)
%pexact Calculate exact solution
%   Detailed explanation goes here
t = 0:dt:tend;
p = 10./(1+9*exp(-t));
end

