function  mapResult = roulette(probability)

p=rand();
p_accumulate=0;
mapResult=0;
% seq=find(probability~=0);

  for i=1:size(probability,2)
      p_accumulate=p_accumulate+probability(i);
      if(p_accumulate>=p)
          mapResult=i;
          break;
      end
  end
%     mapResult=i;

%     for i=1:size(seq,2)
%         p_accumulate=p_accumulate+probability(seq(i));
%         if(p_accumulate>=p)
%             mapResult=seq(i);
%             break;
%         end
%     end
%     %mapResult=i;

end

