function [ success , result_node , result_link_slot , V_sub , E_sub_slot ] = ACT_VNE( V_v , E_v , V_sub , E_sub , E_sub_slot )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    success = 0;
    resultNode=[];
    VNode_backup=V_sub;
    best=[];%recorde the best result in every generation
    bestObject=[];%recorde the best objective function in every generation
    %SubSlot :store the occupied slot of a virtual networking 


    %node map
    tabooList=ones(1,size(V_sub,2));
    CA=get_CA( E_v, V_sub , E_sub , E_sub_slot );
    [CA,pos_sub]=sort(CA,'descend');
    
    sort_V_v=V_v;
    [sort_V_v,pos_v]=sort(sort_V_v,'descend');

    bool=zeros(1,size(V_v,2));
    best=zeros(1,size(V_v,2));
    for i=1:size(V_v,2)
       for j=1:size(V_sub,2)
          if(tabooList(pos_sub(j))==1&&V_v(pos_v(i))<=V_sub(pos_sub(j)))
             best(pos_v(i))=pos_sub(j);
             bool(i)=1;
             tabooList(pos_sub(j))=0;
             break;
          end
       end
    end
    if(sum(bool)==size(V_v,2))
        success=1;
    end
    
    
    %link map
    if(success==1)
        [ success ,  V_sub  , E_sub_slot , SubSlot ] = CI_linkMap( best , V_v , E_v , V_sub , E_sub , E_sub_slot );

        result_node=VNode_backup-V_sub;
        result_link_slot=SubSlot;
    else
        V_sub=VNode_backup;
        result_link_slot=[];
        result_node=[];
    end

end

