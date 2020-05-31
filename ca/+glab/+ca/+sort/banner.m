function [] = banner(msg)
%BANNER Summary of this function goes here
%   Detailed explanation goes here

%%
n = bannerSize();

line = repmat('-', 1, n);
msgLen = length(msg);
r = n - msgLen;
if mod(r, 2) == 0
    lpad = repmat('-', 1, r / 2);
    rpad = lpad;
else
    lpad = repmat('-', 1, floor(r / 2));
    rpad = [lpad '-'];
end
disp(line);
disp([lpad msg rpad]);
disp(line);

end


function val = bannerSize()
sz = matlab.desktop.commandwindow.size;
val = sz(1);

end