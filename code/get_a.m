function a = get_a( V_sub , E_sub , E_sub_slot )
global N;

a=zeros(1,length(V_sub));
for i=1:size(V_sub,2)
   vector = find(E_sub(i,:)==1);
   CN=0;
   for j=1:size(vector,2)-1
       for k=j+1:size(vector,2)
           for m=1:N
               CN=CN+E_sub_slot(i,vector(j),m)&E_sub_slot(i,vector(k),m);
               CN=CN+(1-E_sub_slot(i,vector(j),m))&(1-E_sub_slot(i,vector(k),m));
           end
       end
   end
   a(i)=CN/(size(vector,2)*(size(vector,2)+1)/2);
end

end