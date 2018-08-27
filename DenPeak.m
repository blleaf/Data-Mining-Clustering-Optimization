function [idx,flag,rho,ord_rho]=DenPeak(data,xx);
    ND=max(max(xx(:,1:2)));
    N=size(xx,1);                  %距离的总个数
    dist=zeros(ND,ND);
    [dist]=Distance(xx);

    % 确定 dc   
    percent=8;                     %Data1 and Data3：8 | Data2：1
    position=round(N*percent/100); %四舍五入  
    ord_dist=sort(xx(:,3));        % 对所有距离值作升序排列  
    dc=ord_dist(position);

    % 将每个数据点的ρ值初始化为零  
    rho=zeros(1,ND); flag=zeros(1,ND);
    
    
    %k邻近
    k=100;
    [threshold,kdist,tmpdist]=Threshold(data,k); %计算阈值用于标记离群点和非离群点
    %[rho,flag]=Rho(data,dist,dc,xx,threshold);  %优化前
    [rho,flag]=Rho(data,dist,dc,xx,threshold);   %优化后

    % 先求矩阵列最大值，再求最大值，最后得到所有距离值中的最大值  
    maxd=max(max(dist));   

    % rho 按降序排列，ordrho保存原序列的序列标号  
    [rho_sorted,ord_rho]=sort(rho,'descend');  

    % 处理 rho 值最大的数据点  
    delta(ord_rho(1))=-1.;  
    neighbor(ord_rho(1))=0;                      %因为ordrho(1)的局部密度最大，因此neighbor不存在

    % 生成 delta 和 neighbor 数组  
    for ii=2:ND  
       delta(ord_rho(ii))=maxd;                  %一开始初始化为全局最大值
       for jj=1:ii-1                             %rho更大说明排的比ii更前，因此只到ii-1
         if(dist(ord_rho(ii),ord_rho(jj))<delta(ord_rho(ii)))  
            delta(ord_rho(ii))=dist(ord_rho(ii),ord_rho(jj));  
            neighbor(ord_rho(ii))=ord_rho(jj);   % 记录 rho 值更大的数据点中与 ordrho(ii) 距离最近的点的编号 ordrho(jj)  
            
         end  
       end  
    end  

    % 生成 rho 值最大数据点的 delta 值  
    delta(ord_rho(1))=max(delta(:));  

    % 利用 rho 和 delta 画出决策图 
    subplot(1,3,1)  
    plot(rho(:),delta(:),'o'); 
    xlabel('ρ'); ylabel('δ'); hold on
    r1=0.90*max(rho); %Data1：0.76/0.66 | Data2：0.9/0.9 | Data3：0.90/0.67
    d1=0.67*max(delta); 
    
    chosen=find(rho>r1&delta>d1);
    plot(rho(chosen),delta(chosen),'r.','MarkerSize',15)

	%绘制Decision Graph样本点分布图
    subplot(1,3,2)
    l=rho.*delta;
    [l_sorted,ordl]=sort(l,'descend');  
    plot((1:ND),l_sorted,'o'); 
    xlabel('n'); ylabel('γ'); 
    NCLUST=0; 

    %初始化类标，全部初始化为-1
    idx=zeros(1,ND);
    for i=1:ND  
      idx(i)=-1;  
    end  
    
    %在设定半径之内计算点与点之间的相似度
    r=1;
    NSS_Data=NSS(data,r);
    a=NSS_Data(chosen);
    lastchosen=chosen;
    
    % 统计聚类中心的个数  
    for i=1:ND  
      if ( (rho(i)>r1) && (delta(i)>d1))         %大于阈值的点被视为中心
          b=NSS_Data(i);
          if(a>=b)
              tmp=a;
              a=b;
              b=tmp;
          end
          
          %相似度过大则跳过该点，继续寻找中心点
          if((a/b)>=1)
              i=i+1;
          else
             NCLUST=NCLUST+1;  
             idx(i)=NCLUST; 
          end
      end  
    end  

    fprintf('Cluster Number: %i \n', NCLUST);  

    % 将其他数据点归类
    for i=1:ND  
      if (idx(ord_rho(i))==-1)                       %非离群点
        idx(ord_rho(i))=idx(neighbor(ord_rho(i)));   %将某个点归到比他局部密度更大的那个点属于的类
      end  
      
%       if (idx(ord_rho(i))==-1 && flag(i)==0)       %非离群点
%         idx(ord_rho(i))=idx(neighbor(ord_rho(i))); %将某个点归到比他局部密度更大的那个点属于的类
%       else
%           idx(ord_rho(i))=idx(neighbor(ord_rho(i)));
%       end  
    end   

    %绘制聚类结果图
    subplot(1,3,3);
    x=data(:,1); y=data(:,2);

    plot(x(find(idx==1)),y(find(idx==1)),'r.','MarkerSize',12)
    hold on  
    plot(x(find(idx==2)),y(find(idx==2)),'g.','MarkerSize',12)  
    plot(x(find(idx==3)),y(find(idx==3)),'b.','MarkerSize',12) 
    plot(x(find(idx==4)),y(find(idx==4)),'y.','MarkerSize',12)  
    plot(x(find(idx==5)),y(find(idx==5)),'m.','MarkerSize',12)  
    plot(x(find(idx==6)),y(find(idx==6)),'k.','MarkerSize',12)  
    plot(x(find(idx==7)),y(find(idx==7)),'c.','MarkerSize',12)  
end
  