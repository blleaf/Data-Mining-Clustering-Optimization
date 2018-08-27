function [] = Compare(Data,cl_data )
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明
    subplot(1,2,1);
    plot(Data(:,1),Data(:,2),'o');  
    [row col]=size(Data);
    subplot(1,2,2)
    for i=1:row
        if cl_data(i,col+1)==1
            plot(cl_data(i,1),cl_data(i,2),'ro');
        elseif cl_data(i,col+1)==2
            plot(cl_data(i,1),cl_data(i,2),'mo');
        elseif cl_data(i,col+1)==3
            plot(cl_data(i,1),cl_data(i,2),'go');
        elseif cl_data(i,col+1)==4
            plot(cl_data(i,1),cl_data(i,2),'co');
        elseif cl_data(i,col+1)==5
            plot(cl_data(i,1),cl_data(i,2),'bo');
        elseif cl_data(i,col+1)==6
            plot(cl_data(i,1),cl_data(i,2),'yo');
        elseif cl_data(i,col+1)==7
            plot(cl_data(i,1),cl_data(i,2),'ko');
        else
            plot(cl_data(i,1),cl_data(i,2),'kx')
        end
        hold on;
end
end

