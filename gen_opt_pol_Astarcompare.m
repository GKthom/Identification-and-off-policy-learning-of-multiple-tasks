function [L,bump]=gen_opt_pol_Astarcompare(w,start_state,world,light,rough,target_pos,A,curr_reward,x,y,tol,reward_indices)
bump=0;
state=start_state;
policy=[];
epsilon=0.05;
count=0;
curr_reward_copy=curr_reward;%keep a copy of the reward vector
[S]=sense_world(state,world,light,rough,target_pos,tol,x,y);
reward_features=rewardfeats(S,reward_indices);
curr_reward=dontcare(reward_features,curr_reward_copy);

while sum(reward_features==curr_reward)~=length(curr_reward)
    if count>200%start exploring to get out of badly converged state
        break
    else
        [a, Qmax]=maxQ(state,w,world,light,rough,target_pos,tol,x,y);%exploit
    end
    policy=[policy;a];%record policy
%     ha=scatter(state(1),state(2),[500/length(policy)],[0.1 0.6 0.1],'filled');
%     plot(state(1),state(2));
%     pause(0.01)
%     hold on
    state=transition(state,a,x,y);%new state
    if world(round(state(1)),round(state(2)))==1
        bump=1;
    end
    [S]=sense_world(state,world,light,rough,target_pos,tol,x,y);
    reward_features=rewardfeats(S,reward_indices);
    curr_reward=dontcare(reward_features,curr_reward_copy);
    count=count+1;
end
L=length(policy);
%     if count>100
%         disp('epsilon-greedy policy')
%     else disp('Optimal policy')
%     end
% legend([h1 h2 h3 h0 ha],{'Area with light','Rough area', 'Target location','Obstacles','Agent path'});