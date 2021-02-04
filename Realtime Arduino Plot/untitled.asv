s = serial('COM3','Baudrate',115200);
fopen(s);
accX=0;accY=0;
str='';
sen=0;
j=1;
x=0;

while(j<10000)
    str=fscanf(s);
    sen=str2double(str);
    accX(j)=sen(1);
    accY(j)=sen(2);
    x(j)=j;
    if(j>200)
        x1=x(j-200:j);
        accX1=accX(j-200:j);
        accY1=accY(j-200:j);
        
        xmin=j-200;
        xmax=j;
    else
        x1=x;
        accX1=accX;
        accY1=accY;
        
        xmin=0;
        xmax=100;
    end
    
    plot(x1,accX1,'-r',x1,accY1,'g');
    %plot(x1,accX1,’-r’);
    
    axis([xmin xmax 0 100]);
    % axis([xmin xmax 1000 1000]);
    
    grid on
    title('Grafik Sensor');
    xlabel('Sampling yang ke');
    ylabel('Nilai Sensor');
    
    drawnow;
    j=j+1;
    
end
%grid on
%title(‘Grafik Sensor’);
%xlabel(‘Sampling yang ke’);
%ylabel(‘Nilai Sensor’);
%fclose(s);
% delete(s);
% clear s;