function p = pexact(dt, tend)
%pexact Calculate exact solution

t = 0:dt:tend;
p = 200./(20-10*exp(-7*t));
end

