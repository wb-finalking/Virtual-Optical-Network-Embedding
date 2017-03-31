function RCL = get_RCL( path , bandwidth_v , t1 , t2 , E_v , E_sub , E_sub_slot )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
    
    global N;
    
    E_sub_slot_backup=E_sub_slot;
    bool=0;
    CIF=0;
    CIN=0;
    for j=1:N-bandwidth_v+1
       %judge slot
       bool=1;
       for k=1:size(path,2)-1
           if(sum(E_sub_slot(path(k),path(k+1),j:j+bandwidth_v-1))~=bandwidth_v) 
              bool=0;
           end
       end
       if(bool==1)
           break;
       end
    end
    
    if(bool==1)
    %erase occupied slot and link
       for m=1:size(path,2)-1
           for n=j:j+bandwidth_v-1
               E_sub_slot(path(m),path(m+1),n)=0;
               E_sub_slot(path(m+1),path(m),n)=0;
           end
       end
       
       for i=1:length(path)-1
          CIF=CIF+get_CI( path(i) , path(i+1) , E_sub_slot_backup );
          CIN=CIN+get_CI( path(i) , path(i+1) , E_sub_slot );
       end
       
       RCL=(CIF-CIN)/CIF;
       
    else
        RCL=1;
    end

end

