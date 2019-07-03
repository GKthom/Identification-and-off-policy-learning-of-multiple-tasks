clear all
clc
%Add real world data
%%%%%World params%%%
conv_rates=[];
conv_rates_first=[];
for kkk=1:10
kkk
a=30;
b=30;
world=zeros(a,b);
world(:,1)=1;
world(:,end)=1;
world(1,:)=1;
world(end,:)=1;
world(13,1:15)=1;
world(5:13,15)=1;
% world(18,10:30)=1;
%world(8:13,15)=1;
light=[20 12];%[20 12];
rough=[28 28];%[3 25];
target_pos=[3 25];%[28 28];
start_state=[10 10 0];

A=9;
tol=3;
std_dev_tol=1;
init_var=1;

N_iter=1000;
[S]=sense_world(start_state,world,light,rough,target_pos,tol,a,b,randi(A));
reward_indices=1:4;
reward_features=rewardfeats(S,reward_indices);
w=rand(length(S),A);
ww={};
ww{1}=rand(length(S),A);
% curr_reward=[-1 -1 -1 -1 -1 -1 1]';
% curr_reward=[-1 -1 -1 -1 -1 -1 -1 -1 1]';
curr_reward=[-1 -1 -1 1]';
n_rewards=5;
%%%%Initialize clusters and reward list%%%%
clusters={};
[clusters diffs]=k_means(reward_features,clusters,std_dev_tol,init_var);
reward_list={};
clust_num=1;
clust_form=[];
optcnt=0;
converge_flag=0;
percent_prim=0;
percent_sec1=0;
percent_sec2=0;
conv_tol=0.5;
conv_res=20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Q-learning%%%%%%%%%%%%%%%%%%%%%%%%%%
conv_flag_prim=0;
% while percent_prim<conv_tol
for i=1:N_iter
start_state=[randi(a) randi(b) rand*360];
while world(start_state(1),start_state(2))==1||(start_state(1)==target_pos(1)&&(start_state(2)==target_pos(2)))
    start_state=[randi(a) randi(b) rand*360];
end
    i
    n_clusters_prev=length(clusters);
    [w,clusters,diffs,ww,break_flag]=Q_lambda(start_state,A,target_pos,light,rough,world,w,curr_reward,clusters,diffs,ww,reward_list,clust_num,tol,reward_indices,a,b,std_dev_tol,init_var);
    n_clusters_new=length(clusters);
    if break_flag==1
        i=1000;
        break
    end
    if n_clusters_new>n_clusters_prev
        for nc=(n_clusters_prev+1):n_clusters_new%initialize Q values of new cluster as zeros
            ww{nc}=rand(length(S),A);
        end
    end
    if percent_prim<conv_tol&&conv_flag_prim==0
    if i>=50
        if mod(i,conv_res)==0
            [percent_prim]=Astarcompare(w,world,target_pos,a,b,light,rough,A,curr_reward,tol,reward_indices)
        end
        if percent_prim>=conv_tol
            conv_prim=i;
            conv_flag_prim=1;
        else conv_prim=1000;
        end
    end
    end
    [reward_list,clust_num]=sortclusters(diffs,n_rewards,clusters);
end
% % % [policy]=gen_opt_pol(w,start_state,world,light,rough,target_pos,A,curr_reward,a,b,tol,reward_indices);
[conv_prim_first]=Astarcompare(w,world,target_pos,a,b,light,rough,A,curr_reward,tol,reward_indices);
ww_copy=ww;

%%%%%%%%%%%%%%%%%%%%%%%Find and learn a secondary objective%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

secondary_rew=[-1 1 -1 -1]';
secondary_clust=[];
indices_to_check=find(secondary_rew==1);
k=length(clusters);
for j=1:k
    if find(round(clusters{j}(indices_to_check))==1)
        secondary_clust=[secondary_clust;j clusters{j}(1,3)];
    end
