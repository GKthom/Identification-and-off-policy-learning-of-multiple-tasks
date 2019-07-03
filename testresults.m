load pureexplore1000

[policy]=gen_opt_pol_testres(ww{clust_num(3)},[4 13 0],world,light,rough,target_pos,A,round(reward_list{3}(:,1)),a,b,tol,reward_indices);%target
% [policy]=gen_opt_pol_testres(ww{clust_num(1)},[15 27 0],world,light,rough,target_pos,A,round(reward_list{1}(:,1)),a,b,tol,reward_indices,2);%target
% 
% [policy]=gen_opt_pol_testres(ww{clust_num(4)},[10 5 0],world,light,rough,target_pos,A,round(reward_list{4}(:,1)),a,b,tol,reward_indices,3);%target