function [NSS]=NSS(Data,r)
%函数计算样本点的半径之内所有点的和，用于后期衡量两个样本点的相似度
%函数输入为Data和半径
%横坐标求和得出邻居相似度值
    [row col]=size(Data);
    
    for i=1:row
        distance=0;
        sum=0;
        cnt=0;
        for j=1:row
            distance=sqrt((Data(i,1)-Data(j,1))*(Data(i,1)-Data(j,1))+(Data(i,2)-Data(j,2))*(Data(i,2)-Data(j,2)));
            if(distance<=r)
                sum=sum+Data(j,1);
                cnt=cnt+1;
            end
        end
        NSS(i,1)=sum;
        sum=0;
    end
end