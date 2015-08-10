function norm=normotu(otu)
[m n]=size(otu);
for i=1:n
    sumday=sum(otu(:,i));
    for j=1:m
        norm(j,i)=otu(j,i)/sumday;
    end
end