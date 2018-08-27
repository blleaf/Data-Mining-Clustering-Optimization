clear;
%load('Mfeat.mat');
Data1 = importdata('flame_cluster=2.txt');
xx1=importdata('flame_dist.txt');

Data2 = importdata('Jain_cluster=2.txt');
xx2=importdata('jain_dist.txt');

Data3 = importdata('Pathbased_cluster=3.txt');
xx3=importdata('path_dist.txt');

Data4 = importdata('Spiral_cluster=3.txt');
xx4=importdata('spiral_dist.txt');

Data5 = importdata('Aggregation_cluster=7.txt');
xx5=importdata('agg_dist.txt');

%Data6=data_fou;

%[row col]=size(Data2);

%DenPeak(数据集，半径，聚类个数)
[cla_data,flag,rho,ord_rho]=DenPeak(Data3,xx3);
%Compare(Data4,cla_data);



