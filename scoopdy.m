%this function assigns tags to each reward feature vector and matches the
%return logs to it
function [final_ret_cum,final_steps_cum,final_returns,final_steps]=scoopdy(clusterlog, returnlog,stepslog, p)
% final_returns={};
% final_steps={};
s=length(clusterlog{1})+1;
for i=1:s
returnscoop{i}=[];
end
for i=1:length(clusterlog)%these many runs
    %go through all clusters and assign a tag
    taglog=[];
    for j=1:length(clusterlog{i})
    if sum(round(clusterlog{i}{j}(:,1))==[0;0;0;0])==p.reward_indices
            tag=1;
        elseif sum(round(clusterlog{i}{j}(:,1))==[0;1;0;0])==p.reward_indices
            tag=2;
        elseif sum(round(clusterlog{i}{j}(:,1))==[1;0;0;0])==p.reward_indices
            tag=3;   
        elseif sum(round(clusterlog{i}{j}(:,1))==[0;0;1;0])==p.reward_indices
            tag=4;
        elseif sum(round(clusterlog{i}{j}(:,1))==[1;0;1;0])==p.reward_indices
            tag=5;
        elseif sum(round(clusterlog{i}{j}(:,1))==[0;0;0;1])==p.reward_indices
            tag=6;
        elseif sum(round(clusterlog{i}{j}(:,1))==[1;0;0;1])==p.reward_indices
            tag=7;
    end
    taglog=[taglog tag];
    end      
    %use the tags in taglog to arrange returns according to clusters   
    returnuns=returnlog{i};%unsorted return vector
    stepuns=stepslog{i};
%     taglog
    taglog=[taglog setdiff(1:7, taglog)];
%     taglog
%     pause
    for kk=1:length(returnuns)
        if length(returnuns{kk})<8
            returnuns{kk}((length(returnuns{kk})+1):8)=-10000;
            stepuns{kk}((length(stepuns{kk})+1):8)=1000;
        end
        returnsorted=[];
        stepsorted=[];
        for kkk=1:length(taglog)%(length(returnuns{kk})-1)
%             length(returnuns{kk})
%             1+taglog(kkk)
            ind=find((taglog==kkk));
            returnsorted=[returnsorted returnuns{kk}(1+ind)];%because 1st element of returnuns corresponds to w
            stepsorted=[stepsorted stepuns{kk}(1+ind)];
        end
        returnsortedall{kk}=[returnuns{kk}(1) returnsorted];
        stepsortedall{kk}=[stepuns{kk}(1) stepsorted];
    end
    returnsortedlog{i}=returnsortedall;
    stepsortedlog{i}=stepsortedall;

end


%%%%
final_ret_cum=zeros(1000,8);
final_steps_cum=zeros(1000,8);
for k=1:length(returnsortedlog)
for ii=1:length(returnsortedlog{k})
    l(ii)=length(returnsortedlog{k}{ii});
end
maxl=max(l);
ret_all=[];
step_all=[];
returnsortedsample=returnsortedlog{k};
stepsortedsample=stepsortedlog{k};
for i=1:length(returnsortedsample)
    for j=1:8
        ret(j)=returnsortedsample{i}(j);
        st(j)=stepsortedsample{i}(j);
    end
    ret_all=[ret_all;ret];
    step_all=[step_all;st];
end
final_returns{k}=ret_all;
final_steps{k}=step_all;
final_ret_cum=[final_ret_cum+ret_all];
final_steps_cum=[final_steps_cum+step_all];
end