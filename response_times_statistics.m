%% Run the statistics on the python grouped data 

T = readtable('dataCleaned_4subj.csv');

%% subject 1

sub1_response = T.responseTime_ms_(T.Subject==1);
sub1_group = T.experiment(T.Subject==1);

x = sub1_response(strcmp(sub1_group,'200 ms '));
y = sub1_response(strcmp(sub1_group,'tactor'));

% test for equal variance
vartestn(sub1_response,sub1_group,'TestType','BrownForsythe')

% rank sum
[p,table,stats] = ranksum(x,y)


%% subject 2

sub2_response = (T.responseTime_ms_(T.Subject==2));
sub2_group = T.experiment(T.Subject==2);

% test for normality
vartestn(sub2_response,sub2_group,'TestType','BrownForsythe')

% kruskal wallis with postoc Dunn-Sidak
[p,table,stats] = kruskalwallis(sub2_response,sub2_group);
[c,m,h,nms] = multcompare(stats,'ctype','dunn-sidak');
c((c(:,6)<0.05),[1 2 6])


%% subject 3

sub3_response = (T.responseTime_ms_(T.Subject==3 & ~ismember(T.experiment,'100 ms ')));
sub3_group = T.experiment(T.Subject==3 & ~ismember(T.experiment,'100 ms '));

% test for equal variances
vartestn(sub3_response,sub3_group,'TestType','BrownForsythe')

% kruskal wallis with postoc Dunn-Sidak
[p,table,stats] = kruskalwallis(sub3_response,sub3_group);
[c,m,h,nms] = multcompare(stats,'ctype','dunn-sidak');
c((c(:,6)<0.05),[1 2 6])

%% subject 4 

sub4_response = (T.responseTime_ms_(T.Subject==4 & ~ismember(T.experiment,'100 ms ')));
sub4_group = T.experiment(T.Subject==4 & ~ismember(T.experiment,'100 ms '));

% test for normality
vartestn(sub4_response,sub4_group,'TestType','BrownForsythe')

% kruskal wallis with postoc Dunn-Sidak
[p,table,stats] = kruskalwallis(sub4_response,sub4_group);
[c,m,h,nms] = multcompare(stats,'ctype','dunn-sidak');
c((c(:,6)<0.05),[1 2 6])
%% compare blocks
% subject 2 
% bonferroni - 5 tests, so 
n = 5;
p = 0.05; 
bonf = p/n;

condsInt2 = unique(T.experiment);

for i = 1:length(condsInt2)
    i
    sub2_block1 = T.responseTime_ms_(T.Subject==2 & ismember(T.experiment,condsInt2{i}) & T.block == 1);
    sub2_block2 = T.responseTime_ms_(T.Subject==2 & ismember(T.experiment,condsInt2{i}) & T.block == 2);

    [p,h,stats] = ranksum(sub2_block1,sub2_block2,'alpha',bonf);
    p
    h
    %table
    %stats
end

%%
% discount 100 ms for subject 3
n = 4;
p = 0.05; 
bonf = p/n;

condsInt3 = unique(T.experiment(~ismember(T.experiment,'100 ms ')));

for i = 1:length(condsInt3)
    i
        sub3_block1 = T.responseTime_ms_(T.Subject==3 & ismember(T.experiment,condsInt3{i}) & T.block == 1);
    sub3_block2 = T.responseTime_ms_(T.Subject==3 & ismember(T.experiment,condsInt3{i}) & T.block == 2);

    [p,h,stats] = ranksum(sub3_block1,sub3_block2,'alpha',bonf);
    p
    h
    %table
    %stats
    
end


%%
% discount 100 ms for subject 4 as well 

n = 4;
p = 0.05; 
bonf = p/n;

condsInt4 = unique(T.experiment(~ismember(T.experiment,'100 ms ')));

for i = 1:length(condsInt3)
    i
        sub4_block1 = T.responseTime_ms_(T.Subject==4 & ismember(T.experiment,condsInt4{i}) & T.block == 1);
    sub4_block2 = T.responseTime_ms_(T.Subject==4 & ismember(T.experiment,condsInt4{i}) & T.block == 2);

    [p,h,stats] = ranksum(sub4_block1,sub4_block2,'alpha',bonf);
    p
    h
    %table
    %stats
    
end

%% table

statarray=grpstats(T,{'experiment','Subject','block'},'mean','DataVars','responseTime_ms_')

statarray2=grpstats(T,{'experiment','Subject'},'mean','DataVars','responseTime_ms_')


