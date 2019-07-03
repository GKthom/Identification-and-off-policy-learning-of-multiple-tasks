clear
close all
clc

S=zeros();
explore=[0.1 0.3 0.7 0.9];
%%%%%%%%%%%%%%
load light_initial_count01
subplot(3,1,1)
scatter(explore(1),mean(countlog),500,[1 0.8 0],'filled','p')
axis([0 1 0 2000])
hold on
load light_initialcount_03
subplot(3,1,1)
scatter(explore(2),mean(countlog),500,[1 0.8 0],'filled','p')
axis([0 1 0 2000])
hold on
load light_initialcount_07
subplot(3,1,1)
scatter(explore(3),mean(countlog),500,[1 0.8 0],'filled','p')
axis([0 1 0 2000])
hold on
load light_initialcount_09
subplot(3,1,1)
scatter(explore(4),mean(countlog),500,[1 0.8 0],'filled','p')
axis([0 1 0 2000])
hold on


load light_final_with_rough01
subplot(3,1,2)
scatter(explore(1),mean(countlog),500,[1 0.8 0],'p')
axis([0 1 0 2000])
hold on

load light_final_with_rough03
subplot(3,1,2)
scatter(explore(2),mean(countlog),500,[1 0.8 0],'p')
axis([0 1 0 2000])
hold on

load light_final_with_rough07
subplot(3,1,2)
scatter(explore(3),mean(countlog),500,[1 0.8 0],'p')
axis([0 1 0 2000])
hold on

load light_final_with_rough09
subplot(3,1,2)
scatter(explore(4),mean(countlog),500,[1 0.8 0],'p')
axis([0 1 0 2000])
hold on

load light_final_with_targ01
subplot(3,1,3)
scatter(explore(1),mean(countlog),500,[1 0.8 0],'p')
axis([0 1 0 2000])
hold on

load light_final_with_targ03
subplot(3,1,3)
scatter(explore(2),mean(countlog),500,[1 0.8 0],'p')
axis([0 1 0 2000])
hold on

load light_final_with_targ07
subplot(3,1,3)
scatter(explore(3),mean(countlog),500,[1 0.8 0],'p')
axis([0 1 0 2000])
hold on

load light_final_with_targ09
subplot(3,1,3)
scatter(explore(4),mean(countlog),500,[1 0.8 0],'p')
axis([0 1 0 2000])
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%
load rough_initial_count01
subplot(3,1,2)
scatter(explore(1),mean(countlog),500,'r','filled','s')
axis([0 1 0 2000])
hold on
load rough_initialcount_03
subplot(3,1,2)
scatter(explore(2),mean(countlog),500,'r','filled','s')
axis([0 1 0 2000])
hold on
load rough_initialcount_07
subplot(3,1,2)
scatter(explore(3),mean(countlog),500,'r','filled','s')
axis([0 1 0 2000])
hold on
load rough_initialcount_09
subplot(3,1,2)
scatter(explore(4),mean(countlog),500,'r','filled','s')
axis([0 1 0 2000])
hold on


load rough_final_with_light01
subplot(3,1,1)
scatter(explore(1),mean(countlog),500,'r','s')
axis([0 1 0 2000])
hold on

load rough_final_with_light03
subplot(3,1,1)
scatter(explore(2),mean(countlog),500,'r','s')
axis([0 1 0 2000])
hold on

load rough_final_with_light07
subplot(3,1,1)
scatter(explore(3),mean(countlog),500,'r','s')
axis([0 1 0 2000])
hold on

load rough_final_with_light09
subplot(3,1,1)
scatter(explore(4),mean(countlog),500,'r','s')
axis([0 1 0 2000])
hold on

load rough_final_with_targ01
subplot(3,1,3)
scatter(explore(1),mean(countlog),500,'r','s')
axis([0 1 0 2000])
hold on

load rough_final_with_targ03
subplot(3,1,3)
scatter(explore(2),mean(countlog),500,'r','s')
axis([0 1 0 2000])
hold on

load rough_final_with_targ07
subplot(3,1,3)
scatter(explore(3),mean(countlog),500,'r','s')
axis([0 1 0 2000])
hold on

load rough_final_with_targ09
subplot(3,1,3)
scatter(explore(4),mean(countlog),500,'r','s')
axis([0 1 0 2000])
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%
load targ_initial_count01
subplot(3,1,3)
scatter(explore(1),mean(countlog),200,'b','filled','^')
axis([0 1 0 2000])
hold on
load targ_initialcount_03
subplot(3,1,3)
scatter(explore(2),mean(countlog),200,'b','filled','^')
axis([0 1 0 2000])
hold on
load targ_initialcount_07
subplot(3,1,3)
scatter(explore(3),mean(countlog),200,'b','filled','^')
axis([0 1 0 2000])
hold on
load targ_initialcount_09
subplot(3,1,3)
scatter(explore(4),mean(countlog),200,'b','filled','^')
axis([0 1 0 2000])
hold on


load targ_final_with_light01
subplot(3,1,1)
scatter(explore(1),mean(countlog),200,'b','^')
axis([0 1 0 2000])
hold on

load targ_final_with_light03
subplot(3,1,1)
scatter(explore(2),mean(countlog),200,'b','^')
axis([0 1 0 2000])
hold on

load targ_final_with_light07
subplot(3,1,1)
scatter(explore(3),mean(countlog),200,'b','^')
axis([0 1 0 2000])
hold on

load targ_final_with_light09
subplot(3,1,1)
scatter(explore(4),mean(countlog),200,'b','^')
axis([0 1 0 2000])
hold on

load targ_final_with_rough01
subplot(3,1,2)
scatter(explore(1),mean(countlog),200,'b','^')
axis([0 1 0 2000])
hold on

load targ_final_with_rough03
subplot(3,1,2)
scatter(explore(2),mean(countlog),200,'b','^')
axis([0 1 0 2000])
hold on

load targ_final_with_rough07
subplot(3,1,2)
scatter(explore(3),mean(countlog),200,'b','^')
axis([0 1 0 2000])
hold on

load targ_final_with_rough09
subplot(3,1,2)
scatter(explore(4),mean(countlog),200,'b','^')
axis([0 1 0 2000])
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%