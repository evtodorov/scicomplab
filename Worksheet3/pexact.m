function p = pexact(dt, tend)
%pexact Calculate exact solution

t = 0:dt:tend;
p = 10./(1+9*exp(-t));%200./(20-10*exp(-7*t));
end

