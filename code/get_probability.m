function probability = get_probability( nodeIndex  , req_source , V_sub , tabooList , pheromone , seqNum )

feasibility=zeros(1,size(V_sub,2));
for i=1:size(V_sub,2)
    if req_source<=V_sub(i)
        feasibility(i)=1;
    end
end

for i=1:size(V_sub,2)
    feasibility(i)=feasibility(i)&tabooList(i);
end

all=sum(feasibility.*nodeIndex.*pheromone(seqNum,:));
probability = (nodeIndex.*feasibility.*pheromone(seqNum,:))/all;

end

