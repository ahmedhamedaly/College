x = -2*pi: 0.1: 2*pi;
y = cos(x);
y2 = 0.5*sin(x);
plot(x, y, 'k'); hold on;
stem(x, y2, 'r');