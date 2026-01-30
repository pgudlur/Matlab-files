% Matlab program: For 6 bar mechanism (Stephensen-I) position analysis  
% Given: all link lengths (a,b,c,d,u,v) and theta2 
% Goals for LOWER 4bar: finding theta3 and theta4 made by links 3 and 4 with ground link
% Goals for Upper 4bar: finding theta5 and theta6 made by links 5 and 6 with ground link
% Goals: Saving data to excel as CSV. Creating the animation.
%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Pradeep Gudlur
%%%%%%%%%%%%%%%%%%%%%

clear variables; close all; clc;

MER312Array=[] % for writing to excel as csv later
figure() 
hold on
%%
% Create a for loop and increment theta2 values by 0.1 radians (5 degrees)
for theta2=0:0.1:8*pi
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Define Link Lengths %   
    %d = fixed link length, a= crank's length, 
    % b = coupler's length, c = %output link's length
    %p=additional point on crank(link2); q=additional point on rocker(link4)
    %u=length of link5; v=length of link6
    %gamma2 = angle inside crank's traingle
    %gamma4 = angle inside rocker's traingle
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    d=0.11; a=0.07;
    b=0.1; c=0.09;
    p=0.15; q=0.15;
    u=0.12; v=0.16;
    gamma2 = 20*pi/180;
    gamma4 = -20*pi/180;
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%% LOWER Fourbar link %%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Vector Loop equation: R2+R3-R1-R4=0
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % theta4( angle made by link 4) obtained as follows.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    K1=d/a;
    K2=d/c;
    K3=(a^2-b^2+c^2+d^2)/(2*a*c);
    A=cos(theta2)-K1-K2*cos(theta2)+K3;
    B=-2*sin(theta2);
    C=K1-(K2+1)*cos(theta2)+K3;
    theta4 = 2*atan2([-B-sqrt(B^2-4*A*C)],(2*A));   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % theta3 (angle made by link 3) calculated below
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    K4=d/b;
    K5=(c^2-a^2-b^2-d^2)/(2*a*b);
    D=cos(theta2)-K1+K4*cos(theta2)+K5;
    E=-2*sin(theta2);
    F=K1+(K4-1)*cos(theta2)+K5;
    theta3=2*atan2([-E-sqrt(E^2-4*D*F)],(2*D));
    %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % All critical Points of sixbar mechanism - except point G %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% point_A = (xA, yA)
% point_B = (xB,yB);
% point_C = (xC,yC);
% point_D = (xD,yD);
% point_E = (xE,yE);
% point_F = (xF,yF);
    
%%% Point A is Pivot O2 %%%
xA = 0;
yA = 0;
%%% Point B %%%
xB = a*cos(theta2);
yB = a*sin(theta2);
%%% Point C %%%
% xC = a*cos(theta2) + b*cos(theta3);
% yC = a*sin(theta2) + b*sin(theta3);
xC = d + c*cos(theta4);
yC = c*sin(theta4);
%%% Point D is Pivot O4 %%%
xD = d;
yD = 0;
%%% Point E %%%
xE = p*cos(theta2+gamma2);
yE = p*sin(theta2+gamma2);
%%% Point F %%%
xF = d + q*cos(theta4+gamma4);
yF = q*sin(theta4+gamma4);

