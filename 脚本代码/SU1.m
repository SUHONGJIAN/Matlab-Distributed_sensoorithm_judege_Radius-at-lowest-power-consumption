number_max = 100;
flag = 0;
rate = zeros(1,50);
r=0.02:0.02:1;
n = 60;

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
                    hold on
                end
            end
        end
        break;
    end
end
axis([0,1,0,1]);

str = ['（N=',num2str(n),'）最低功耗下的拓扑图'];
title(str);
text(1,1,'最小R值');
text(1.05,0.95,num2str(result_r));
xlabel('axis-x值');
ylabel('axis-y值');