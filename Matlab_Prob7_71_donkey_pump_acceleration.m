% Matlab program for 4 bar position, velocity and acceleration
% Norton Example 7.71_Donkey_Pump input data used
%%%%%%%%%%%%%%%%%%%%%%%
% Written by Pradeep Gudlur
%%%%%%%%%%%%%%%%%%%%%

clear variables; close all; clc;

MER312Array=[] % for writing to excel as csv later
figure() 
hold on

% This code is for Vector Loop equation R2+R3-R1-R4=0

% Create a for loop and increment theta2 values by 0.1 radians (5 degrees)
%for theta2=0:0.1:2*pi
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Define Link Lengths %   
    %d = fixed link length, a= crank's length, 
    % b = coupler's length, c = %output link's length
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    d=79.701; a=14;
    b=80; c=51.26; % dimensions are entered in mm
    theta2 = 45*pi/180; % radians
    omega2 = 10; %rad/s
    alpha2 = 0; % rad/s^2
    j = sqrt(-1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 2 different values of theta4(output link orientation) obtained as
    % follows. Here theta41 is OPEN configuration and theta42 is for
    % CROSSED configuration.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    K1=d/a;
    K2=d/c;
    K3=(a^2-b^2+c^2+d^2)/(2*a*c);
    A=cos(theta2)-K1-K2*cos(theta2)+K3;
    B=-2*sin(theta2);
    C=K1-(K2+1)*cos(theta2)+K3;
    theta41=2*atan([-B-sqrt(B^2-4*A*C)]/(2*A));
    theta42=2*atan([-B+sqrt(B^2-4*A*C)]/(2*A));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 2 different values of theta3 (Coupler orientation) obtained below.
    % Here theta31 is for OPEN configuration and theta32 is for CROSSED
    % configuration.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    K4=d/b;
    K5=(c^2-a^2-b^2-d^2)/(2*a*b);
    D=cos(theta2)-K1+K4*cos(theta2)+K5;
    E=-2*sin(theta2);
    F=K1+(K4-1)*cos(theta2)+K5;
    theta31=2*atan([-E-sqrt(E^2-4*D*F)]/(2*D));
    theta32=2*atan([-E+sqrt(E^2-4*D*F)]/(2*D));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % Plot the Links as Lines and Joints as Circles %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % to plot the fixed link (Link 1)
    Link1 = plot([0 d],[0 0],'mo-','linewidth',2);  
    
   % to plot the crank (Link2)
    Link2 = plot([0 a*cos(theta2)],[0 a*sin(theta2)],'bo-','linewidth',2);
    
   % to plot the coupler link (Link3) in OPEN configuration use theta31
    Link3 = plot([a*cos(theta2) a*cos(theta2)+b*cos(theta31)],[a*sin(theta2) a*sin(theta2)+b*sin(theta31)],'co-','linewidth',2);
   % to plot coupler link in CROSSED configuration use theta32
    %Link3 = plot([a*cos(theta2) a*cos(theta2)+b*cos(theta32)],[a*sin(theta2) a*sin(theta2)+b*sin(theta32)],'co-','linewidth',2); 
    
   % to plot the output link (Link4) in OPEN configuration use theta41 
    Link4 = plot([d d+c*cos(theta41)],[0 c*sin(theta41)],'go-','linewidth',2); 
   % to plot a output link in CROSSED configuration use theta42
    %Link4 = plot([d d+c*cos(theta42)],[0 c*sin(theta42)],'go-','linewidth',2); 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % points for tracing crank and output link
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    p1 = plot(a*cos(theta2),a*sin(theta2),'.');
    p2 = plot(a*cos(theta2)+b*cos(theta31),a*sin(theta2)+b*sin(theta31),'.');
    %p2 = plot(a*cos(theta2)+b*cos(theta32),a*sin(theta2)+b*sin(theta32),'.');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pause(0.5)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     set(Link1,'Visible','off')
%     set(Link2,'Visible','off')
%     set(Link3,'Visible','off')
%     set(Link4,'Visible','off')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% position vectors %%%%%%%%%
    R1 = d
    R2 = a*exp(j*theta2)
    R3 = b*exp(j*theta31)
    R4 = c*exp(j*theta41)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% velocity vectors %%%%%%%%%
    omega3 = a*omega2*sin(theta41-theta2)/(b*sin(theta31-theta41))
    omega4 = a*omega2*sin(theta2-theta31)/(c*sin(theta41-theta31))
    velocity_pointA = j*omega2*a*exp(j*theta2);
    velocity_BA = j*omega3*b*exp(j*theta31);
    velocity_B = j*omega4*c*exp(j*theta41);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% Acceleration vectors %%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Aprime = c*sin(theta41)
    Bprime = b*sin(theta31)
    Cprime = a*alpha2*sin(theta2) + a*(omega2^2)*cos(theta2) + b*(omega3^2)*cos(theta31) - c*(omega4^2)*cos(theta41)
    Dprime = c*cos(theta41)
    Eprime = b*cos(theta31)
    Fprime = a*alpha2*cos(theta2) - a*(omega2^2)*sin(theta2) - b*(omega3^2)*sin(theta31) + c*(omega4^2)*sin(theta41)
    alpha3 = (Cprime*Dprime-Aprime*Fprime)/(Aprime*Eprime-Bprime*Dprime)
    alpha4 = (Cprime*Eprime-Bprime*Fprime)/(Aprime*Eprime-Bprime*Dprime)
    Acceleration_pointA = a*alpha2*j*exp(j*theta2)-(a*(omega2^2)*exp(j*theta2))
    Acceleration_BA = b*alpha3*j*exp(j*theta31)-(b*(omega3^2)*exp(j*theta31))
    Acceleration_pointB = c*alpha4*j*exp(j*theta41)-(c*(omega4^2)*exp(j*theta41))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    caption = sprintf('theta2 = %.2f, \n theta31 = %.2f, theta41 = %.2f, \n theta32 = %.2f, theta42 = %.2f \n omega2 = %.2f, omega3 = %.2f, omega4 = %.2f \n alpha2 = %.2f, alpha3 = %.2f, alpha4 = %.2f', theta2*180/pi, theta31*180/pi, theta41*180/pi, theta32*180/pi, theta42*180/pi, omega2, omega3, omega4, alpha2, alpha3, alpha4);
    title(caption, 'FontSize', 10);
    % Setup axis for the Figure
    axis(gca, 'equal');
    %axis([-80 80 -100 100]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Writing the angles to  MER312Array
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    MER312Array=[MER312Array;[theta2*180/pi theta31*180/pi theta41*180/pi theta32*180/pi theta42*180/pi omega2 omega3 omega4 velocity_pointA velocity_BA velocity_B alpha2 alpha3 alpha4 Acceleration_pointA Acceleration_BA Acceleration_pointB]];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Writing the array 'MER312Array' to Table 'T' %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = array2table(MER312Array);
% Writing the header for table 'T' with string name and associated variable
T.Properties.VariableNames = {'Theta2','Theta31','Theta41','Theta32','Theta42', 'omega2', 'omega3', 'omega4', 'velocity_pointA', 'velocity_BA', 'velocity_B', 'alpha2', 'alpha3', 'alpha4', 'Acceleration_pointA', 'Acceleration_BA', 'Acceleration_pointB'};
% Writing the entire Table 'T' to Excel or CSV %
writetable(T,'4Bar_Position_Vel_Acc.csv')