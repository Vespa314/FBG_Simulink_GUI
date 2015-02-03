%±ßÄ£ÒÖÖÆ±È
function SR = SMSR(H)
GlobalMinIdx = GetGlobalMin(H)';
GlobalMaxValve = zeros(1,length(GlobalMinIdx)-1);
for i = 1 : length(GlobalMinIdx)-1
    GlobalMaxValve(i) = max(H(GlobalMinIdx(i):GlobalMinIdx(i+1)));
end

SecMax = max(GlobalMaxValve(GlobalMaxValve~=max(GlobalMaxValve)));
if(isempty(SecMax))
    SR = max(H)-min(H);
else
    SR = max(H)-SecMax;
end

function idx = GetGlobalMin(H)
H2 = [H(1) H H(end)];
t1 = H2(2:end-1)<=H2(1:end-2);
t2 = H2(2:end-1)<=H2(3:end);
t = t1.*t2;
idx = find(t>0);
