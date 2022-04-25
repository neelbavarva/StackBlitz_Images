% U19EC026
clc;
clear all;
close all;
img=imread('cameraman.tif');
maxM = 6;
QAMstr = 'QAM (M = %d)';
PSKstr = 'PSK (M = %d)';
figure(1);
subplot(maxM/3,3,1);
imshow(img);
title('Original');
figure(2);
subplot(maxM/3,3,1);
imshow(img);
title('Original');
for m  = 2:maxM
   ModOrd = 2^m;
   SymSize = log2(ModOrd);
   AddZero = rem(length(img),SymSize);
   if AddZero ~= 0;
       img = [img; zeros(SymSize - AddZero, prod(size(img))/length (img))];
   end
   img_bin = de2bi(img);
   img_rsp = reshape(img_bin, 8*length(img_bin)/SymSize, SymSize);
   img_dec = bi2de(img_rsp);
   nQAM = qammod(img_dec, ModOrd);
   nPSK = pskmod(double(img_dec), ModOrd);
   zQAM = qamdemod(nQAM, ModOrd);
   zPSK = pskdemod(nPSK, ModOrd);
   QAM_dec = de2bi(zQAM);
   QAM_rsp = reshape(QAM_dec, size(img_bin));
   QAMM = bi2de(QAM_rsp);
   QAMM = uint8(reshape(QAMM,size(img)));
   PSK_dec = uint8(de2bi(zPSK));
   PSK_rsp = reshape(PSK_dec, size(img_bin));
   PSKK = bi2de(PSK_rsp);
   PSKK = uint8(reshape(PSKK,size(img)));
   scatterplot(nQAM);
   scatterplot(zQAM);
   scatterplot(nPSK);
   scatterplot(zPSK);
   figure(1);
   subplot(maxM/3,3,m);
   imshow(QAMM);
   title(sprintf(QAMstr,ModOrd));
   figure(2);
   subplot(maxM/3,3,m);
   imshow(PSKK);
   title(sprintf(PSKstr,ModOrd));
   hold on;
end

