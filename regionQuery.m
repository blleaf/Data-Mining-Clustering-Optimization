function [Neighbor] = regionQuery(Point,r,Data)
    [row col]=size(Data);
    Neighbor=[];
    for i=1:row
        if norm(Point-Data(i,:))<=r
            Neighbor=[Neighbor;Data(i,:)];
        end
    end
    
end

