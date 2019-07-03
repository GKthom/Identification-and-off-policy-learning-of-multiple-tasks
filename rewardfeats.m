function [reward_features]=rewardfeats(S,p)
reward_features=S(1:p.reward_indices);