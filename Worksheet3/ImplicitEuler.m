function yhat = ImplicitEuler(fy,dfydy,y0,dt,tend)
%ImplicitEuler Implement Implicit Euler method
thres = 1e-4;
ts = 0:dt:tend;
yhat = zeros(1,length(ts));
yhat(1) = y0;
divergent = 0;
for i=2:length(ts)
    yn = yhat(i-1);
    
    %set up the equation for the Impicit method
    G = @(ynext) yn + dt*fy(ynext) - ynext;
    %set up the derivative along y
    dGdy = @(ynext) dt*dfydy(ynext) - 1;
    %Solve for ynext using the Newton method
    ynext = Newton(G, dGdy, yn, thres); 
    
    %Break the loop if Newton method diverges
    if abs(ynext)==Inf
        divergent = 1;
        break
    end
    yhat(i) = ynext;
end
%Trim the output so it only includes values where Netwon method converges
yhat = yhat(1:i-divergent);

end