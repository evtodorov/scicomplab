close all;clear;clc;
%setup
N = [3, 7, 15, 31];
dts = 1/64./(2.^[0:6]);
tabe = {cell(4,7) cell(4,7) cell(4,7) cell(4,7)};
tabi = {cell(4,1) cell(4,1) cell(4,1) cell(4,1)};
storeplots=true; %set to true to store plots. Takes forever and a day.

%% Solve
for i=1:length(N)
    n=N(i); 
    for j=1:length(dts)
        dt = dts(j);
        t=0;
        Te = ones(n*n,1); Ti=Te; %initial condition
        while t<=1/2
            Te = ExplicitEulerHeat(n, n, dt, Te);
            if dt==1/64
                Ti = ImplicitEulerHeat(n, n, dt, Ti);
            end
            % store solutions
            if  t==1/8 || t==2/8 || t==3/8 || t==4/8
                 tabe{t*8}{i,j} = Te;
                 if dt==1/64
                     tabi{t*8}{i,1} = Ti;
                 end
            end
            t = t+dt;
        end 
    end
end

%% Plot and save
for t=[1,2,3,4]
    figure;
    for i=1:length(N)
        n = N(i);
        %mesh
        [X,Y]=meshgrid(linspace(0,1,n+2),linspace(0,1,n+2));
        x = reshape(X(2:end-1,2:end-1),[],1);
        y = reshape(Y(2:end-1,2:end-1),[],1);
        T_plot = zeros(n+2);
        for j=1:length(dts)
            s = subplot(length(N),length(dts),(i-1)*length(dts)+j);
            T_plot(2:end-1,2:end-1) = reshape(tabe{t}{i,j},[n,n]);
            surf(X,Y,reshape(T_plot,n+2,n+2));
            name = ['N=' num2str(n) '_dt=' num2str(dts(j))];
            subtitle(name);
            colorbar;
            zlim([0 1]);
            if storeplots
                myAxes=findobj(s,'Type','Axes');
                exportgraphics(s,['plots/EE_t=' num2str(t/8)  name '.jpg']);
            end
        end
    end
    sgtitle(['Explicit Euler t=' num2str(t) '/8']);
end
for t=[1,2,3,4]
    figure;
    for i=1:length(N)
        n = N(i);
        %mesh
        [X,Y]=meshgrid(linspace(0,1,n+2),linspace(0,1,n+2));
        x = reshape(X(2:end-1,2:end-1),[],1);
        y = reshape(Y(2:end-1,2:end-1),[],1);
        T_plot = zeros(n+2);
        subplot(length(N),1,i);
        T_plot(2:end-1,2:end-1) = reshape(tabi{t}{i,1},[n,n]);
        surf(X,Y,reshape(T_plot,n+2,n+2));
        subtitle(['N=' num2str(n) ' dt=' num2str(dts(1))]);
        colorbar;
        zlim([0 1]);
    end
    sgtitle(['Implicit Euler t=' num2str(t) '/8']);
end