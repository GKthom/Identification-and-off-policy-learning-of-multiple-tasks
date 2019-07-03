clear all
clc
%Add real world data
%%%%%World params%%%
convergence_rates=[];
pcavg_prim=[];
pcavg_sec1=[];
pcavg_sec2=[];
for kkk=1:1
kkk
a=30;
b=30;
% % % a=229;
% % % b=148;
% % % load obs_map
% % % N=3;
% % % se=ones(2*N+1,2*N+1);
% % % world=imdilate(obs_map,se);
% % % world(world==100)=1;
world=zeros(a,b);
world(:,1)=1;
world(:,end)=1;
world(1,:)=1;
world(end,:)=1;
world(13,1:15)=1;
world(5:13,15)=1;
% world(18,10:30)=1;
%world(8:13,15)=1;
% light=[randi(a) randi(b)];
% rough=[randi(a) randi(b)];
% start_state=[randi(a) randi(b) rand*360]; 
light=[20 12];
rough=[3 25];
target_pos=[28 28];
start_state=[10 10 0];
% % % light=[100 120];
% % % rough=[200 100];
% % % target_pos=[80 80];
% % % start_state=[190 70 0];

A=9;
tol=3;
std_dev_tol=1;
init_var=1;

N_iter=300;
[S]=sense_world(start_state,world,light,rough,target_pos,tol,a,b,randi(A));
reward_indices=1:4;
reward_features=rewardfeats(S,reward_indices);
w=rand(length(S),A);
ww={};
ww{1}=rand(length(S),A);
% curr_reward=[-1 -1 -1 -1 -1 -1 1]';
% curr_reward=[-1 -1 -1 -1 -1 -1 -1 -1 1]';
curr_reward=[-1 -1 -1 1]';
n_rewards=5;
%%%%Initialize clusters and reward list%%%%
clusters={};
[clusters diffs]=k_means(reward_features,clusters,std_dev_tol,init_var);
reward_list={};
clust_num=1;
clust_form=[];
%%%%%%%%%%%%%%%%%%%Basic Algorithm%%%%%%%%%%%%%
% % % % % % % % % % for i=1:N_iter
% % % % % % % % % %     i
% % % % % % % % % %     n_clusters_prev=length(clusters);
% % % % % % % % % %     [w,clusters,diffs,ww]=Q_lambda(start_state,A,target_pos,light,rough,world,w,curr_reward,clusters,diffs,ww,reward_list,clust_num,tol,reward_indices,a,b,std_dev_tol,init_var);
% % % % % % % % % %     n_clusters_new=length(clusters);
% % % % % % % % % %     
% % % % % % % % % %     if n_clusters_new>n_clusters_prev
% % % % % % % % % %         for nc=(n_clusters_prev+1):n_clusters_new%initialize Q values of new cluster as zeros
% % % % % % % % % %             ww{nc}=rand(length(S),A);
% % % % % % % % % %         end
% % % % % % % % % % %Uncomment to show cluster formation        
% % % % % % % % % % %         disp('Cluster formation')
% % % % % % % % % % %         [im]=show_clusters(world,light,rough,target_pos,clusters,tol,a,b,reward_indices);
% % % % % % % % % % %         clust_count=clust_count+1;
% % % % % % % % % % %         im_test(:,:,:,clust_count)=imrotate(im,90);
% % % % % % % % % % %         clust_form=[clust_form;i];
% % % % % % % % % %     end
% % % % % % % % % %     [reward_list,clust_num]=sortclusters(diffs,n_rewards,clusters);
% % % % % % % % % % end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

optcnt=0;
converge_flag=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Q-learning%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N_iter
% i=1;
start_state=[randi(a) randi(b) rand*360];
while world(start_state(1),start_state(2))==1||(start_state(1)==target_pos(1)&&(start_state(2)==target_pos(2)))
    start_state=[randi(a) randi(b) rand*360];
