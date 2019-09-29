[signal, sampling] = audioread('exercise1_piece.wav');
carrier_frequency = 30000;  %30khz
N = 2^17;
    subplot(3, 1, 1);
F = fftshift(abs(fft(signal, N)));
newX = -sampling/2 : sampling/N : sampling/2-sampling/N;
    plot(newX, F);
    subplot(3, 1, 2);
amplitude_modulated_signal=ammod(signal, carrier_frequency,sampling);
F = fftshift(abs(fft(amplitude_modulated_signal, N)));
newX = -sampling/2 : sampling/N : sampling/2-sampling/N;
    plot(newX, F);
    subplot(3, 1, 3);
frequency_deviation = 10000;
frequency_modulated_signal=fmmod(signal, carrier_frequency,sampling, frequency_deviation);
F = fftshift(abs(fft(frequency_modulated_signal, N)));
newX = -sampling/2 : sampling/N : sampling/2-sampling/N;
    plot(newX, F);