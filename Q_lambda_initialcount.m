function [stepcount]=Q_lambda_initialcount(start_state,w,curr_reward,clusters,ww,p)
state=start_state;
count=0;
curr_reward_copy=curr_reward;
[S]=sense_world(start_state,p);
e=zeros(length(S),p.A);
orig_clusters=clusters;
poss_e=zeros(length(S),p.A,length(clusters));
reward_features=rewardfeats(S,p);
curr_reward=dontcare(reward_features,curr_reward_copy);%for dont care case
break_flag=0;
stepcount=0;
while sum(reward_features==curr_reward)~=length(curr_reward)
    stepcount=stepcount+1;
    if rand<p.epsilon
        %random action
        a=randi(p.A);
        [a_opt, Qmax]=maxQ(state,w,p);
        if a==a_opt
            opt_act=1;
        else
            opt_act=0;
        end
    else
        [a, Qmax]=maxQ(state,w,p);
        opt_act=1;
    end
    
    next_state=transition(state,a,p);
    if p.world(round(next_state(1)),round(next_state(2)))>0
        next_state=state;
    end
    S_next=sense_world(next_state,p);
    reward_features_next=rewardfeats(S_next,p);
%     reward_features_next=S_next(1:length(curr_reward));
    curr_reward=dontcare(reward_features_next,curr_reward_copy);
    %%%
    
    %%%%%%%%%%%%%%%%%%%Set rewards%%%%%%%%%%%%
    if sum(reward_features_next==curr_reward)==length(curr_reward)
        R=p.highreward;
    elseif p.world(round(next_state(1)),round(next_state(2)))>0
        R=p.penalty;
    else
        R=p.livingpenalty;
    end    
    Q_s_a=Q_val(state,a,w,p);
    err=R-Q_s_a;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [S]=sense_world(state,p);
    if opt_act==0
        e=zeros(length(S),p.A);
    end
    ef=e(:,a);
    ef(S==1)=1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %     %importance sampling
% % %     allQ=[];
% % %     for qq=1:p.A
% % %         allQ=[allQ Q_val(state,qq,w,p)];
% % %     end
% % %     allQ=allQ-min(allQ);
% % %     allQ=allQ/max(allQ);
% % %     targ_prob=allQ(a)/sum(allQ);
% % % %     beh_prob=(p.epsilon/p.A)+((1-p.epsilon)*targ_prob);
% % %     if opt_act==1
% % %         beh_prob=targ_prob;
% % %     else beh_prob=allQ(a)/sum(allQ);%p.epsilon/p.A;
% % %     end
% % %     if beh_prob>0
% % %         imp_wts=targ_prob/beh_prob;
% % %     else
% % %         imp_wts=0;
% % %     end
    imp_wts=1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if R==p.highreward
        w(:,a)=w(:,a)+imp_wts*p.alpha*err*ef; 
    else    
        [a_next, Qmax_next]=maxQ(next_state,w,p);
        err=err+p.gamma*Qmax_next;
        w(:,a)=w(:,a)+imp_wts*p.alpha*err*ef;
        e(:,a)=ef;
        e=p.lambda*p.gamma*e;
    end
    
    
    %Other rewards
     if length(orig_clusters)>=1%Check if reward list is empty
         
         for jj=1:length(orig_clusters)
             poss_rew{jj}=round(orig_clusters{jj}(:,1));
             if sum(reward_features_next==poss_rew{jj})==length(poss_rew{jj})
                poss_reward=p.highreward;%Assign 100 reward for each of the possible objectives
                elseif p.world(round(next_state(1)),round(next_state(2)))>0
                poss_reward=p.penalty;
                else poss_reward=p.livingpenalty;%Living penalty
             end
             poss_w=ww{jj};%Choose the corresponding weights
             poss_Q_s_a=Q_val(state,a,poss_w,p);
             poss_err=poss_reward-poss_Q_s_a;
             [poss_a,poss_Qmax]=maxQ(state,poss_w,p);
             if poss_a~=a 
                 trace=zeros(length(S),p.A);
             end
%                  trace=poss_e(:,jj);
%                  trace(S==1)=1;
%                  poss_e(:,jj)=trace;
%              else
%                  poss_e(:,jj)=zeros(length(S),1);
%              end
             trace=poss_e(:,a,jj);
% % %              trace(S==1)=1;
% % %              %%%%%%%%%%%%%%importance sampling%%%%%%
% % %              poss_allQ=[];
% % %             for qq=1:p.A
% % %                 poss_allQ=[poss_allQ Q_val(state,qq,poss_w,p)];
% % %             end
% % %             poss_allQ
% % %             poss_allQ=poss_allQ-min(poss_allQ);
% % %             poss_allQ=poss_allQ/max(poss_allQ);
% % %             poss_targ_prob=poss_allQ(a)/sum(poss_allQ);
% % %             if beh_prob>0
% % %                 poss_imp_wts=poss_targ_prob/beh_prob;
% % %             else 
% % %                 poss_imp_wts=0;
% % %             end
             poss_allQ=[];
            for qq=1:p.A
                poss_allQ=[poss_allQ Q_val(state,qq,poss_w,p)];
            end
            
            poss_imp_wts=1;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
             if poss_reward==p.highreward
                 poss_w(:,a)=poss_w(:,a)+poss_imp_wts*p.alpha*poss_err*trace;%poss_e(:,jj);  
             else [poss_a_next,poss_Qmax_next]=maxQ(next_state,poss_w,p);
                 poss_err=poss_err+p.gamma*poss_Qmax_next;
                 poss_w(:,a)=poss_w(:,a)+poss_imp_wts*p.alpha*poss_err*trace;%poss_e(:,jj);
                 poss_e(:,a,jj)=trace;
                 poss_e(:,:,jj)=p.lambda*p.gamma*poss_e(:,:,jj);
             end                           
             ww{jj}=poss_w;
         end
     end
     
    state=next_state;
    reward_features=reward_features_next;
    [clusters]=k_means(reward_features,clusters,p);
    
    count=count+1;
    if count>p.break_thresh
        disp('Broke!')
        break_flag=1;
        break
    end
     
end
