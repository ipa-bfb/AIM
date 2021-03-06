clc;
%% find zero of potencial function
disp('---------------------------------------------');
disp('Finding Lagragian Points...');

%% find L3
problem.objective=@(pos) lagragian(pos,Target);
x0_init=-1700;% Can be changed for another farway point
x0_end=Target.ModelData.re-Target.ModelData.Secondary.r0;
problem.x0=[x0_init(1) x0_end(1)]; %L1 position centered in ellipsoid; %initial interval
problem.solver='fzero';
problem.options = optimset('Display','iter'); %show iterationd

x3=fzero(problem);

%%FIND L2
x0_init=Target.ModelData.Secondary.r0+Target.ModelData.re;
x0_end=Target.ModelData.rs-Target.ModelData.Primary.dim;
problem.x0=[x0_init(1) x0_end(1)]; %L1 position centered in ellipsoid; %initial interval

x2=fzero(problem);

%%FIND L1
x0_init=Target.ModelData.Secondary.r0+Target.ModelData.Primary.dim;
x0_end=2000;
problem.x0=[x0_init(1) x0_end(1)]; %L1 position centered in ellipsoid; %initial interval

x1=fzero(problem);

%%FIND L4
options = optimoptions('fsolve','Algorithm','levenberg-marquardt','Display','iter','PlotFcns',@optimplotfval,'TolFun',1e-30,'TolX',1E-100);
x0=[-540;540*sind(60);0];
x4=fsolve(@(x) lagragian_y_axis(x,Target),x0',options);