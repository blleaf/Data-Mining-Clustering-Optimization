function [dist]=Distance(xx)
    ND=max(xx(:,2)); NL=max(xx(:,1));  
    if (NL>ND)  
      ND=NL;      %确保 DN 取为第一二列最大值中的较大者，并将其作为数据点总数  
    end  
    N=size(xx,1); %xx 第一个维度的长度，相当于文件的行数（即距离的总个数）  

    for i=1:ND  
      for j=1:ND  
        dist(i,j)=0;  
      end  
    end   
    
    for i=1:N  
      ii=xx(i,1);  
      jj=xx(i,2);  
      dist(ii,jj)=xx(i,3);  
      dist(jj,ii)=xx(i,3);  
    end
end