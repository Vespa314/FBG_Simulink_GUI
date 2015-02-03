function [pos1 pos2] = Get3dBWidth(H,thred)

pos1 = 1;
pos2 = length(H);

[maxH pos] = max(H);
for i = pos:-1:1
    if(H(i)<maxH*thred)
        pos1 = i;
        break;
    end
end

for i = pos:1:length(H)
    if(H(i)<maxH*thred)
        pos2 = i;
        break;
    end
end
