function [I]=stackQ(IM,n_clust)
%# create stacked images (I am simply repeating the same image 5 times)
% count=1;
 for i=1:length(IM)
     I(:,:,i)=256*IM(i).image;
%      count=count+1;
 end

%# coordinates

[X,Y] = meshgrid(1:size(I,2), 1:size(I,1));

Z = ones(size(I,1),size(I,2));

 

%# plot each slice as a texture-mapped surface (stacked along the Z-dimension)

for k=1:size(I,3)
    surface('XData',X-0.5, 'YData',Y-0.5, 'ZData',Z.*k, ...
        'CData',I(:,:,k), 'CDataMapping','direct', ...
        'EdgeColor','none', 'FaceColor','texturemap')
end
cmap=distinguishable_colors(n_clust);
colormap(gray)
% colormap(gray)
view(3), box on, axis tight square

set(gca, 'YDir','reverse', 'ZLim',[0 size(I,3)+1])