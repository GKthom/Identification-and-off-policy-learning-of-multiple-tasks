clear all
clc
%Add real world data
%%%%%World params%%%
convergence_rates=[];
pcavg_prim=[];
pcavg_sec1=[];
pcavg_sec2=[];
for kkk=1:1
kkk
a=30;
b=30;
% % % a=229;
% % % b=148;
% % % load obs_map
% % % N=3;
% % % se=ones(2*N+1,2*N+1);
% % % world=imdilate(obs_map,se);
% % % world(world==100)=1;
world=zeros(a,b);
world(:,1)=1;
world(:,end)=1;
world(1,:)=1;
world(end,:)=1;
world(13,1:15)=1;
world(5:13,15)=1;
% world(18,10:30)=1;
%world(8:13,15)=1;
% light=[randi(a) randi(b)];
% rough=[randi(a) randi(b)];
% start_state=[randi(a) randi(b) rand*360]; 
light=[20 12];
rough=[3 25];
target_pos=[28 28];
start_state=[10 10 0];
% % % light=[100 120];
% % % rough=[200 100];
% % % target_pos=[80 80];
% % % start_state=[190 70 0];

A=9;
tol=3;
std_dev_tol=1;
init_var=1;

N_iter=100;
[S]=sense_world(start_state,world,light,rough,target_pos,tol,a,b,randi(A));
reward_indices=1:64;
reward_features=rewardfeats(S,reward_indices);
w=rand(length(S),A);
ww={};
ww{1}=rand(length(S),A);
% curr_reward=[-1 -1 -1 -1 -1 -1 1]';
% curr_reward=[-1 -1 -1 -1 -1 -1 -1 -1 1]';
curr_reward=-1*ones(64,1);
curr_reward(3)=1;

n_rewards=5;
%%%%Initialize clusters and reward list%%%%
clusters={};
[clusters diffs]=k_means(reward_features,clusters,std_dev_tol,init_var);
reward_list={};
clust_num=1;
clust_form=[];

optcnt=0;
converge_flag=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Q-learning%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N_iter
start_state=[randi(a) randi(b) rand*360];
while world(start_state(1),start_state(2))==1||(start_state(1)==target_pos(1)&&(start_state(2)==target_pos(2)))
    start_state=[randi(a) randi(b) rand*360];
end
    i
    n_clusters_prev=length(clusters);
    [w,clusters,diffs,ww]=Q_lambda(start_state,A,target_pos,light,rough,world,w,curr_reward,clusters,diffs,ww,reward_list,clust_num,tol,reward_indices,a,b,std_dev_tol,init_var);
    n_clusters_new=length(clusters);
    
    if n_clusters_new>n_clusters_prev
        for nc=(n_clusters_prev+1):n_clusters_new%initialize Q values of new cluster as zeros
            ww{nc}=rand(length(S),A);
        end
    end
    [reward_list,clust_num]=sortclusters(diffs,n_rewards,clusters);
    
end

ww_copy=ww;

end



%%%%%%%%%%%%%%%%%%%%%%%%%%Show clusters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Cluster formation')
[im]=show_clusters(world,light,rough,target_pos,clusters,tol,a,b,reward_indices);
figure
image(imrotate(im,90))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%