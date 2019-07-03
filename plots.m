clear all
clc
close all

% load target_prim
% load light_prim
% load rough_prim

target_prim=[24 58.14 38.5;30 61 57;60 14.3 17.66;100 2.12 1.34];
light_prim=[48.57 23.85 36;82.22 29 45;130 23 59;187.5 1.33 1.76];
rough_prim=[32.22 29.57 45; 62 31 51;70 11 7; 156.66 4.33 1];


explore=[0.1 0.3 0.7 1];
% 
% s_t=size(target_prim);
% subplot(3,1,1)
% for i=1:s_t(1)
%     scatter(explore(i),target_prim(i,1),200,'b','filled','^')
%     hold on
% end
% 
% for i=1:s_t(1)
%     scatter(explore(i),target_prim(i,2),500,'r','s')
%     hold on
% end
% 
% for i=1:s_t(1)
%     scatter(explore(i),target_prim(i,3),500,[1 0.8 0],'p')
%     hold on
% end
% 
% subplot(3,1,2)
% s_l=size(light_prim);
% for i=1:s_l(1)
%     scatter(explore(i),light_prim(i,1),500,[1 0.8 0],'filled','p')
%     hold on
% end
% 
% for i=1:s_l(1)
%     scatter(explore(i),light_prim(i,2),200,'b','^')
%     hold on
% end
% 
% for i=1:s_l(1)
%     scatter(explore(i),light_prim(i,3),500,'r','s')
%     hold on
% end
% 
% subplot(3,1,3)
% s_r=size(rough_prim);
% for i=1:s_r(1)
%     scatter(explore(i),rough_prim(i,1),500,'r','filled','s')
%     hold on
% end
% 
% for i=1:s_r(1)
%     scatter(explore(i),rough_prim(i,2),200,'b','^')
%     hold on
% end
% 
% for i=1:s_r(1)
%     scatter(explore(i),rough_prim(i,3),500,[1 0.8 0],'p')
%     hold on
% end


s_r=1;


for i=1:s_r(1)
    scatter(explore(i),rough_prim(i,1),200,'b','filled','^')
    hold on
    scatter(explore(i),rough_prim(i,2),200,'b','^')
    hold on
end

for i=1:s_r(1)
    scatter(explore(i),rough_prim(i,1),500,[1 0.8 0],'filled','p')
    hold on
    scatter(explore(i),rough_prim(i,3),500,[1 0.8 0],'p')
    hold on
end

for i=1:s_r(1)
    scatter(explore(i),rough_prim(i,1),500,'r','filled','s')
    hold on
    scatter(explore(i),rough_prim(i,1),500,'r','s')
    hold on
end

