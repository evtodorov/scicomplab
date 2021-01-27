function T1 = ExplicitEulerHeat(Nx,Ny, dt, T0)
%ExplicitEulerHeat Solve the heat equation with Explicit Euler timestep
%Input:
%   grid sizes Nx, Ny
%   time step δt,
%   Temperature at the current time T0
%Output:
%   Temperature at the next time T1

A_sparse = HeatEquation(Nx,Ny);

T1 = T0 + dt*A_sparse*T0;

end

