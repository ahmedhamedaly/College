size = 10^6;

for QAM = [4,16,64,256]
stream = randi([0 QAM-1], size, 1); %random stream of data
mod = qammod(stream, QAM); %modulate the data
BER = 0;
i = 1;
SNR = 0;
currentBER = 1;
while (currentBER > 10^-4)
    
    signal_noise = awgn(mod, SNR, 'measured'); %adding noise to given snr
    Dem = qamdemod(signal_noise, QAM); %demodulate the signal
    Difference = stream ~= Dem; % compare the demodulated data
    count = nnz(Difference); % count the number of errors
    currentBER = count/size; % calculate the number of errors in relation to the size
    BER(i) = currentBER; % sets the current bit error rate in an array
    i = i + 1; % next index of the BER
    SNR = SNR + 2; % increments steps of 2 dB
    
end
x = 0 : 2 : SNR - 2;
semilogy(x, BER);
hold on;
end