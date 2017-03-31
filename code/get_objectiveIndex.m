function objectiveIndex = get_objectiveIndex( resultNode , E_v , V_sub , E_sub , E_sub_slot )
%resultNode 是映射结果向量
%objectiveIndex=总链路占有+结点影响
global N;

slot_backup=E_sub_slot;
occupiedSlot=0;
throughNode=[];
[ ln , col , value ] = find(tril(E_v));
success=[];
linkFlag=ones(size(V_sub,2),size(V_sub,2));%use to flag occupied link
for i=1:size(ln,1)
    E_sub=E_sub.*linkFlag;
    [dist,path,pred] = graphshortestpath(sparse(E_sub),resultNode(ln(i)),resultNode(col(i)),'directed',false)
    bool=0;
    %success=[];
    for j=1:N-E_v(ln(i),col(i))+1
        %judge slot
        bool=1;
        for k=1:size(path,2)-1
           if(sum(E_sub_slot(path(k),path(k+1),j:j+E_v(ln(i),col(i))-1))~=E_v(ln(i),col(i))) 
               bool=0;
           end
        end
        if(bool==1)
            break;
        end
    end
    if(bool==1)
        success=[success,bool];
        %erase occupied slot and link
        for m=1:size(path,2)-1
            for n=j:j+E_v(ln(i),col(i))-1
                E_sub_slot(path(m),path(m+1),n)=0;
                E_sub_slot(path(m+1),path(m),n)=0;
            end
        end
        
        linkFlag(path(m),path(m+1))=0;
        linkFlag(path(m+1),path(m))=0;
    end 
    occupiedSlot=occupiedSlot+dist*E_v(ln(i),col(i));
    throughNode=[throughNode getPathNode(path)];
end

if(sum(success)==size(success,2))
%objectiveIndex solving
    nodeIndex_now=get_nodeIndex( V_sub , E_sub , E_sub_slot );
    nodeIndex_before=get_nodeIndex( V_sub , E_sub , slot_backup );
    INF=1;
    for j=1:size(throughNode,2)
        INF=INF+(nodeIndex_now(throughNode(j))-nodeIndex_before(throughNode(j)))/nodeIndex_before(throughNode(j));
    end
    objectiveIndex=occupiedSlot+INF;
else
    objectiveIndex=inf;
end

end

