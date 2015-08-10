function [phy,plabel]=phylumotu(otu,label)
[m n]=size(otu);
plabel=union(label(:,3),label(:,3));
for i=1:length(plabel)
    phy(i,:)=zeros(1,n);
    for j=1:m
        if strcmp(plabel{i},label(j,3))
            phy(i,:)=phy(i,:)+otu(j,:);
        end
    end
end