end
siz_sec_clust=size(secondary_clust);
if siz_sec_clust(1)>1
    secondary_clust=secondary_clust(find(max(secondary_clust(:,2))),:);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Q-learning for secondary obj now set as primary%%%%%%%%%%%%%%%%%%%%%%%%%%
if length(secondary_clust)>0
w1=ww_copy{clust_num(secondary_clust(1))};
curr_reward=secondary_rew;
i=0;
while percent_sec1<conv_tol
start_state=[randi(a) randi(b) rand*360];
while world(start_state(1),start_state(2))==1||(start_state(1)==light(1)&&(start_state(2)==light(2)))
    start_state=[randi(a) randi(b) rand*360];
end
    i
    n_clusters_prev=length(clusters);
    [w1,clusters,diffs,ww,break_flag]=Q_lambda(start_state,A,target_pos,light,rough,world,w1,curr_reward,clusters,diffs,ww,reward_list,clust_num,tol,reward_indices,a,b,std_dev_tol,init_var);
    n_clusters_new=length(clusters);
    if break_flag==1
        i=1000;
        break
    end
    if n_clusters_new>n_clusters_prev
        for nc=(n_clusters_prev+1):n_clusters_new%initialize Q values of new cluster as zeros
            ww{nc}=w;%rand(length(S),A);
        end
    end
    if i>=0
        if mod(i,conv_res)==0
            [percent_sec1]=Astarcompare(w1,world,light,a,b,light,rough,A,curr_reward,tol,reward_indices)
        end
        if i==0
            conv_sec1_first=percent_sec1;
        end
    end
%     [reward_list,clust_num]=sortclusters(diffs,n_rewards,clusters);
    i=i+1;
end
end
conv_sec1=i;

%%%%%%%%%%%%%%%%%%%%%%%Find and learn a secondary objective%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
secondary_rew=[-1 -1 1 -1]';
secondary_clust=[];
indices_to_check=find(secondary_rew==1);
k=length(clusters);
for j=1:k
    if find(round(clusters{j}(indices_to_check))==1)
        secondary_clust=[secondary_clust;j clusters{j}(1,3)];
    end
end
siz_sec_clust=size(secondary_clust);
if siz_sec_clust(1)>1
    secondary_clust=secondary_clust(find(max(secondary_clust(:,2))),:);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Q-learning for secondary obj now set as primary%%%%%%%%%%%%%%%%%%%%%%%%%%
if length(secondary_clust)>0
w2=ww_copy{clust_num(secondary_clust(1))};
curr_reward=secondary_rew;
i=0;
while percent_sec2<conv_tol
start_state=[randi(a) randi(b) rand*360];
while world(start_state(1),start_state(2))==1||(start_state(1)==rough(1)&&(start_state(2)==rough(2)))
    start_state=[randi(a) randi(b) rand*360];
end
    i
    n_clusters_prev=length(clusters);
    [w2,clusters,diffs,ww,break_flag]=Q_lambda(start_state,A,target_pos,light,rough,world,w2,curr_reward,clusters,diffs,ww,reward_list,clust_num,tol,reward_indices,a,b,std_dev_tol,init_var);
    n_clusters_new=length(clusters);
    if break_flag==1
        i=1000;
        break
    end
    if n_clusters_new>n_clusters_prev
        for nc=(n_clusters_prev+1):n_clusters_new%initialize Q values of new cluster as zeros
            ww{nc}=rand(length(S),A);
        end
    end
    if i>=0
        if mod(i,conv_res)==0
            [percent_sec2]=Astarcompare(w2,world,rough,a,b,light,rough,A,curr_reward,tol,reward_indices)
        end
        if i==0
            conv_sec2_first=percent_sec2;
        end
    end
%     [reward_list,clust_num]=sortclusters(diffs,n_rewards,clusters);
    i=i+1;
end
end
conv_sec2=i;

conv_rates=[conv_rates;[conv_prim conv_sec1 conv_sec2]]
conv_rates_first=[conv_rates_first;[conv_prim_first conv_sec1_first conv_sec2_first]]
beep
end
load handel
sound(y,Fs)