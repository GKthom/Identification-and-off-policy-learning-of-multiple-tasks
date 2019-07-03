function [percent]=Astarcompare(w,world,target_pos,a,b,light,rough,A,curr_reward,tol,reward_indices)
opt=0;
count=0;
for i=1:2:a
    for j=1:2:b
        start_state=[i,j,randi(360)];
        if world(i,j)==0
            [pt_log,closed_map,unfilt_path,path_length]=Astar(world,target_pos,start_state(1:2));
            [L,bump]=gen_opt_pol_Astarcompare(w,start_state,world,light,rough,target_pos,A,curr_reward,a,b,tol,reward_indices);
            if L<=3*path_length&&bump==0
                opt=opt+1;
            end
            count=count+1
        end
    end
end

percent=opt/count;

% % % %Fixed starting pt
% % % start_state=[10 10 0];
% % % [pt_log,closed_map,unfilt_path,path_length]=Astar(world,target_pos,start_state(1:2));
% % % [L]=gen_opt_pol_Astarcompare(w,start_state,world,light,rough,target_pos,A,curr_reward,a,b,tol,reward_indices);
% % % if L<=1.5*path_length
% % %     opt=opt+1;
% % % end
% % % percent=opt;