size = 10^5;

QAM = 16;
stream = randi([0 QAM-1], size, 1); % random stream of data
mod = qammod(stream, QAM); % modulate the stream of data

SNR = 16;
signal_noise = awgn(mod, SNR, 'measured'); % adding noise
const1 = comm.ConstellationDiagram('ShowReferenceConstellation',false, 'XLimits', [-4 4], 'YLimits', [-4 4]); 
step(const1, signal_noise); 

SNR = 20;
signal_noise = awgn(mod, SNR, 'measured');
const2 = comm.ConstellationDiagram('ShowReferenceConstellation',false, 'XLimits', [-4 4], 'YLimits', [-4 4]);
step(const2, signal_noise);
