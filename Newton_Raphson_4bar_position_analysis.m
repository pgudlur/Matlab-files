% Matlab Code: Newton-Raphson Method for FOUR BAR MECHANISM
% Knowns: a,b,c,d and theta2
% Goals: To find theta3 and theta4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Pradeep Gudlur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear variables; close all; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Link Lengths %   
%d = fixed link length, a= crank's length, 
% b = coupler's length, c = %output link's length
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Given Link Lengths and theta2
d=100; a=40;
 b=120; c=80;
theta2=40*pi/180 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial Guess for theta3 (Change this and see how it affects the answer)
theta3=0*pi/180;
% Initial Guess for theta4 (Change this and see how it affects the answer)
theta4=90*pi/180;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialize Error Terms Vector (X) used to compute NORM 
X=[0;1]; % make sure to initialize such that Norm is greater than tolerance so that it goes into While loop
% L1-Norm is used as CONVERGENCE Criteria for below while loop - sum of components of X very small (Close to zero)
while norm(X,1)>=1.0e-05 %as long as norm is greater than tolerance while loop iterates
 % Define f1 as Real part of Vector loop Equation of Four bar mechanism
    f1=a*cos(theta2)+b*cos(theta3)-c*cos(theta4)-d;
 % Define f2 as Imaginary part of Vector loop Equation of Four bar mechanism
    f2=a*sin(theta2)+b*sin(theta3)-c*sin(theta4);
 % Define B vector 
    B=[(-(f1));(-(f2))];
 % Partial Derivative Matrix (A)
    A=[(-b*sin(theta3)) (c*sin(theta4));(b*cos(theta3)) (-c*cos(theta4))];
 % Find Error Term Vector (X) by inverting A and multiplying with B
    %X=A\B;
    X=inv(A)*B;
 % New Estimate OF theta3 and theta4
    theta3=theta3+X(1,1);
    theta4=theta4+X(2,1);
 % Writing theta3 and theta4 in command window
    theta3_theta4=[theta3*180/pi theta4*180/pi]
end