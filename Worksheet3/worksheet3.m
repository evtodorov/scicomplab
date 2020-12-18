close all;clear;clc;
%setup
solvers = {@ExplicitEuler, @heunmethod @ImplicitEuler @AdamsMoulton...
           @AMLinear1, @AMLinear2... only fp = @(p) 7*(1.-p/10.)*p; p0=20;
           };
solnames = ["Explicit Euler" "Heun" "Implicit Euler" "Adams-Moulton" ...
            "Adams-Moulton - linerisation 1" "Adams-Moulton - linerisation 2"... only fp = @(p) 7*(1.-p/10.)*p; p0=20;
            ];
time_steps = [1./32,1./16,1./8, 0.25, 0.5];
time_steps = sort(time_steps);
fp = @(p) 7*(1.-p/10.)*p;
critical_point = 10; %needed for stability check
dfpdp = @(p) 7*(1.-p/5.);

tend = 5;
p0 = 20;
tab_stability = table('Size',[length(time_steps),length(solnames)+1],...
                'VariableTypes',["double" repmat(["string"],1,length(solnames))],...
                'VariableNames', ["dt" solnames]);
%for each solver implemented
for sol=1:length(solvers)
    % setup table
    tab = table('Size',[2,length(time_steps)+1],...
                'VariableTypes',["string" repmat(["double"],1,length(time_steps))],...
                'VariableNames', ["dt" string(flip(time_steps))]);
    tab(:,1) = [ {"error"}; {"error red."};];
    %plot the analytical solution 
    figure; 
    plot(0:0.01:tend, pexact(0.01, tend),'k');
    hold on;
   
    i = 1; %count timesteps
    
    % calculate solution for dt=1/64 (needed for error reduction)
    yhat = solvers{sol}(fp,dfpdp,p0,min(time_steps)/2.,tend);
    tsolved = min(time_steps)/2*(length(yhat)-1); %maximum time for which solution is available
    e = approximationError(yhat, pexact(min(time_steps)/2,tsolved), min(time_steps)/2, tsolved);
    
    for dt=time_steps
        yhat = solvers{sol}(fp,dfpdp,p0,dt,tend); %solve ODE
        if dt==min(time_steps) %to calculate the approximate error
            pkbest = yhat;
        end
        plot(0:dt:tend,yhat,'--'); %plot for this timestep
        
        
        %fill table for this timestep
        eold = e;
        e = approximationError(yhat, pexact(dt,tsolved), dt, tsolved);
        tab(1, end-i+1) = {e};
        tab(2, end-i+1) = {e/eold};
        % (temporary) - Length of solution
        tsolved = dt*(length(yhat)-1); %maximum time for which solution is available
        %tab(3, end-i+1) = {tsolved};
        % Check for stability (simple criterion):
        % Stable if local error of the current timestep (based on the 
        % critical point) decreases in the last 1 second of simulation
        stability = "";
        if tsolved==tend
            loce_lastsec = abs(yhat(end-ceil(1/dt):end) - 10);
            if all(diff(loce_lastsec) <= 0)
                stability = "X";
            end
            %tab(4, end-i+1) = {stability};
        end
        tab_stability(end-i+1, 1) = {dt};
        tab_stability(end-i+1, sol+1) = {stability};
        
        i = i+1; %increment time step
    end
    
    %make the plot pretty
    title(solnames(sol))
    xlabel("t"); ylabel("p");
    legend(['analytical', string(time_steps)],'location','southeast');
    ylim([0 p0]);
    xlim([0 tend]);
    hold off;
    
    %print the table
    solnames(sol)
    tab
end
tab_stability