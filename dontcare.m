function [curr_reward]=dontcare(S,curr_reward_copy)

for i=1:length(curr_reward_copy)
    if curr_reward_copy(i)==-1%if any of the vector elements are -1, then accept any sensor value for it
        curr_reward(i)=S(i);
    else curr_reward(i)=curr_reward_copy(i);
    end
end
curr_reward=curr_reward';