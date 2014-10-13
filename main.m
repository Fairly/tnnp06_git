clear all
close all



CL = 1000;
X0 = [];

[T,X] = ode15s(@f_IKr,[0 1000],X0);
plot(T,X)