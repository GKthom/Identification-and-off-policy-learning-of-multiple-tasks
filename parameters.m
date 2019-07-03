function  [out] = parameters()

a=30;
b=30;
parameters.N_runs=5;
parameters.nfeatsa=100;
parameters.nfeatsb=100;
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%World and agent parameters
parameters.break_thresh=15000;
parameters.highreward=100;
parameters.penalty=-100;
parameters.livingpenalty=-10;
parameters.epsilon=0.1;
parameters.alpha=0.3;
parameters.gamma=0.9;
parameters.lambda=0.9;
parameters.light=[20 12];
parameters.rough=[3 25];
target_pos=[28 28];
parameters.target_pos=target_pos;
parameters.tol=3;
parameters.std_dev_tol=1;
parameters.init_var=1;
parameters.n_rewards=5;
parameters.reward_indices=4;
parameters.N_iter=1000;
parameters.a=a;
parameters.b=b;
parameters.tran_prob=0.8;
parameters.A=9;
% parameters.target=[28,28];%[28,2];
% parameters.target2=[21,7];%[3,28];%[28,2];
% parameters.target3=[3,29];%[20,5];
% parameters.target4=[26,27];
start=[randi(a) randi(b) rand*360];
% start=[7 8 0];
%%%%%World%%%%%%
world=zeros(a,b);
world(:,1)=1;
world(:,end)=1;
world(1,:)=1;
world(end,:)=1;
world(13,1:15)=1;
world(5:13,15)=1;
%%%%%%%%%%%%%%
while world(start(1),start(2))==1||(start(1)==target_pos(1)&&(start(2)==target_pos(2)))
    start=[randi(a) randi(b) rand*360];
end
parameters.start=start;
parameters.world=world;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
out=parameters;