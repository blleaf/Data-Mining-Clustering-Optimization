function [rho,flag]=Rho(data,dist,dc,xx,threshold)
%返回该点的密度，以及他是否属于离群点，flag为1代表其属于离群点
    rho=1;
    kNNdist=0; 
    ND=max(max(xx(:,1:2)));
    N=size(xx,1);      %距离的总个数
    rho=zeros(1,ND);
    flag=zeros(1,ND);
    
%局部密度计算传统方法
%     for i=1:ND-1  
%       for j=i+1:ND  
%          rho(i)=rho(i)+exp(-(dist(i,j)/dc)*(dist(i,j)/dc));  
%          rho(j)=rho(j)+exp(-(dist(i,j)/dc)*(dist(i,j)/dc));  
%       end  
%     end 
%     
    
	%局部密度计算改进方法
    %对于每一个样本点
    for i=1:ND
        distance=zeros(ND,1);
        for k=1:ND
            distance(k)=10000;
        end
        
        %扫描以该样本点开头的距离
        for m=1:N
            if(data(i,1)==data(xx(m,1),1)&xx(m,1)~=xx(m,2))
                distance(m)=xx(m,3);
            end
        end
        
        tmp=sort(distance,'ascend');
        k=200;%k邻近
        kNNdist=tmp(k+1);
        tmprho=0;
        for n=1:k
            tmprho=tmprho+exp(-tmp(n));
        end
        
        rho(i)=tmprho;
        
        if(kNNdist>threshold)
            flag(i)=1;
        else
            flag(i)=0;
        end
    end
end