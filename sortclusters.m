function [reward_list, clust_num]=sortclusters(diffs,n_rewards,clusters)
%Sort the clusters according to how different they are from the mean of the
%rest and pick top 'n_rewards' clusters
    list=[diffs' [1:length(diffs')]'];
    top_clust=flipud(sortrows(list));%sort the differences in descending order
    s=size(top_clust);
    if s(1)>=n_rewards
    indices=top_clust(1:n_rewards,2);%pick top say 5, or 10 clusters
    else indices=top_clust(:,2);%if there are not many, then pick all
    end
    
    for ind=1:length(indices)
        reward_list{ind}=clusters{indices(ind)};
        clust_num(ind)=indices(ind);%recording cluster number
    end
    reward_list=clusters;
    clust_num=1:length(clusters);