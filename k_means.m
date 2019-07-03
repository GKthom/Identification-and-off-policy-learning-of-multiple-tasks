%adaptive k means clustering algorithm
function [stats]=k_means(S,stats,p)
%S is the current feature vector observed. stats is the statistics (mean, stddev and number of elements)
%corresponding to all the clusters.
if length(stats)==0%if there are no clusters, then update the clusters list and stats
    init_stats=update_stats(stats,S,p.init_var);
    stats={init_stats};
else
k=length(stats);%go through all the clusters
    for j=1:k
        d(j)=dist_meas(S,stats{j},'eucl');%distance measurement of sensor reading S from mean of other clusters
    end
    k_win=argmin(d);%winner cluster
    if within_range(stats{k_win},S,p.std_dev_tol)%check if it is within n std deviations
%         within_range(stats{k_win},S)
%         pause
        stats{k_win}=update_stats(stats{k_win},S,p.init_var);%update stats
    else k=k+1;%new cluster
        stats{k}=[];
        stats{k}=update_stats(stats{k},S,p.init_var);%update stats
    end
end    

% sumofmeans=zeros(length(stats{1}(:,1)),1);
% for m=1:length(stats)
% sumofmeans=sumofmeans+stats{m}(:,1);%calculate the sum of mean values
% end
% 
% for n=1:length(stats)%go through all the clusters
%     nos(n)=stats{n}(1,3);
% end
% norm_nos=(nos-min(nos))/max(nos-min(nos));

% for n=1:length(stats)%go through all the clusters
% meanofothers=(sumofmeans-stats{n}(:,1))/(length(stats)-1);%mean of mean of other clusters
% diff_score(n)=(norm([stats{n}(:,1)]-meanofothers));
% end
