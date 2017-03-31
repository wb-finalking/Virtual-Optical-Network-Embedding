function V_v = gererate_Gv_vertex(  )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global min_vertex;
global max_vertex;
global min_vertexResource;
global max_vertexResource;

V_v=[];
vertexNum=ceil(unifrnd(min_vertex,max_vertex));
for i=1:vertexNum
    V_v=[V_v,ceil(unifrnd(min_vertexResource,max_vertexResource))];
end

end

