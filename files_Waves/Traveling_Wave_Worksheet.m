
%--------------------------------------
%%% Nicholas Dubicki
%%% NJIT 
%%% Viscous Burgers Equation
%--------------------------------------

% Boundary Conditions
B_left  = 1;
B_right = 0.5;

% Initial Condition
% This is the appropriate Initial condition to produce the
% Traveling Wave solution
f = @(x) B_left - (B_left-B_right).*heaviside(x-0.1);

% Physical Parameters
D     = 0.2;  % Viscosity (Diffusion coefficient)
gamma = 10;   % Enhance propagation speed

% Sim Params
N  = 100;       % Grid size (resolution)
dt = 0.0001;    % Time step (small enough to satisfy CFL)

% Derived sim parameters
dx  = 1/N;
a   = D*dt/(dx^2);
g   = gamma*dt/2/dx;


%------------------------------------------
% Initialize Solution
%------------------------------------------

x = linspace(0,1,N+1);
P = 600; %Timesteps

u = zeros( N+1, P+1 ); %init

u(  :, 1) = f(x);    %init conditon
u(  1, 1) = B_left;  %left boundary
u(end, 1) = B_right; %right boundary

figure(1)
    plot(x,u(:,1),'--.b')
    xlim([0,1])
    ylim([B_right/2,B_left])
    drawnow;
    title('initial condition')
    ylabel('u(x,0)')
    xlabel('x')

%---------------------------------------------
% Compute time evolution.
%---------------------------------------------

for p = 1:P
   
    %Compute boundaries
    u(  1,p+1) = B_left;
    u(end,p+1) = B_right;
    
    %compute interior points
    for n = 2:N
        
        u(n,p+1) = u(n,p) + ...
                   a*( u(n+1,p) -2*u(n,p) + u(n-1,p) ) -...
                   g*( u(n+1,p)^2 - u(n-1,p)^2  );
        
    end

%==========================================
% Uncomment this section to see animation
%==========================================
if mod(p,4) == 0
    figure(2)
    plot(x,u(:,p+1),'--.b')
    xlim([0,1])
    ylim([B_right/2,B_left*1.1])
    grid on
    xlabel('x')
    ylabel('u(x,t)')
    title(['t = ',num2str(p*dt,2)])
    drawnow;
end
    
    
end

%
% Visualize
%

%surface plot
figure(3)
t = linspace(0,dt*P,P+1);
contourf(x,t,u')
xlabel('x')
ylabel('t')
zlabel('u(x,t)')

shading interp
