% Code Purpose: Matlab code for 4 bar mechanism position analysis  
% Vector Loop Equation: R2+R3-R1-R4=0
% Given: theta2, a, b, c, d
% Goal-1: find theta3 and theta4 made by links 3 and 4 with ground link
% Goal-2: Save data to excel as CSV
% Goal-3: Create the animation
%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Pradeep Gudlur
% Date: 22-Apr-2020
%%%%%%%%%%%%%%%%%%%%%
clear variables; close all; clc;

MER312Array=[] % for writing to excel as csv later
figure() 
hold on
%%
% Create a for loop and increment theta2 values by 0.1 radians (5 degrees)
%for theta2=0:0.1:2*pi
%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Define Link Lengths %   
    %d = fixed link length, a= crank's length, 
    % b = coupler's length, c = %output link's length
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    d=2.4; a=0.8;
    b=1.23; c=1.55; % dimensions are entered in mm
    theta2 = 49*pi/180; % radians
    j = sqrt(-1);    
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 2 different values of theta4(output link orientation) obtained below. 
    %theta41= OPEN configuration and theta42= CROSSED configuration.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    K1=d/a;
    K2=d/c;
    K3=(a^2-b^2+c^2+d^2)/(2*a*c);
    A=cos(theta2)-K1-K2*cos(theta2)+K3;
    B=-2*sin(theta2);
    C=K1-(K2+1)*cos(theta2)+K3;
    theta41=2*atan([-B-sqrt(B^2-4*A*C)]/(2*A));
    theta42=2*atan([-B+sqrt(B^2-4*A*C)]/(2*A));   
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 2 different values of theta3 (Coupler orientation) obtained below.
    % theta31= OPEN configuration and theta32= CROSSED configuration.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    K4=d/b;
    K5=(c^2-a^2-b^2-d^2)/(2*a*b);
    D=cos(theta2)-K1+K4*cos(theta2)+K5;
    E=-2*sin(theta2);
    F=K1+(K4-1)*cos(theta2)+K5;
    theta31=2*atan([-E-sqrt(E^2-4*D*F)]/(2*D));
    theta32=2*atan([-E+sqrt(E^2-4*D*F)]/(2*D));  
    %% define points
    %Point_O2=[X_O2,Y_O2]
    X_O2 = 0;
    Y_O2 = 0;
    %Point_O4=[X_O4,Y_O4]
    X_O4 = d;
    Y_O4= 0;
    %Point_A=[X_A,Y_A] --- Note point A is on crank
    X_A = a*cos(theta2);
    Y_A= a*sin(theta2);
    %Point_B1=[X_B,Y_B] --- Note point B1 is on coupler
    X_B1_open = a*cos(theta2)+b*cos(theta31);
    Y_B1_open= a*sin(theta2)+b*sin(theta31);
    X_B1_cross = a*cos(theta2)+b*cos(theta32);
    Y_B1_cross= a*sin(theta2)+b*sin(theta32);
    %Point_B2=[X_B2,Y_B2] --- Note point B2 is on output link
    X_B2_open = d+c*cos(theta41);
    Y_B2_open= c*sin(theta41);   
    X_B2_cross= d+c*cos(theta42);
    Y_B2_cross= c*sin(theta42);  
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % Plot the Links as Lines and Joints as Circles %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % plot the fixed link (Link 1)
    Link1 = plot([X_O2 X_O4],[Y_O2 Y_O4],'mo-','linewidth',2);  
    
   % plot the crank (Link2)
    Link2 = plot([X_O2 X_A],[Y_O2 Y_A],'bo-','linewidth',2);
   %%%%%%%%%%%%%%%%% 
   % plot coupler link (Link3) in OPEN configuration -- use theta31
   Link3 = plot([X_A X_B1_open],[Y_A Y_B1_open],'co-','linewidth',2);
   % plot coupler link in CROSSED configuration -- use theta32
    %Link3 = plot([X_A X_B1_cross],[Y_A Y_B1_cross],'co-','linewidth',2); 
   %%%%%%%%%%%%%%%%%% 
   % plot output link (Link4) in OPEN configuration -- use theta41 
    Link4 = plot([X_O4 X_B2_open],[Y_O4 Y_B2_open],'go-','linewidth',2);
   % plot output link in CROSSED configuration -- use theta42
     %Link4 = plot([X_O4 X_B2_cross],[Y_O4 Y_B2_cross],'go-','linewidth',2);
%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % points for tracing crank and output link
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    p1 = plot(X_A,Y_A,'.');
    p2 = plot(X_B1_open,Y_B1_open,'.');
    %p2 = plot(X_B1_cross,aY_B1_cross,'.');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pause(0.5)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     set(Link1,'Visible','off')
%     set(Link2,'Visible','off')
%     set(Link3,'Visible','off')
%     set(Link4,'Visible','off')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% position vectors %%%%%%%%%
      R1 = d;
      R2 = a*exp(j*theta2);
      R3 = b*exp(j*theta31);
      R4 = c*exp(j*theta41)
  %%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Setup caption, title and axis for Figure
    caption = sprintf('theta2 = %.2f, \n theta31 = %.2f, theta41 = %.2f, \n theta32 = %.2f, theta42 = %.2f', theta2*180/pi, theta31*180/pi, theta41*180/pi, theta32*180/pi, theta42*180/pi);
    title(caption, 'FontSize', 10);
    % Setup axis for the Figure
     axis(gca, 'equal');
    %axis([-80 150 -100 100]);
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Write the angles to an Array
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    MER312Array=[MER312Array;[theta2*180/pi theta31*180/pi theta41*180/pi theta32*180/pi theta42*180/pi]];
%end    
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write the array to Table 'T'%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = array2table(MER312Array);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write the entire Table 'T' to Excel or CSV %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Writing the header for table 'T' with string name and associated variable
T.Properties.VariableNames = {'Theta2','Theta31','Theta41','Theta32','Theta42'};
% Writing the entire Table 'T' to Excel or CSV %
writetable(T,'4Bar_Position.csv')
%%
