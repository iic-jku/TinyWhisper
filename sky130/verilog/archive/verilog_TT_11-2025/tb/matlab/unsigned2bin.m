function b = unsigned2bin(d, n)
% function b = unsigned2bin(value, n)
% d     ... d to convert to binary array
% n     ... bitwidth

d = double(d(:));
len_d = length(d);

% Assign the base to convert to.
p = 2;

[~,e]=log2(max(d)); % How many digits do we need to represent the numbers?
b=rem(floor(d*pow2(1-max(n,e):0)),p);
