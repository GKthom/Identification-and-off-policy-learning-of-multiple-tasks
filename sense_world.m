function [S]=sense_world(pos,p)

IRs=range_sensor(pos,p.world);

LDRs=LDR_sense(pos,p.light,p.tol);

bumpy=IMU(pos,p.rough,p.tol);

pos_flag=check_pos(p.target_pos,pos,p.tol);

x_feat=zeros(p.nfeatsa,1);
y_feat=zeros(p.nfeatsb,1);
x_ind=round(pos(1));
y_ind=round(pos(2));
x_feat(x_ind)=1;
y_feat(y_ind)=1;

if sum(IRs)>0
    IR_flag=1;
else IR_flag=0;
end


S=[IR_flag; LDRs; bumpy; pos_flag;x_feat;y_feat];

% pos_x=(30*round(pos(1)/x))+1;
% pos_y=(30*round(pos(2)/y))+1;
% 
% pos_x_walls=zeros(31,1);
% pos_y_walls=zeros(31,1);
% 
% pos_x_walls(pos_x)=1;
% pos_y_walls(pos_y)=1;
% 
% pos_walls=[pos_x_walls;pos_y_walls];
% 
% S=[IR_flag; LDRs; bumpy; pos_flag;pos_walls];