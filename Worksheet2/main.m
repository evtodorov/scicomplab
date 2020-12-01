%setup
solvers = {@RungeKutta};
time_steps = [1, 0.5, 0.25, 1./8];
fp = @(t,p) (1.-p/10.)*p;
tend = 5;
p0 = 1;


for sol=1:length(solvers)
    tab = table('Size',[4,4],...
                'VariableTypes',["double" "double" "double" "double"],...
                'VariableNames',["dt" "error" "error red." "error app."]);
    figure; 
    plot(0:0.01:tend, pexact(0.01, tend),'k');
    hold on;
    i = 1;
    for dt=time_steps
        yhat = solvers{sol}(fp,p0,dt,tend);
        plot(0:dt:tend,yhat,'--');
        e = approximationError(yhat, pexact(dt,tend), dt, tend);
        tab(i,1) = {dt};
        tab(i,2) = {e};
        i = i+1;
    end
    legend(['analytical' string(time_steps)],'location','southeast');
    hold off;
    tab
end