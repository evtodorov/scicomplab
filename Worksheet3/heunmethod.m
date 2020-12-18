function y =heunmethod(fy,dfydy,y0,dt,tend)
n=tend/dt+1;
y=zeros(n,1);%Initialize output vector

y1=y0;
y(1,1)=y1;
for t=2:n
    fP1=feval(fy,y1);%calculate f'(y1)
    y2euler=y1+dt*fP1;%Use Euler method to calculate Y2
    fP2=feval(fy,y2euler);%calculate f'(y2) 
    y2heun=y1+(dt*1/2*(fP1+fP2));%clculate Y2 Using Heun method
    y1=y2heun;%set y1=y2
    y(t,1)=y1;%add y1 to vector
    
end
 y=y';
end

