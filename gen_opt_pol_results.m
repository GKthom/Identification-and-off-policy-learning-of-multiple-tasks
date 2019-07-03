function [opt_count]=gen_opt_pol_results(w,start_state,world,light,rough,target_pos,A,curr_reward,x,y,tol,reward_indices,opt_count)

state=start_state;
policy=[];


epsilon=0.05;
count=0;
curr_reward_copy=curr_reward;%keep a copy of the reward vector
[S]=sense_world(state,world,light,rough,target_pos,tol,x,y);
reward_features=rewardfeats(S,reward_indices);
curr_reward=dontcare(reward_features,curr_reward_copy);

while sum(reward_features==curr_reward)~=length(curr_reward)
    if count>100%start exploring to get out of badly converged state
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
    reward_features=rewardfeats(S,reward_indices);
    curr_reward=dontcare(reward_features,curr_reward_copy);
    count=count+1;
    if count>200
        break
    end
end

    if count<100
        opt_count=opt_count+1;
    end