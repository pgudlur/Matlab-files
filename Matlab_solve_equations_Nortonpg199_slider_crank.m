%Purpose: Matlab code for solving system of equations
%Goal: Solve eqns in Norton pg 199 - position analysis for slider crank 
% b*cos(theta3)=a*cos(theta2)-d  and
% b*sin(theta3)=a*sin(theta2)-c
% Given a, b, c, d
% Goal: find theta2 and theta3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% written by: Pradeep Gudlur
% Date: 24-Apr-2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close all
clc

% define symbolic variables
syms theta2 theta3 
syms a b c d
syms A B C

% define equations
eqn1 = b*cos(theta3) == a*cos(theta2)-d;
eqn2 = b*sin(theta3) == a*sin(theta2)-c;


% solve equations
solution = solve([eqn1, eqn2],[theta2,theta3]);
%disp(solution.theta2)
%disp(solution.theta3)
% [r,A]=subexpr(solution.theta2)
% [r2,B]=subexpr(r,B)
% [r3,C]=subexpr(r2,C)
%subexpr(solution.theta2, B)

%sybstitue expression
K1=(a^2-b^2+c^2+d^2);
K2=-2*a*c*sin(theta2);
K3=-2*a*d*cos(theta2);
A=K1-K3;
B=2*K2;
C=K1+K3;
A=(a^2-b^2+c^2+d^2)-(-2*a*d*cos(theta2));
B=2*(-2*a*c*sin(theta2));
C=(a^2-b^2+c^2+d^2)+(-2*a*d*cos(theta2));
%r = feval(symengine,'subsex',solution.theta2,[char(K1) '=K1'],[char(K2) '=K2'],[char(K3) '=K3'],[char(A) '=A'],[char(B) '=B'],[char(C) '=C'])
% r = feval(symengine,'subsex',solution.theta2,[char(A) '=A'])
% simplify(r)
%subexpr(solution.theta2)
p = subs(solution.theta2, A, 'A')



