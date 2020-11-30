function yhat = RungeKutta(fy,y0,dt,tend)
%RungeKutta Implemented classic Runge-Kutta (RK4) method
%   cost per step -> 4 function evaluations
%                    +(at least) 12 FLOP

ts = 0:dt:tend;
yhat = zeros(1,length(ts));
yhat(1)=y0;
for i=2:length(ts)
    tn = ts(i-1);
    yn = yhat(i-1);
    Y1 = fy(tn,yn);
    Y2 = fy(tn+dt/2.,yn+Y1*dt/2.);
    Y3 = fy(tn+dt/2.,yn+Y2*dt/2.);
    Y4 = fy(ts(i),yn+Y3*dt/2.);
    yhat(i) = yhat(i-1) + dt*(Y1+2*Y2+2*Y3+Y4)/6.;
end

end

