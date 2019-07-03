%function [policy]=gen_opt_pol_testres(w,start_state,world,light,rough,target_pos,A,curr_reward,x,y,tol,reward_indices)
load pureexplore1000

ind=[3 1 4];
x=a;
y=b;
for iii=1:3
iii
    curr_reward=round(reward_list{ind(iii)}(:,1));
    w=ww{clust_num(ind(iii))};
    if iii==1
        start_state=[4 13 0];
    elseif iii==2
        start_state=[15 27 0];
    elseif iii==3
        start_state=[10 5 0];
    end
    state=start_state;
    policy=[];

for i=1:x
    for j=1:y
        if world(i,j)>0
            h0=scatter(i,j,'k','filled');
            hold on
        end
    end
end

axis([0 x 0 y])
hold on
h1=scatter(light(1),light(2),500,[1 0.8 0],'filled','square');
hold on
h2=scatter(rough(1),rough(2),500,'r','filled','square');
hold on
h3=scatter(target_pos(1),target_pos(2),500,'b','filled','square');
hold on



epsilon=0.05;
count=0;
curr_reward_copy=curr_reward;%keep a copy of the reward vector
[S]=sense_world(state,world,light,rough,target_pos,tol,x,y);
reward_features=rewardfeats(S,reward_indices);
curr_reward=dontcare(reward_features,curr_reward_copy);
curr_reward

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
    if iii==1
    ha1=scatter(state(1),state(2),[500/length(policy)],'b');
    elseif iii==2
        ha3=scatter(state(1),state(2),[500/length(policy)],[1 0.8 0]);
    elseif iii==3
        ha2=scatter(state(1),state(2),[500/length(policy)],'r');
    end
%     plot(state(1),state(2));
    pause(0.01)
    hold on
    state=transition(state,a,x,y);%new state
    [S]=sense_world(state,world,light,rough,target_pos,tol,x,y);
    reward_features=rewardfeats(S,reward_indices);
    curr_reward=dontcare(reward_features,curr_reward_copy);
    count=count+1;
end

    if count>100
        disp('epsilon-greedy policy')
    else disp('Optimal policy')
    end
    
end
legend([h1 h2 h3 h0 ha1 ha2 ha3],{'Area with light','Rough area', 'Target location','Obstacles','Path to target','Path to area with light','Path to rough area'});