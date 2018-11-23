number_max = 100;
flag = 0;
rate = zeros(1,50);
r=0.02:0.02:1;
n = 50;
for k=1:1:50
    for number=1:1:number_max
        flag_overflow=1;
        x=rand(n,1);
        y=rand(n,1);
        p = zeros(n,n);
        for num=1:1:n
            for sec_num=1:1:n
                if(sqrt((x(num)-x(sec_num))^2+(y(num)-y(sec_num))^2)<r(k))
                    p(num,sec_num)=1;
                else
                    p(num,sec_num)=0;
                end
            end
        end
        t=p;
        for s=1:1:n-1
            t=t*p;
        end
        for i=1:1:n
            for j=1:1:n
                if t(i,j)<=0
                    flag_overflow=0;
                    break;
                end
            end
            if flag_overflow==0
                break;
            end
        end
        rate(k)=rate(k)+flag_overflow;
    end 
    rate(k)=rate(k)/number_max;
    if rate(k) == 1
        result_r = r(k);
        for num=1:1:n
            for sec_num=1:1:n
                if(sqrt((x(num)-x(sec_num))^2+(y(num)-y(sec_num))^2)<r(k)) && num ~= sec_num
                    plot([x(num),x(sec_num)],[y(num),y(sec_num)],'-sk');
                    alpha=0:pi/20:2*pi;
                    s=x(num)+result_r*cos(alpha);
                    u=y(num)+result_r*sin(alpha);
                    plot(s,u,'k-');
                    axis equal;
                    fill(s,u,'k');
                    rectangle('Position',[x(num)-result_r,y(num)-result_r,2*result_r,2*result_r],'Curvature', [1,1]);
                    hold on
                end
            end
        end
        break;
    end
end
axis([0,1,0,1]);


t = 0;
x = rand(n,1);
y = rand(n,1);
for axis_x = 0.01 : 0.01 : 1
    for axis_y = 0.01 : 0.01 : 1
        for i = 1 : n
        if sqrt((axis_x-x(i))^2+(axis_y-y(i))^2)<result_r
            t = t + 1;
            break;
        end
        end
    end
end
con = t/10000;
for num=1:1:n
    for sec_num=1:1:n
        if(sqrt((x(num)-x(sec_num))^2+(y(num)-y(sec_num))^2)<r(k)) && num ~= sec_num
            plot([x(num),x(sec_num)],[y(num),y(sec_num)],'-sk');
            hold on
        end
    end
end

str = ['最低功耗下通信覆盖面积'];
title(str);
xlabel('axis-x值');
ylabel('axis-y值');
