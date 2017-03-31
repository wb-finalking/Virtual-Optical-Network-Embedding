function pheromone = pheromone_update(pheromone,pheromoneAll,min_objectiveIndex,resultNode)
%resultNode 是映射结果向量
global rho;
global maxPheromone;
global minPheromone;
ln=[1:size(resultNode,2)];
col=resultNode;

for i=1:size(pheromone,1)
    for j=1:size(pheromone,2)
%         if(i==ln(itrator)&&j==col(itrator))
%             pheromone(i,j)=(1-rho)*pheromone(i,j)+pheromoneAll/min_objectiveIndex;
%             if(pheromone(i,j)>=maxPheromone)
%                 pheromone(i,j)=maxPheromone;
%             end
%             if(pheromone(i,j)<=minPheromone)
%                 pheromone(i,j)=minPheromone;
%             end
%             itrator=itrator+1;
%         else
          pheromone(i,j)=(1-rho)*pheromone(i,j);
          if(pheromone(i,j)>=maxPheromone)
              pheromone(i,j)=maxPheromone;
          end
          if(pheromone(i,j)<=minPheromone)
              pheromone(i,j)=minPheromone;
          end
    end
end

for i=1:size(ln,2)
    pheromone(ln(i),col(i))=pheromone(ln(i),col(i))+pheromoneAll/min_objectiveIndex;
    if(pheromone(ln(i),col(i))>=maxPheromone)
        pheromone(ln(i),col(i))=maxPheromone;
    end
    if(pheromone(ln(i),col(i))<=minPheromone)
        pheromone(ln(i),col(i))=minPheromone;
    end
end

end