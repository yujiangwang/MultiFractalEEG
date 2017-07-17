function [ll] = llength(signal,sampRate,tWindow)

segmentSize = sampRate*tWindow;
siz = floor(length(signal)/segmentSize)*segmentSize;
signal = signal(1,1:siz);
signal = reshape(signal,tWindow*sampRate,[]);
ll = zeros(length(signal),1);

for i=1:length(signal)
    
   sig = signal(:,i);
   summation = 0;
   
   for k=2:length(sig)
          summation = summation + abs(sig(k-1) - sig(k));
   end
   
   ll(i,1) = summation;
   
end

end