function [ success , resultNode ]= map( V_v  , V_sub , E_sub , E_sub_slot , pheromone )
    success=1;
    tabooList=ones(1,size(V_sub,2));
    resultNode=zeros(1,size(V_v,2));
    for i=1:size(V_v,2)
       nodeIndex=get_nodeIndex( V_sub , E_sub , E_sub_slot );
       probability = get_probability( nodeIndex , V_v(i) , V_sub ,tabooList , pheromone , i );
       %ÂÖÅÌ¶Ä
       resultNode(i)=roulette(probability);
       if(resultNode(i)==0)
          success=0;
          break;
       end
       tabooList(resultNode(i))=0;
    end

end

