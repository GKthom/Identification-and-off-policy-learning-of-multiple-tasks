function [Q]=Q_val(state,action,w,p)

[S]=sense_world(state,p);
Q=w(:,action)'*S;