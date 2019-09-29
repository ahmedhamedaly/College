[original_signal, sampling] = audioread('exercise2_piece.wav');
sound(original_signal,sampling);
carrier_frequency = 30000;
N = 2^19;
    %PART 1
signal = ammod(original_signal, carrier_frequency,sampling) + randn(size(original_signal)) * 0.01;
    subplot(3, 1, 1);
F = fftshift(abs(fft(signal, N)));
newX = -sampling/2 : sampling/N : sampling/2-sampling/N;
plot(newX, F);
signal = amdemod(signal, carrier_frequency, sampling);
sound(signal,sampling);
    %PART 2
frequency_deviation = 30000;
signal=fmmod(original_signal, carrier_frequency,sampling, frequency_deviation) + randn(size(original_signal)) * 0.01;
    subplot(3, 1, 2);
F = fftshift(abs(fft(signal, N)));
newX = -sampling/2 : sampling/N : sampling/2-sampling/N;
    plot(newX, F);
signal = fmdemod(signal,carrier_frequency, sampling,frequency_deviation);
sound(signal,sampling);
    %PART 3
frequency_deviation = 50000;
signal=fmmod(original_signal, carrier_frequency,sampling, frequency_deviation) + randn(size(original_signal)) * 0.01;
    subplot(3, 1, 3);
F = fftshift(abs(fft(signal, N)));
newX = -sampling/2 : sampling/N : sampling/2-sampling/N;
    plot(newX, F);
signal = fmdemod(signal,carrier_frequency, sampling,frequency_deviation);
sound(signal,sampling);