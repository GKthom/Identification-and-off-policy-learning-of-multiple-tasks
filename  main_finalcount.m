clc
clear all
close all
% % % p=parameters();
% % % [S]=sense_world(p.start,p);%sense environment
% % % w=rand(length(S),p.A);%initialize weights
% % % ww={};
% % % ww{1}=rand(length(S),p.A);
% % % countlog=[];
% % % curr_reward=[-1 -1 -1 1]';%care only about the last element
% % % clusters={};
% % % reward_features=rewardfeats(S,p);
% % % [clusters]=k_means(reward_features,clusters,p);
load LTR_01

w=wlog{1}{4};
for i=1:30
    i
    p=parameters();
    start_state=p.start;
    [count]=Q_lambda_finalcount(start_state,w,curr_reward,clusters,p);
    countlog(i)=count;
end