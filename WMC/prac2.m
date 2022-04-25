clc;
clear all;
close all;

f=1;
nop=6; 

rxsignal=[];
t=0:1/100:1; 
txsignal=cos(2*pi*f*t); 

z=1;
for t=0:1/100:1
    sum=0;
    for p=1:1:nop
        beta(p)=rand; 
        delay(p)=rand*t;
        sum=sum+beta(p)*exp(1i*2*pi*f*(t-delay(p)));
    end
    BETACOL{z}=beta;
    DELAYCOL{z}=delay;
    beta=0;
    delay=0;
    rxsignal=[rxsignal sum];
    z=z+1;
end
save CONSTANTS BETACOL DELAYCOL

figure("Name", "U19EC026 Transmitted and Received Signal");
subplot(4,1,1)
plot(txsignal)
title('Transmitted Signal');
xlabel("time")
ylabel("amplitude")

subplot(4,1,2)
plot(real(rxsignal))
title('Received Signal after Multipath');
xlabel("time")
ylabel("amplitude")

subplot(4,1,3)
plot(abs(fft(txsignal)))
title('Spectrum of the Transmitted Signal');
xlabel("sample")
ylabel("amplitude")

subplot(4,1,4)
plot(abs(fft(real(rxsignal))))
title('Spectrum of the Received Signal after Multipath');
xlabel("sample")
ylabel("amplitude")

hold
load CONSTANTS
fs=100;
u=1;
for f=0:fs/101:(50*fs)/101
    rxsignal=[];
    sum=0;
    z=1;
    for t=0:1/100:1
        sum=0;
        for p=1:1:nop
            sum=sum+BETACOL{z}(p)*exp(1i*2*pi*f*(t - DELAYCOL{z}(p)));
        end
        rxsignal = [rxsignal sum];
        z = z+1;
    end
    t = 0:1/100:1;
    tvaryingTF_freq_f{u} = rxsignal.*exp(-1i*2*pi*f*t);
    u = u+1;
end

tmp = cell2mat(tvaryingTF_freq_f');
for i = 1:1:101
    u = tmp(:,i);
    u1 = [u; transpose(u(length(u): -1:2)')];
    tvaryingIR_time_t{i} = ifft(u1);
end
    
tfmat = abs(cell2mat(tvaryingTF_freq_f'));
irmat = cell2mat(tvaryingIR_time_t);
s = [2:2:8];
    
figure("Name", "U19EC026")
for i = 1:1:4
    subplot(2,2,i)
    plot(irmat(1:1:101, s(i)));
    title(strcat('t=', num2str((s(i)-1/100))));
end

figure("Name", "U19EC026")
for i = 1:1:4
    subplot(2,2,i)
    plot(ifmat(1:1:101, s(i)));
    title(strcat('t=', num2str((s(i)-1/100))));
end
