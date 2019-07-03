function [Q_map,Q_map_all]=gen_Q_map(w,world,light,rough,target_pos,a,b,A,tol)

for i=1:a
    for j=1:b
        for k=1:A
            Q_map_all(i,j,k)=Q_val([i j 0],k,w,world,light,rough,target_pos,tol,a,b);
        end
        Q_map(i,j)=max(Q_map_all(i,j,:));
    end
end

Q_map=(Q_map-min(min(Q_map)));
Q_map=Q_map/max(max(Q_map));
imshow(imrotate(Q_map,90))