end
% [pt_log,closed_map,unfilt_path,path_length]=Astar(world,target_pos,start_state(1:2));
% steps_to_target=path_length/1.6;
% while converge_flag==0
    i
    n_clusters_prev=length(clusters);
    [w,clusters,diffs,ww]=Q_lambda(start_state,A,target_pos,light,rough,world,w,curr_reward,clusters,diffs,ww,reward_list,clust_num,tol,reward_indices,a,b,std_dev_tol,init_var);
    n_clusters_new=length(clusters);
    
    if n_clusters_new>n_clusters_prev
        for nc=(n_clusters_prev+1):n_clusters_new%initialize Q values of new cluster as zeros
            ww{nc}=rand(length(S),A);
        end

%Uncomment to show cluster formation        
%         disp('Cluster formation')
%         [im]=show_clusters(world,light,rough,target_pos,clusters,tol,a,b,reward_indices);
%         clust_count=clust_count+1;
%         im_test(:,:,:,clust_count)=imrotate(im,90);
%         clust_form=[clust_form;i];
    end
    [reward_list,clust_num]=sortclusters(diffs,n_rewards,clusters);
    
%%%%%%%%%%Convergence Check%%%%%%%%%%

% % %         [curr_pol,ret,bumps]=gen_pol(w,start_state,world,light,rough,target_pos,A,curr_reward,a,b,tol,reward_indices);
% % %         ret
% % %         steps_to_target
% % %         bumps
% % %         if ret>=(-10*steps_to_target*2)&&bumps<2||i>200
% % %             optcnt=optcnt+1;
% % %         else optcnt=0;
% % %         end
% % %         if optcnt>2
% % %             disp('pol found!')
% % %             converge_flag=1;
% % %             break
% % %         end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% i=i+1;
end
% % % [policy]=gen_opt_pol(w,start_state,world,light,rough,target_pos,A,curr_reward,a,b,tol,reward_indices);
ww_copy=ww;

