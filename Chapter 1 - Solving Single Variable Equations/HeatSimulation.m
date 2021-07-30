function U=heat_simulation(heat_source_center, heat_source_temp,heat_source_cutoff_time,simulation_end_time,measurement_position,show_animation)
%function heat_simulation(heat_source_center, heat_source_temp,simulation_end_time,measurement_position,show_animation)
%simulate a solution to 
%u_t=u_xx+u_yy+f(x,t)
%-u_x(0,y,t)=1/4*(u(0,y,t)-10)
% u_x(1,y,t)=1/4*(u(1,y,t)-10)
%-u_y(x,0,t)=1/4*(u(x,0,t)-10)
% u_y(x,1,t)=1/4*(u(x,1,t)-10)
% u(x,y,0)=0
% using a forward in time, centered in space, finite difference method. 
%The heating term is a circular indicator function with radius 0.1 centered
%at heat_source_center and with magnitude heat_source_temp. The heat source
%is "on" from time 0 til time heat_source_cutoff_time.
%INPUT-
%heat_source_center -- a vector containing the center of the heat source.
%heat_source_temp   -- a scalar containing the temperature of the heat
%source.
%heat_source_cutoff_time -- a scalar indicating the time at which the heat
%source cuts off. 
%simulation_end_time -- The ending time of the simulation. Default is 2.
%measurement_position -- A vector containing the position at which the temperature of the plate
%should be returned. Default position is [0.5,0.5]. 
%show_animation -- a scalar.  Nonzero indicates that an animation of the
%solution should be shown.  0 indicates that no such animation should be
%shown. Default value is 1. 
% Time runs until
%simulation_end_time, an animation is displayed if show_animation is set t
%OUPUT--
%
%u -- the measured temperature at postion measurement_position at time
%simulation_end_time. 

if ~exist('show_animation','var') || isempty(show_animation)
    show_animation=1;
end

if ~exist('measurement_position','var') || isempty(measurement_position)
    measurement_position=[0.5,0.5];
end

if ~exist('simulation_end_time','var') || isempty(simulation_end_time)
    simulation_end_time=3;
end

Ns=15; %number of nodes in each space direction. 
r=0.1; %critical ratio
TT=simulation_end_time; %end simulation time. 
H=0.02; %Heat transfer coefficient
HH=.1; %Other transfer coefficient. 
V=-5; %exterior tempreature. 

hs=1/(Ns-1); %space step
ht=hs^2*r; %desired time step
Nt=ceil(TT/ht+1); %number of time nodes
ht=TT/Nt; %Actual time step. 

x=linspace(0,1,Ns); %x nodes
y=linspace(0,1,Ns); %y nodes
t=linspace(0,TT,Nt); %t nodes

f=@(x,y,t) heat_source_temp*((x-heat_source_center(1))^2+(y-heat_source_center(2))^2<0.1^2)*(t<heat_source_cutoff_time);

u(:,:,1)=V*ones(Ns,Ns);
for k=2:Nt
    for i=2:Ns-1
        for j=2:Ns-1
            u(i,j,k)=u(i,j,k-1)+ht*HH*((u(i+1,j,k-1)-2*u(i,j,k-1)+u(i-1,j,k-1))/hs^2+(u(i,j+1,k-1)-2*u(i,j,k-1)+u(i,j-1,k-1))/hs^2+f(x(i),y(j),t(k)));
        end
    end
    for i=2:Ns
        u(1,i,k)=(u(2,i,k)+hs*H*V)/(hs*H+1);
        u(Ns,i,k)=(u(Ns-1,i,k)+hs*H*V)/(hs*H+1);
        u(i,1,k)=(u(i,2,k)+hs*H*V)/(hs*H+1);
        u(i,Ns,k)=(u(i,Ns-1,k)+hs*H*V)/(hs*H+1);
    end
   u(1,1,k)=1/2*(u(2,1,k)+u(1,2,k));
   u(1,Ns,k)=1/2*(u(1,Ns-1,k)+u(2,Ns,k));
   u(Ns,1,k)=1/2*(u(Ns-1,1,k)+u(Ns,2,k));
   u(Ns,Ns,k)=1/2*(u(Ns-1,Ns,k)+u(Ns,Ns-1,k));
end

if show_animation
   animation(x,y,t,u); 
end

%ok, lets be pedantic now -- 
%Find the 4 nodes closest to measurement_position.  
j=floor(measurement_position(1)/hs)+1;
if j>=Ns
    j=Ns;
    jp1=Ns;
elseif j<=1
    j=1;
    jp1=1;
else
    jp1=j+1;
end
if k>=Ns
    k=Ns;
    kp1=Ns;
elseif k<=1
        k=1;
        kp1=1;
else
    kp1=k+1;
end

k=floor(measurement_position(2)/hs)+1;

xw=(hs-(measurement_position(1)-x(j)))/hs;
yw=(hs-(measurement_position(2)-y(k)))/hs;
U=yw*(xw*u(j,k,end)+(1-xw)*u(jp1,k,end))+(1-yw)*(xw*u(j,kp1,end)+(1-xw)*u(jp1,kp1,end));


function animation(x,y,t,u)
    figure
    Z=zeros(length(x),length(y));
    s=surf(x,y,zeros(length(x),length(y)));
    axis([min(x),max(x),min(y),max(y),min(u(:)),max(u(:))]);
    colormap jet
    view(2)
    caxis([min(u(:)),max(u(:))]);
    colorbar
    lighting gouraud
    nframes=min(size(u,3),5000);
    for k=1:nframes
       if (k==nframes)
           idx=size(u,3);
       else
           idx=(k-1)*round(size(u,3)/nframes)+1;
       end
       try
       s.CData=u(:,:,idx);
       s.ZData=u(:,:,idx);
       pause(0.001);
       title(['t=',num2str(t(idx))]);
       catch e
           e;
       end
       
       
    end
   
    
end
end
