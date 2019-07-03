function [retj,alli]=calcret(w,p,target_feat)
target_feat_copy=target_feat;
% state=p.start;
% i=1;
% ret=0;
% while norm(state(1:2)-goal)>p.target_thresh
%     [Qmax,a]=maxQ(Q2,state);
%     state=transition(state,a,p);
%     if norm(state(1:2)-goal)<=p.target_thresh
%         r=p.highreward;
%     else r=p.livingpenalty;
%     end
%     ret=ret+r;
%     i=i+1;
%     if i>1000
%         ret=ret-1000;
%         break
%     end
% end

% state=p.start;
retj=0;
alli=0;
for j=1:100
state=[round(rand*(p.a)) round(rand*(p.b)) 0];
% state=p.start;
if state(1)<=1
    state(1)=1;
elseif state(1)>=p.a
    state(1)=p.a;
end

if state(2)<=1
    state(2)=1;
elseif state(2)>=p.b
    state(2)=p.b;
end

ret=0;
% while norm(state(1)-goal(1))>p.target_thresh
foundflag=0;
for i=1:100
    [a, Qmax]=maxQ(state,w,p);
    state=transition(state,a,p);
    [S]=sense_world(state,p);
    reward_features=rewardfeats(S,p);
%     if norm(state(1:2)-goal)<=p.tol
    target_feat=dontcare(reward_features,target_feat_copy);
    if sum(reward_features==target_feat)==length(target_feat)
        r=p.highreward;
        ret=ret+r;
        if foundflag==0
            stepcnt=i;
        end
        foundflag=1;
%         break
    else r=p.livingpenalty;
    end
    ret=ret+r;
%     i=i+1;
%     if i>1000
%         ret=ret-1000;
%         break
%     end
end
retj=retj+ret;
if foundflag==1
    alli=alli+stepcnt;
else alli=alli+i;
end
end
retj=retj/j;
alli=alli/j;