% % % % % %%%%%%%%%%%%%%%%%%%%%%%Find and learn a secondary objective%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % secondary_rew=[-1 -1 1 -1]';
% % % % % secondary_clust=[];
% % % % % indices_to_check=find(secondary_rew==1);
% % % % % k=length(clusters);
% % % % % for j=1:k
% % % % %     if find(round(clusters{j}(indices_to_check))==1)
% % % % %         secondary_clust=[secondary_clust;j clusters{j}(1,3)];
% % % % %     end
% % % % % end
% % % % % siz_sec_clust=size(secondary_clust);
% % % % % if siz_sec_clust(1)>1
% % % % %     secondary_clust=secondary_clust(find(max(secondary_clust(:,2))),:);
% % % % % end
% % % % % 
% % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%Q-learning for secondary obj now set as primary%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % if length(secondary_clust)>0
% % % % % w=ww_copy{secondary_clust(1)};
% % % % % curr_reward=secondary_rew;
% % % % % optcnt=0;
% % % % % converge_flag=0;
% % % % % ii=1;
% % % % % [pt_log,closed_map,unfilt_path,path_length]=Astar(world,rough,start_state(1:2));
% % % % % steps_to_target=path_length/1.6;
% % % % % while converge_flag==0
% % % % %     ii
% % % % %     n_clusters_prev=length(clusters);
% % % % %     [w,clusters,diffs,ww]=Q_lambda(start_state,A,target_pos,light,rough,world,w,curr_reward,clusters,diffs,ww,reward_list,clust_num,tol,reward_indices,a,b,std_dev_tol,init_var);
% % % % %     n_clusters_new=length(clusters);
% % % % %     
% % % % %     if n_clusters_new>n_clusters_prev
% % % % %         for nc=(n_clusters_prev+1):n_clusters_new%initialize Q values of new cluster as zeros
% % % % %             ww{nc}=rand(length(S),A);
% % % % %         end
% % % % % 
% % % % % %Uncomment to show cluster formation        
% % % % % %         disp('Cluster formation')
% % % % % %         [im]=show_clusters(world,light,rough,target_pos,clusters,tol,a,b,reward_indices);
% % % % % %         clust_count=clust_count+1;
% % % % % %         im_test(:,:,:,clust_count)=imrotate(im,90);
% % % % % %         clust_form=[clust_form;i];
% % % % %     end
% % % % %     [reward_list,clust_num]=sortclusters(diffs,n_rewards,clusters);
% % % % %     
% % % % % %%%%%%%%%%Convergence Check%%%%%%%%%%
% % % % %         
% % % % %         [curr_pol,ret,bumps]=gen_pol(w,start_state,world,light,rough,target_pos,A,curr_reward,a,b,tol,reward_indices);
% % % % %         ret
% % % % %         steps_to_target
% % % % %         bumps
% % % % %         if ret>=(-10*steps_to_target*2)&&bumps<2||ii>200
% % % % %             optcnt=optcnt+1;
% % % % %         else optcnt=0;
% % % % %         end
% % % % %         if optcnt>2
% % % % %             disp('pol found!')
% % % % %             converge_flag=1;
% % % % %             break
% % % % %         end
% % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % ii=ii+1;
% % % % % end
% % % % % % [policy]=gen_opt_pol(w,start_state,world,light,rough,target_pos,A,curr_reward,a,b,tol,reward_indices);
% % % % % else ii=0;
% % % % % end
% % % % % 
% % % % % 
% % % % % %After convergece, change primary obj to being light/rough and check the
% % % % % %additional no. of iterations needed for convergence
% % % % % %%%%%%%%%%%%%%%%%%%%%%%Find and learn a light objective%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % secondary_rew=[-1 1 -1 -1]';
% % % % % secondary_clust=[];
% % % % % indices_to_check=find(secondary_rew==1);
% % % % % k=length(clusters);
% % % % % for j=1:k
% % % % %     if find(round(clusters{j}(indices_to_check))==1)
% % % % %         secondary_clust=[secondary_clust;j clusters{j}(1,3)];
% % % % %     end
% % % % % end
% % % % % siz_sec_clust=size(secondary_clust);
% % % % % if siz_sec_clust(1)>1
% % % % %     secondary_clust=secondary_clust(find(max(secondary_clust(:,2))),:);
% % % % % end
% % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%Q-learning for secondary obj now set as primary%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % if length(secondary_clust)>0
% % % % % % w=ww_copy{secondary_clust(1)};
% % % % % w=ww{secondary_clust(1)};
% % % % % curr_reward=secondary_rew;
% % % % % optcnt=0;
% % % % % converge_flag=0;
% % % % % iii=1;
% % % % % [pt_log,closed_map,unfilt_path,path_length]=Astar(world,light,start_state(1:2));
% % % % % steps_to_target=path_length/1.6;
% % % % % while converge_flag==0
% % % % %     iii
% % % % %     n_clusters_prev=length(clusters);
% % % % %     [w,clusters,diffs,ww]=Q_lambda(start_state,A,target_pos,light,rough,world,w,curr_reward,clusters,diffs,ww,reward_list,clust_num,tol,reward_indices,a,b,std_dev_tol,init_var);
% % % % %     n_clusters_new=length(clusters);
% % % % %     
% % % % %     if n_clusters_new>n_clusters_prev
% % % % %         for nc=(n_clusters_prev+1):n_clusters_new%initialize Q values of new cluster as zeros
% % % % %             ww{nc}=rand(length(S),A);
% % % % %         end
% % % % % 
% % % % % %Uncomment to show cluster formation        
% % % % % %         disp('Cluster formation')
% % % % % %         [im]=show_clusters(world,light,rough,target_pos,clusters,tol,a,b,reward_indices);
% % % % % %         clust_count=clust_count+1;
% % % % % %         im_test(:,:,:,clust_count)=imrotate(im,90);
% % % % % %         clust_form=[clust_form;i];
% % % % %     end
% % % % %     [reward_list,clust_num]=sortclusters(diffs,n_rewards,clusters);
% % % % %     
% % % % % %%%%%%%%%%Convergence Check%%%%%%%%%%
% % % % %         [curr_pol,ret,bumps]=gen_pol(w,start_state,world,light,rough,target_pos,A,curr_reward,a,b,tol,reward_indices);
% % % % %         ret
% % % % %         steps_to_target
% % % % %         bumps
% % % % %         if ret>=(-10*steps_to_target*2)&&bumps<2||iii>200
% % % % %             optcnt=optcnt+1;
% % % % %         else optcnt=0;
% % % % %         end
% % % % %         if optcnt>2
% % % % %             disp('pol found!')
% % % % %             converge_flag=1;
% % % % %             break
% % % % %         end
% % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % iii=iii+1;
% % % % % end
% % % % % %Show policy
% % % % % % [policy]=gen_opt_pol(w,start_state,world,light,rough,target_pos,A,curr_reward,a,b,tol,reward_indices);
% % % % % else iii=0;
% % % % % end
% % % % % 
% % % % % convergence_rates=[convergence_rates;i ii iii];%target,rough and light
[percent_prim]=Astarcompare(w,world,target_pos,a,b,light,rough,A,curr_reward,tol,reward_indices);
pcavg_prim=[pcavg_prim;percent_prim];

