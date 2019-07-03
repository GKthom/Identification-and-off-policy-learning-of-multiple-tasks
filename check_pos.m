function [pos_flag]=check_pos(target_pos,pos,tol)
% % Uncomment for treating x and y as separate
% if abs((target_pos(1)-pos(1)))<=3
%    pos_flag(1)=1;
% else pos_flag(1)=0;
% end 
% 
% if abs((target_pos(2)-pos(2)))<=3
%    pos_flag(2)=1;
% else pos_flag(2)=0;
% end
if abs(norm([pos(1) pos(2)]-[target_pos(1) target_pos(2)]))<tol
    pos_flag=1;
else pos_flag=0;
end
pos_flag=pos_flag';