%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%% Upper Fourbar link %%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    %%%%%%%% define beta %%%%%%%%%%%%%%%%%%%%
    % beta is the angle made by Virtual Ground (d') with Actual Ground (d) %
    beta = atan2((yF-yB),(xF-xB));
    % --------------------------- %
    %%%%%%%% define alpha %%%%%%%%%%%%%%%%%%%%
    % alpha is the angle made by Virtual Ground (a') with Actual Ground (d) %
    alpha = atan2((yE-yB),(xE-xB));
    % -------------------------- %
   % theta2_dash is the Upper 4bar's crank (a') angle with Virtual Ground (d') 
    theta2_dash = alpha-beta; 
    % --------------------------- %
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Calculating a_dash and d_dash%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a_dash = sqrt((xE-xB)^2+(yE-yB)^2);
d_dash = sqrt((xF-xB)^2+(yF-yB)^2);
    %%%%%%%%%%%%%%%%%%%%%
    % theta6_dash (angle made by link5 (u) with virtual ground(d') obtained below.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    K1_dash=d_dash/a_dash;
    K2_dash=d_dash/v;
    K3_dash=(a_dash^2-u^2+v^2+d_dash^2)/(2*a_dash*v);
    A_dash=cos(theta2_dash)-K1_dash-K2_dash*cos(theta2_dash)+K3_dash;
    B_dash=-2*sin(theta2_dash);
    C_dash=K1_dash-(K2_dash+1)*cos(theta2_dash)+K3_dash;
    theta6_dash = 2*atan2([-B_dash-sqrt(B_dash^2-4*A_dash*C_dash)],(2*A_dash));   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % theta5_dash (angle made by link6 (v) with virtual ground(d') obtained below.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    K4_dash=d_dash/u;
    K5_dash=(v^2-a_dash^2-u^2-d_dash^2)/(2*a_dash*u);
    D_dash=cos(theta2_dash)-K1_dash+K4_dash*cos(theta2_dash)+K5_dash;
    E_dash=-2*sin(theta2_dash);
    F_dash=K1_dash+(K4_dash-1)*cos(theta2_dash)+K5_dash;
    theta5_dash=2*atan2([-E_dash-sqrt(E_dash^2-4*D_dash*F_dash)],(2*D_dash));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % theta5 and theta6 of links 5 and 6 with actual ground (d) %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta5 = theta5_dash + beta;
theta6 = theta6_dash + beta;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Calculating position of Point G using theta5 obtained above%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% point_G = (xG,yG);
%xG = xE + u*cos(theta5);
%yG = yE + u*sin(theta5);
xG = p*cos(theta2+gamma2) + u*cos(theta5);
yG = p*sin(theta2+gamma2) + u*sin(theta5);
%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % Plot the Links as Lines and Joints as Circles %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % plot the fixed link (Link 1)
    Link1 = plot([xA xD],[yA yD],'mo-','linewidth',2);  
    
   % plot the crank (Link2)
    Link2 = patch([xA xB xE xA],[yA yB yE yA],'co-','linewidth',2);
    
   % plot Link3 in OPEN configuration
    Link3 = plot([xB xC],[yB yC],'bo-','linewidth',2);
       
   % plot the Link4 in OPEN configuration
    Link4 = patch([xD xC xF xD],[yD yC yF yD],'yo-','linewidth',2); 
    
   % plot Link5
    Link5 = plot([xE xG],[yE yG],'ro-','linewidth',2); 
    
   % plot Link6
    Link6 = plot([xF xG],[yF yG],'go-','linewidth',2); 
    grid on
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % points for tracing crank and output link
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %pB = plot(xB,yB,'.');
    %pC = plot(xC,yC,'.');
    pE = plot(xE,yE,'.');
    pG = plot(xG,yG,'.');
    pF = plot(xF,yF,'.');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pause(0.1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    set(Link1,'Visible','off')
    set(Link2,'Visible','off')
    set(Link3,'Visible','off')
    set(Link4,'Visible','off')
    set(Link5,'Visible','off')
    set(Link6,'Visible','off')
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    caption = sprintf('theta2 = %.2f, \n theta3 = %.2f, theta4 = %.2f, \n theta5 = %.2f, theta6 = %.2f', theta2*180/pi, theta3*180/pi, theta4*180/pi, theta5*180/pi, theta6*180/pi);
    title(caption, 'FontSize', 10);
    % Setup axis for the Figure
    axis(gca, 'equal');
    %axis([-80 80 -100 100]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Writing the angles to  MER312Array
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    MER312Array=[MER312Array;[theta2*180/pi theta3*180/pi theta4*180/pi theta5*180/pi theta6*180/pi]];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Writing the array 'MER312Array' to Table 'T' %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = array2table(MER312Array);
% Writing the header for table 'T' with string name and associated variable
T.Properties.VariableNames = {'Theta2','Theta3','Theta4','Theta5','Theta6'};
% Writing the entire Table 'T' to Excel or CSV %
writetable(T,'6Bar_Position_Stephensen_I.csv')