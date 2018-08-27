function [threshold,kdist,tmpdist]=Threshold(Data,k)
    [row col] = size(Data);
    kdist=zeros(row,1);   %存储所有点的kNN距离
    tmpdist=zeros(row,1); %存储一个点到另外所有点的距离
    sum=0;
    for i=1:row
        for j=1:row
                tmpdist(j,1)=sqrt((Data(i,1)-Data(j,1))*(Data(i,1)-Data(j,1))+(Data(i,2)-Data(j,2))*(Data(i,2)-Data(j,2)));
        end
        tmpdist=sort(tmpdist,'ascend');
        kdist(i,1)=tmpdist(k+1,1);
        sum=sum+kdist(i,1);
    end
    threshold=sum/row;
end