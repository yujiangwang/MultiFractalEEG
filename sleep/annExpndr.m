function [ann] = annExpndr(annot,onset,data,sampRate)

ann = zeros(length(data)/sampRate,1);

for k = 1:length(annot)

    ann(onset(k)) = annot(k);
    
end

for z = 1:length(ann)
   
    if ann(z) == 0
        
        ann(z) = ann(z-1);
        
    end
        
end