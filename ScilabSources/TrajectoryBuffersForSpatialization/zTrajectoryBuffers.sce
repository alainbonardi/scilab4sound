//Square trajectory buffers
//2 arrays to store x and y values in time//
sx = zeros(1, 512);
sy = zeros(1, 512);
delta = 2/128;
//1st part
j = 0;
for i=1:128
	sx(1, i+j) = -1 + delta * i;
	sy(1, i+j) = 1;
end
//2nd part
j = 128;
for i=1:128
	sx(1, i+j) = 1 - delta * i;
	sy(1, i+j) = 1 - delta * i;
end
//3rd part
j = 256;
for i=1:128
	sx(1, i+j) = -1 + delta * i;
	sy(1, i+j) = -1;
end
//4th part
j = 384;
for i=1:128
	sx(1, i+j) = 1 - delta * i;
	sy(1, i+j) = -1 + delta * i;
end
//saving the arrays as wav files
fs = 48000;
b = 16;
myFilePath = uiputfile("*.wav");
wavwrite(sx, fs, b, myFilePath);
myFilePath = uiputfile("*.wav");
wavwrite(sy, fs, b, myFilePath);
