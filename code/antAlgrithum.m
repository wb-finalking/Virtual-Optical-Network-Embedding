function [ success , result_node , result_link_slot , V_sub , E_sub_slot ] = antAlgrithum( V_v , E_v , V_sub , E_sub , E_sub_slot )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
success = 0;
resultNode=[];
VNode_backup=V_sub;
best=[];%recorde the best result in every generation
bestObject=[];%recorde the best objective function in every generation
%SubSlot :store the occupied slot of a virtual networking 
pheromone=ones(size(V_v,2),size(V_sub,2));
global rho;
rho=0.02;
pheromoneAll=10;
%node map
for G=1:5
    objectiveIndex=[];
    resultNode=[];
    for M=1:2
        %nodeIndex=get_nodeIndex();
        [successBuffer,resultBuffer]=map( V_v  , V_sub , E_sub , E_sub_slot , pheromone );
        if(successBuffer)
            resultNode=[resultNode;resultBuffer];
            objectiveIndex=[objectiveIndex;get_objectiveIndex( resultNode(end,:) , E_v  , V_sub , E_sub , E_sub_slot )];
        end
    end
    if(size(resultNode,1)~=0)
        [ min_objectiveIndex , num] = min(objectiveIndex);
        pheromone = pheromone_update(pheromone,pheromoneAll,min_objectiveIndex,resultNode(num(1),:));
        best=[best;resultNode(num(1),:)];
        bestObject=[bestObject;objectiveIndex(num(1))];
    end
end
%link map
if(size(bestObject,1)~=0)
    [ min_objectiveIndex , num] = min(bestObject);
    [ success ,  V_sub  , E_sub_slot , SubSlot ] = linkMap( best(num(1),:) , V_v , E_v , V_sub , E_sub , E_sub_slot );

    result_node=VNode_backup-V_sub;
    result_link_slot=SubSlot;
else
    result_node=[];
    result_link_slot=[];
    success=0;
end

end

