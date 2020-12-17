function yhat = AMLinear1(fy,dfydy,y0,dt,tend)
%AMLinear2 Implement a linearised Adams-Moulton method for the IVP
%          fy = @(y) 7*(1.-y/10.)*y; y0=20;
%   fy and dfydy are not used in this function and the signature is 
%   maintained for backwards compatibility with the main loop of worksheet3
ts = 0:dt:tend;
yhat = zeros(1,length(ts));
yhat(1) = y0;
divergent = 0;
for i=2:length(ts)
    yn = yhat(i-1);
    
    % The linearised method is explicit after algebraic transformation
    helper = 7*yn*dt/2;
    ynext = (yn + helper.*(2-yn/10))./(1+helper.*(1/10));

    yhat(i) = ynext;
end
%Trim the output so it only includes values where Netwon method converges
yhat = yhat(1:i-divergent);

end