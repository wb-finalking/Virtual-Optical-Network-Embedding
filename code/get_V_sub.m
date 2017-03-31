function V_sub = get_V_sub( nodeNumber )
    global max_node_resource;
    global min_node_resource;

    for i=1:nodeNumber
        V_sub(i)=ceil(unifrnd(min_node_resource,max_node_resource));
    end

end

