%%Question 1%%
frequency = 10;
fs = 20 * frequency;

time = 2;   %time = 20 * (1/frequency);
x = 0 : 1/fs : time-1/fs; 
y = sin(2 * pi * x * frequency);
i = 1;
figure (2);
plot(x, y);
figure (1);
for N = [64, 128, 256]
    subplot(3, 1, i);
    F = fftshift(abs(fft(y, N)));
    newX = -fs/2 : fs/N : fs/2-fs/N;
    plot(newX, F); hold on;
    i = i + 1;
end