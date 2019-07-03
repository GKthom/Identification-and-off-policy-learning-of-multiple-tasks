clear
clc
p=parameters();
returnlog={};
stepslog={};
wlog={};
clusterlog={};
parfor kkk=1:p.N_runs
kkk
p=parameters();
[S]=sense_world(p.start,p);%sense environment
reward_features=rewardfeats(S,p);
w=rand(length(S),p.A);%initialize weights
ww={};
ww{1}=rand(length(S),p.A);
curr_reward=[-1 -1 -1 1]';%care only about the last element
%%%%Initialize clusters and reward list%%%%
clusters={};
[clusters]=k_means(reward_features,clusters,p);
% reward_list={};
% clust_num=1;
clust_form=[];
clust_count=1;
returns_all={};
steps_all={};
%%%%%%%%%%%%%%%%%%%Basic Algorithm%%%%%%%%%%%%%
for i=1:p.N_iter
    i
    n_clusters_prev=length(clusters);
    %learn primary objective?
    [w,clusters,ww]=Q_lambda(p.start,w,curr_reward,clusters,ww,p);%Q lambda algorithm
    n_clusters_new=length(clusters);    
    if n_clusters_new>n_clusters_prev
        for nc=(n_clusters_prev+1):n_clusters_new%initialize value function weights of new clusters
            ww{nc}=rand(length(S),p.A);
        end
%cluster formation%        
%         disp('Cluster formation')
%         [im]=show_clusters(clusters,p);
%         clust_count=clust_count+1;
%         im_test(:,:,:,clust_count)=imrotate(im,90);
%         clust_form=[clust_form;i];
    end
    [return_vect, steps_vect]=calcret(w,p,curr_reward);%returns(i);
    for ii=1:length(clusters)
        reward_vect=round(clusters{ii}(:,1));
        reward_vect(reward_vect==0)=-1;
        [rets, steps]=calcret(ww{ii},p,reward_vect);
        return_vect=[return_vect rets];
        steps_vect=[steps_vect steps];
    end
    returns_all{i}=return_vect;
    steps_all{i}=steps_vect;
end
wlog{kkk}={w ww};
clusterlog{kkk}=clusters;
returnlog{kkk}=returns_all;
stepslog{kkk}=steps_all;
end
[retcum,stepcum,final_returns,final_steps]=scoopdy(clusterlog, returnlog,stepslog, p);
plot((retcum(:,1))/p.N_runs)
figure
plot((stepcum(:,1))/p.N_runs)
% parsave('test_10runs',clusters,wlog,returnlog)
%Show clustering montage%%%%
% montage(im_test)
%%%%%%%%%%%%%%%%%%%