clc;
clear all;
close all;

f=1;
nop=4; 

tauj = [0.62 1.84 0.86 0.37];
beta = [0.23 0.17 0.23 0.44];
dpj = [];
for k = 1:nop
  dpj(k) = abs(-f + tauj(k));
end

t=0:1/100:100; 
txsignal=cos(2*pi*f*t); 

rxsignal = [];
tvtransf = [];

for t= 0:1/100:100
    sum = 0; 
    sum1 = 0;
    for n = 1:1:nop
        sum = sum + beta(n)*cos(2*pi*dpj(n)*t);
        sum1 = sum1 + beta(n)*exp(-1i*2*pi*f*tauj(n)*t);
    end
    rxsignal = [rxsignal sum];
    tvtransf = [tvtransf sum1];
end

figure(1)
subplot(2,2,1)
plot(txsignal)
axis([0 1000 -2 2]);
xlabel('Time');
xlabel('Amplitude');
title('Transmitted signal');

subplot(2,2,2)
plot(rxsignal);
axis([0 1000 -2 2]);
xlabel('Time');
xlabel('Amplitude');
title('Received signal');

f = (0:1:length(rxsignal)-1)/100;
subplot(2,2,3)
plot(f, abs(fft(txsignal)));
axis([0 2 0 2000]);
ylabel('Samples');
xlabel('Frequency in MHz');
title('Spectrum of Transmitted signal');

subplot(2,2,4)
plot(f, abs(fft(rxsignal)));
axis([0 2 0 2000]);
ylabel('Samples');
xlabel('Frequency in MHz');
title('Spectrum of Received signal');

subplot(2,2,3)
plot(f, abs(fft(txsignal)));
axis([0 2 0 2000]);
ylabel('Samples');
xlabel('Frequency in MHz');
title('Spectrum of Transmitted signal');

figure(2)
subplot(2,1,1)
plot(abs(tvtransf));
axis([0 1000 0 2]);
ylabel('Magnitude');
xlabel('Samples in Time Domain');
title('Time-Varying Transfer Function (Magnitude)');

subplot(2,1,2)
plot(phase(tvtransf));
axis([0 1000 -25 2]);
ylabel('Phase');
xlabel('Samples in Time Domain');
title('Time-Varying Transfer Function (Phase)');





