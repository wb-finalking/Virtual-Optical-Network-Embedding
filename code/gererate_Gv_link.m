function E_v = gererate_Gv_link( nodeNumber )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
global min_bandwidth;
global max_bandwidth;

E_v=zeros(nodeNumber,nodeNumber);
for i=1:nodeNumber-1
    for j=i+1:nodeNumber
        E_v(i,j)=floor(rand()+0.5);
    end
end
E_v=E_v+E_v';

for i=1:nodeNumber
    for j=i:nodeNumber
        if E_v(i,j)==1
            E_v(i,j)=ceil(unifrnd(min_bandwidth,max_bandwidth));
        end
    end
end

E_v=E_v+E_v';

end

