function [bumpy]=IMU(pos,rough,tol)

if norm([pos(1) pos(2)]-[rough(1) rough(2)])<tol
    if rand<0.95
        bumpy=1;
    else bumpy=0;
    end
else bumpy=0;
end