clear
close all
p=parameters();
[S]=sense_world(p.start,p);%sense environment
w=rand(length(S),p.A);%initialize weights
ww={};
ww{1}=rand(length(S),p.A);
countlog=[];
curr_reward=[-1 -1 -1 1]';%care only about the last element
clusters={};
reward_features=rewardfeats(S,p);
[clusters]=k_means(reward_features,clusters,p);
for i=1:30
    i
    p=parameters();
    start_state=p.start;
    [count]=Q_lambda_initialcount(start_state,w,curr_reward,clusters,ww,p);
    countlog(i)=count;
end