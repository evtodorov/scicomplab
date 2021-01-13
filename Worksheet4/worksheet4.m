close all;clear;clc;
%setup
N = [3, 7, 15, 31, 63, 127];

tab_full = table('Size',[2,length(N)-1],...
                'VariableTypes',["string" repmat(["double"],1,length(N)-2)],...
                'VariableNames', ["Nx,Ny" string(N(2:end-1))]);
tab_full(:,1) = [ {"runtime"}; {"storage"};];
tab_sparse = tab_full;
tab_GS = tab_full;

tab_err = table('Size',[2,length(N)],...
                'VariableTypes',["string" repmat(["double"],1,length(N)-1)],...
                'VariableNames', ["Nx,Ny" string(N(2:end))]);
tab_err(:,1) = [ {"error"}; {"error red."};];
for i=1:length(N)
    n=N(i);
    %mesh
    [X,Y]=meshgrid(linspace(0,1,n+2),linspace(0,1,n+2));
    A_sparse = HeatEquation(n,n);
    A_full = full(A_sparse);
    c = -2*pi*pi*sin(pi*reshape(X,[],1)).*sin(pi*reshape(Y,[],1));
    tic;
    T = A_full\c;
    t_full = toc;
    figure;
    surf(X,Y,reshape(T,n+2,n+2));
    figure;
    contour(X,Y,reshape(T,n+2,n+2));
    tic;
    %TODO: T_sparse = A_sparse\c;
    t_sparse = toc;
    tic;
    %T_GS = GaussSiderlSolver(N,N,c);
    t_GS = toc;
    if i>1 && i<6
        tab_full(1,i) = {t_full};
        tab_full(2,i) = {(n+2)^4};
        tab_sparse(1,i) = {t_sparse};
        tab_sparse(2,i) = {nnz(A_sparse)};
        tab_GS(1,i) = {t_GS};
        tab_GS(2,i) = {n};%???TBC???
    end
    %error = approximationError(T_GS, N, N);
    if i>1
        %tab_err(1,i-1) = {error};
        %tab_err(2,i-1) = {old_error/error};
    end
    %old_error = error;
end
tab_full
tab_sparse
tab_GS
tab_err