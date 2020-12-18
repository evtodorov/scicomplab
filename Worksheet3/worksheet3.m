clear;clc;
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
dfpdp = @(p) 7*(1.-p/5.);

tend = 5;
p0 = 20;

%for each solver implemented
for sol=1:length(solvers)
    % setup table
    tab = table('Size',[4,length(time_steps)+1],...
                'VariableTypes',["string" repmat(["double"],1,length(time_steps))],...
                'VariableNames', ["dt" string(flip(time_steps))]);
    tab(:,1) = [ {"error"}; {"error red."}; {"tmax"}; {"stable"}];
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
        
        % (to-be-confirmed) - Stability - only for overdamped phenomena
        %   count if the derivative of yhat changes sign more than once
        %stability = numel(find(diff(sign(diff(yhat))))) <= 1;
        %stabilityvec=zeros(tend);
%         %for i=2:tend-1
%             %if  sign(yhat(i))~= sign(yhat(i-1))&& yhat(i)-yhat(i-1)>1 
%             stabilityvec(i)=1;
%             end
%         end
%             if sum(stabilityvec)>=4
%                stability= 0;
%             else 
%                 stability=1;
%             end
%       
%         tab(4, end-i+1) = {stability};
        
        % (temporary) - Length of solution
        tsolved = dt*(length(yhat)-1); %maximum time for which solution is available
        tab(3, end-i+1) = {tsolved};
        
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