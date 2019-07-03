function [LDRs]=LDR_sense(pos,light,tol)

if norm([pos(1) pos(2)]-[light(1) light(2)])<tol% || norm([pos(1) pos(2)]-[3 25])<3
if rand<0.95    
LDR_top=1;
else LDR_top=0;
end
else LDR_top=0;
end

if pos(3)>0&&pos(3)<=180&&LDR_top>0
LDR_front=1;
else LDR_front=0;
end


LDRs=[LDR_top];