load 1run_test_new

for k=1:length(returnlog)%for each run, go through clusters and find the cluster order. 
    %go through each episode and assign the apt returns and no. of steps to
    %
    
    
returns_all=returnlog{k};
clusters_all=clusterlog{k};
for i=1:length(returns_all)
    l(i)=length(returns_all{i});
end
maxl=max(l);

ret_all=[];
for i=1:length(returns_all)
    for j=1:maxl
        if j>length(returns_all{i})
            ret(j)=0;
        else
            ret(j)=returns_all{i}(j);
        end
    end
    ret_all=[ret_all;ret];
end
end