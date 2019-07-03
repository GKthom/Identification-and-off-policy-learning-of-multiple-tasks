function [ranges]=range_sensor(state,world)
theta=state(3);
x=state(1);
y=state(2);
r=1;
IR_angle=72;
s=size(world);
if x+r*cosd(theta)>=s(1)||x+r*cosd(theta)<=1||y+r*sind(theta)>=s(2)||y+r*sind(theta)<=1
    if rand<0.95
    IR_C=1;
    else IR_C=0;
    end
elseif world(round(x+r*cosd(theta)),round(y+r*sind(theta)))==1
    IR_C=1;
else IR_C=0;
end

if x+r*cosd(theta+IR_angle)>=s(1)||x+r*cosd(theta+IR_angle)<=1||y+r*sind(theta+IR_angle)>=s(2)||y+r*sind(theta+IR_angle)<=1
    if rand<0.95
    IR_L=1;
    else IR_L=0;
    end
elseif world(round(x+r*cosd(theta+IR_angle)),round(y+r*sind(theta+IR_angle)))==1
    IR_L=1;
else IR_L=0;
end

if x+r*cosd(theta-IR_angle)>=s(1)||x+r*cosd(theta-IR_angle)<=1||y+r*sind(theta-IR_angle)>=s(2)||y+r*sind(theta-IR_angle)<=1
    if rand<0.95
    IR_R=1;
    else IR_R=0;
    end
elseif world(round(x+r*cosd(theta-IR_angle)),round(y+r*sind(theta-IR_angle)))==1
    IR_R=1;
else IR_R=0;
end

ranges=[IR_L;IR_C; IR_R];