clear;
clc;

tend = 5;
dt = 1;

%yhat = ExplicitEuler(fy,y0,dt,tend)
%ExplicitEuler Implement Explicit Euler method
%   Detailed explanation goes here
ts = 0:dt:tend;
yo = 1;
yhat = zeros(1,length(ts));
yhat(1) = yo;
% for i=2:tend
%     ydot = (1 - yhat(i-1)/10)*yhat(i-1);
%     yhat(i) = yhat(i-1)+ dt*ydot;
% end
% plot(ts,yhat);
% hold on;





% %%%heun solution
% for i=2:tend
%     ydot = (1 - yhat(i-1)./10)*yhat(i-1);
%     yhat(i) = yhat(i-1)+ dt*ydot;
%     ynextdot = (1 - yhat(i)./10)*yhat(i);
%     yhat(i) = yhat(i-1)+ dt*(ydot+ynextdot)/2;
% end
% plot(ts,yhat);
% hold on;


%runge kutta solution
for i=2:tend
    y1dot = (1 - yhat(i-1)./10)*yhat(i-1);
    yhat(i) = yhat(i-1)+ dt/2*y1dot;
    y2dot = (1 - yhat(i)./10)*yhat(i);
    yhat(i) = yhat(i-1)+ dt/2*y2dot;
    y3dot = (1 - yhat(i)./10)*yhat(i);
    yhat(i) = yhat(i-1)+ dt*y3dot;
    y4dot = (1 - yhat(i)./10)*yhat(i);
    yhat(i) = yhat(i-1)+ dt*(y1dot+2*y2dot+2*y3dot+y4dot)/6;
end
plot(ts,yhat);
hold on;



%%exact solution
pExact = 10./(1+9.*exp(-ts));
plot(ts,pExact);
hold on;