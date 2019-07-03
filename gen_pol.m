function [policy,total_return,bumps]=gen_pol(w,start_state,world,light,rough,target_pos,A,curr_reward,x,y,tol,reward_indices)

state=start_state;
policy=[];
bumps=0;

epsilon=0.05;
count=0;
curr_reward_copy=curr_reward;%keep a copy of the reward vector
[S]=sense_world(state,world,light,rough,target_pos,tol,x,y);
reward_features=rewardfeats(S,reward_indices);
curr_reward=dontcare(reward_features,curr_reward_copy);
total_return=0;
while sum(reward_features==curr_reward)~=length(curr_reward)
    if count>100%start exploring to get out of badly converged state
        break
        if rand>epsilon
            a=randi(A);%explore
        else [a, Qmax]=maxQ(state,w,world,light,rough,target_pos,tol,x,y);%exploit
        end
    else
        [a, Qmax]=maxQ(state,w,world,light,rough,target_pos,tol,x,y);%exploit
    end
    policy=[policy;a];%record policy
    state=transition(state,a,x,y);%new state
    [S]=sense_world(state,world,light,rough,target_pos,tol,x,y);
    if world(round(state(1)),round(state(2)))>0
        total_return=total_return-100;
        bumps=bumps+1;
    else total_return=total_return-10;
    end
    reward_features=rewardfeats(S,reward_indices);
    curr_reward=dontcare(reward_features,curr_reward_copy);
    count=count+1;
end