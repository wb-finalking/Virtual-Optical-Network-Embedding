function q = get_q( E_v , V_sub , E_sub , E_sub_slot )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
    global N;
    q=zeros(1,length(V_sub));
    
    for i=1:length(V_sub)
        vector = find(E_sub(i,:)==1);
        for j=1:length(vector)
            flag=0;
            sum=0;
            qpart=0;
            for k=1:N
                if(E_sub_slot(i,vector(j),k)==1)
                   flag=flag+1; 
                else
                   q(i)=q(i)+qpart*flag;
                   flag=0;
                   sum=0;
                end
                if(flag>=min(min(E_v)))
                    sum=sum+1;
                end
                qpart=qpart+sum;
            end
        end
    end
    
    q=q/max(max(E_v));
end

