function V_result2resource = nodeTrans( result_node , V_v , V_sub )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

V_result2resource=zeros(1,size(V_sub,2));

for i=1:size(result_node,2)
    V_result2resource(result_node(i))=V_v(i);
end
end

