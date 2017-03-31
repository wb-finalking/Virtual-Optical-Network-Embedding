function [ success3 , result_node3 , result_link_slot3 , V_sub3 , E_sub_slot3 ] = RC_SP_FF( V_v,E_v,V_sub3,E_sub3,E_sub_slot3 )
%resource capacity and shortest path based virtual optical network embedding algrithum
success3 = 0;
resultNode3=[];
VNode_backup=V_sub3;
best=[];%recorde the best result in every generation
tabooList=ones(1,size(V_sub3,2));
%SubSlot :store the occupied slot of a virtual networking 

%node map
sort_V_sub3=V_sub3;
[sort_V_sub3,pos_sub]=sort(sort_V_sub3,'descend');
degree=zeros(1,size(V_v,2));
E_v_state=zeros(size(V_v,2),size(V_v,2));
for i=1:size(V_v,2)
    for j=1:size(V_v,2)
        if(E_v(i,j)~=0)
           E_v_state(i,j)=1;
        end
    end
end
for i=1:size(V_v,2)
    degree(i)=sum(E_v_state(i,:));
end
for i=1:size(V_sub3,2)
    degree_sub(i)=sum(E_sub3(i,:));
end
[degree,pos_v]=sort(degree,'descend');

bool=zeros(1,size(V_v,2));
best=zeros(1,size(V_v,2));
for i=1:size(V_v,2)
   for j=1:size(V_sub3,2)
      if(tabooList(pos_sub(j))==1&&V_v(pos_v(i))<=V_sub3(pos_sub(j))&&degree(i)<=degree_sub(pos_sub(j)))
         best(pos_v(i))=pos_sub(j);
         bool(i)=1;
         tabooList(pos_sub(j))=0;
         break;
      end
   end
end
if(sum(bool)==size(V_v,2))
    success3=1;
end

%link map

if(success3==1)
    [ success3 ,  V_sub3  , E_sub_slot3 , SubSlot3 ] = linkMap( best , V_v , E_v , V_sub3 , E_sub3 , E_sub_slot3 );

    result_node3=VNode_backup-V_sub3;
    result_link_slot3=SubSlot3;
else
    V_sub3=VNode_backup;
    result_link_slot3=[];
    result_node3=[];
end

end

