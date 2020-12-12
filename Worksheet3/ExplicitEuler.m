function yhat = ExplicitEuler(fy,y0,dt,tend)

%ExplicitEuler Implement Explicit Euler method
%   Detailed explanation goes here
ts = 0:dt:tend;
yhat = zeros(1,length(ts));
yhat(1) = y0;
for i=2:length(ts)
    yn = yhat(i-1);
    yhat(i) = yn+ dt*fy(yn);
end

end