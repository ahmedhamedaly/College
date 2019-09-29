%%Question 3%%
[notes, fsampling] = audioread('exercise notes.wav');
N = 16384;
subplot(2, 1, 1);
y = notes(1:6750);
F = fftshift(abs(fft(y, N)));
newX = -fsampling/2 : fsampling/N : fsampling/2-fsampling/N;
plot(newX, F);
subplot(2, 1, 2);
y = notes(6750:10000);
F = fftshift(abs(fft(y, N)));
newX = -fsampling/2 : fsampling/N : fsampling/2-fsampling/N;
plot(newX, F);
%FIRST:  D5         578.7Hz
%SECOND: C#5/Db5    559.9Hz