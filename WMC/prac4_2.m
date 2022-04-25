clc;
close all;
clear all;

%rate at which delay changes%
tau0 = 0;
t0=1;
nop=4;
beta = rand(1, nop);
tauj = (rand(1, nop)*2 - 1);
comp_t0 = [];
z=1;
t1 = 1;
for f=0:0.001:1
    temp =0;
    temp1 =0;
    for p=1:1:nop
        temp1 = temp1+beta(p)*exp(-1j*2*pi*f*tau0)*exp(-1j*2*pi*f*tauj(p)*t0);
    end
    comp_t0 = [comp_t0 temp1];
end
 
figure
plot((0:(1/1000):1)*1000,abs(comp_t0));
title('Time Varying Transfer Function at TimeInstant 1us');
