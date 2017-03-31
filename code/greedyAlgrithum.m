function [ success2 , result_node2 , result_link_slot2 , V_sub2 , E_sub_slot2 ] = greedyAlgrithum(V_v,E_v,V_sub2,E_sub2,E_sub_slot2)

success2 = 0;
resultNode2=[];
VNode_backup=V_sub2;
best=[];%recorde the best result in every generation
%SubSlot :store the occupied slot of a virtual networking 

%node map
sort_V_sub2=V_sub2;
sort_V_v=V_v;
[sort_V_sub2,pos_sub]=sort(sort_V_sub2,'descend');
[sort_V_v,pos_v]=sort(sort_V_v,'descend');
best=ones(1,size(V_v,2));
for i=1:size(V_v,2)
   best(pos_v(i))= pos_sub(i);
end

%link map


success2=1;
for i=1:size(V_v,2)
    if(sort_V_v(i)>sort_V_sub2)
        success2=0; 
    end    
end

if(success2==1)
    [ success2 ,  V_sub2  , E_sub_slot2 , SubSlot2 ] = linkMap( best , V_v , E_v , V_sub2 , E_sub2 , E_sub_slot2 );

    result_node2=VNode_backup-V_sub2;
    result_link_slot2=SubSlot2;
else
    V_sub2=VNode_backup;
    result_node2=[];
    result_link_slot2=[];
end

end

