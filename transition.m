function [new_state]=transition(state,action,p)

dt=0.2;
v=8;
noise=((0.5-(-0.5))/randi(100))-0.5;%random no. b/w -0.5 and 0.5
if action==1%Move up
    if rand<p.tran_prob
        new_state(2)=state(2)+v*dt;
        new_state(1)=state(1);
        new_state(3)=90;
    else
        new_state(2)=state(2)+v*dt*noise;
        new_state(1)=state(1)+noise;
        new_state(3)=90;
    end
elseif action==2%Move right
    if rand<p.tran_prob
        new_state(1)=state(1)+v*dt;
        new_state(2)=state(2);
        new_state(3)=0;
    else
        new_state(1)=state(1)+v*dt*noise;
        new_state(2)=state(2)+noise;
        new_state(3)=0;
    end
elseif action==3%Move down
    if rand<p.tran_prob
        new_state(2)=state(2)-v*dt;
        new_state(1)=state(1);
        new_state(3)=-90;
    else
        new_state(2)=state(2)-v*dt*noise;
        new_state(1)=state(1)+noise;
        new_state(3)=-90;
    end
elseif action==4%Move left
    if rand<p.tran_prob
        new_state(1)=state(1)-v*dt;
        new_state(2)=state(2);
        new_state(3)=180;
    else
        new_state(1)=state(1)-v*dt*noise;
        new_state(2)=state(2)+noise;
        new_state(3)=180;
    end
elseif action==5%Move diagonally right and up
    if rand<p.tran_prob
        new_state(1)=state(1)+v*dt;
        new_state(2)=state(2)+v*dt;
        new_state(3)=45;
    else
        new_state(1)=state(1)+v*dt*noise;
        new_state(2)=state(2)+v*dt*noise;
        new_state(3)=45;
    end
elseif action==6%Move diagonally left and up
    if rand<p.tran_prob
        new_state(1)=state(1)-v*dt;
        new_state(2)=state(2)+v*dt;
        new_state(3)=135;
    else
        new_state(1)=state(1)-v*dt*noise;
        new_state(2)=state(2)+v*dt*noise;
        new_state(3)=135;
    end
elseif action==7%Move diagonally right and down
    if rand<p.tran_prob
        new_state(1)=state(1)+v*dt;
        new_state(2)=state(2)-v*dt;
        new_state(3)=-45;
    else
        new_state(1)=state(1)+v*dt*noise;
        new_state(2)=state(2)-v*dt*noise;
        new_state(3)=-45;
    end
elseif action==8%Move diagonally left and down
    if rand<p.tran_prob
        new_state(1)=state(1)-v*dt;
        new_state(2)=state(2)-v*dt;
        new_state(3)=-135;
    else
        new_state(1)=state(1)-v*dt*noise;
        new_state(2)=state(2)-v*dt*noise;
        new_state(3)=-135;
    end
elseif action==9%Stay put
    if rand<p.tran_prob
        new_state(1)=state(1);
        new_state(2)=state(2);
        new_state(3)=state(3);
    else
        new_state(1)=state(1)+noise;
        new_state(2)=state(2)+noise;
        new_state(3)=state(3);
    end
end



if abs(new_state(1))>=p.a||(new_state(1))<1||abs(new_state(2))>=p.b||(new_state(2))<1||p.world(round(new_state(1)),round(new_state(2)))==1
    new_state=state;
end