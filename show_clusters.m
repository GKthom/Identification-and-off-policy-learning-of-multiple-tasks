function [im]=show_clusters(clusters,p)


s=size(p.world);

for i=1:s(1)

for j=1:s(2)

[S]=sense_world([i j rand*360],p);
sensor_reading=rewardfeats(S,p);%S{cluster_select};
stats=clusters;
col=distinguishable_colors(length(stats));
d=[];
for k=1:length(stats)
d(k)=norm([sensor_reading]-[stats{k}(:,1)]);
c=argmin(d);
im(i,j,1:3)=col(c,:);
end

end

end
% count=1;
% for jj=0:10:360
% 
%     for i=1:s(1)
% 
%         for j=1:s(2)
% 
% 
%         [S]=sense_world([i j jj],world,light,rough,target_pos,tol,x,y);
%         sensor_reading=rewardfeats(S,reward_indices);%S{cluster_select};
%         stats=clusters;
%         col=distinguishable_colors(length(stats));
%         d=[];
%         for k=1:length(stats)
%             d(k)=norm([sensor_reading]-[stats{k}(:,1)]);
%             c=argmin(d);
%             im(i,j,1:3)=col(c,:);
%         end
%         
%     
%     
%         end
%     end
%     jj
%     IM(count).image=rgb2gray(im);
%     count=count+1;
% end
% stackQ(IM,length(stats))