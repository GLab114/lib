function s = toc(t)
%TOC Summary of this function goes here
%   Detailed explanation goes here

sec = t;
min = 0;
hr = 0;
day = 0;
if sec >= 60
    min = floor(sec / 60);
    sec = sec - 60 * min;
end
if min >= 60
    hr = floor(min / 60);
    min = min - 60 * hr;
end
if hr >= 24
    day = floor(hr / 24);
    hr = hr - day * 24;
end

s = [num2str(sec) 's'];
if day > 0
    s = [num2str(day) 'd ' num2str(hr) 'h ' num2str(min) 'm ' s];
elseif hr > 0
    s = [num2str(hr) 'h ' num2str(min) 'm ' s];
elseif min > 0
    s = [num2str(min) 'm ' s];
end
end