secondary_rew=[-1 1 -1 -1]';
secondary_clust=[];
indices_to_check=find(secondary_rew==1);
k=length(clusters);
for j=1:k
    if find(round(clusters{j}(indices_to_check))==1)
        secondary_clust=[secondary_clust;j clusters{j}(1,3)];
    end
end
siz_sec_clust=size(secondary_clust);
if siz_sec_clust(1)>1
    secondary_clust=secondary_clust(find(max(secondary_clust(:,2))),:);
end

if length(secondary_clust)>0
    w1=ww{secondary_clust(1)};
    curr_reward=secondary_rew;
end

[percent_sec1]=Astarcompare(w1,world,light,a,b,light,rough,A,curr_reward,tol,reward_indices);
pcavg_sec1=[pcavg_sec1;percent_sec1];


secondary_rew=[-1 -1 1 -1]';
secondary_clust=[];
indices_to_check=find(secondary_rew==1);
k=length(clusters);
for j=1:k
    if find(round(clusters{j}(indices_to_check))==1)
        secondary_clust=[secondary_clust;j clusters{j}(1,3)];
    end
end
siz_sec_clust=size(secondary_clust);
if siz_sec_clust(1)>1
    secondary_clust=secondary_clust(find(max(secondary_clust(:,2))),:);
end

if length(secondary_clust)>0
    w2=ww{secondary_clust(1)};
    curr_reward=secondary_rew;
end

[percent_sec2]=Astarcompare(w2,world,rough,a,b,light,rough,A,curr_reward,tol,reward_indices);
pcavg_sec2=[pcavg_sec2;percent_sec2];

end
%%%%%%%%For convergence test%%%%%%%%%%%%%%%%
%Go through all the rewards and generate policies
% for j=1:length(reward_list)
%     rew=round(reward_list{j}(:,1));
%     rew(rew==0)=-1;
%     [policy]=gen_opt_pol(ww{clust_num(j)},start_state,world,light,rough,target_pos,A,rew,a,b);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%Show clusters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % disp('Cluster formation')
% % % [im]=show_clusters(world,light,rough,target_pos,clusters,tol,a,b,reward_indices);
% % % figure
% % % image(imrotate(im,90))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%for optimal policy table%%%%%%%%%%%%%%%%%
% % % %Compile results table- Goes through all the starting points and
% % % %counts how many lead to optimal policies 
%%%%%%%%%%%%%%%%For original objective%%%%%%%%%%%%%%
opt_count=0;
for i=1:a
    for j=1:b
        [opt_count]=gen_opt_pol_results(w,[i j rand*360],world,light,rough,target_pos,A,curr_reward,a,b,tol,reward_indices,opt_count);
    end
end

%%%%%%%%%%%%For discovered objective%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%go through all the discovered objectives, go through all the
%starting points and keep count of how many were optimal policies
opt_count_obj=[];
for k=1:length(reward_list)
    opt_count_obj(k)=0;
    c_r=round(reward_list{k}(:,1));
    c_r(c_r==0)=-1;
for i=1:a
    for j=1:b
        [opt_count_obj(k)]=gen_opt_pol_results(ww{clust_num(k)},[i j rand*360],world,light,rough,target_pos,A,c_r,a,b,tol,reward_indices,opt_count_obj(k));
    end
end
k
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Show clustering montage%%%%
% montage(im_test)
%%%%%%%%%%%%%%%%%%%
% [percent]=Astarcompare(w,world,target_pos,a,b,light,rough,A,curr_reward,tol,reward_indices);