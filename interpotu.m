function Newotu=interpotu(day,otu)
[M ~]=size(otu);
L=length(day);
iday=day(1):day(L);
for i=1:M
    Newotu(i,:) = interp1(day,otu(i,:),iday,'pchip');
% Newotu(i,:) = interp1(day,otu(i,:),iday,'spline');
end
