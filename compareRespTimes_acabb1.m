sid = 'acabb1';
load([sid,'_compareResponse.mat'])

respHi = respHi;
respLo = respLo;
tactorLocsVecTactTrim = tactorLocsVecTact(tactorLocsVecTact>respLo & tactorLocsVecTact<respHi);
buttonTactDiffTrim = buttonTactDiff(buttonTactDiff>respLo & buttonTactDiff<respHi);
buttonLocsVecCortTrim = buttonLocsVecCort(buttonLocsVecCort>respLo & buttonLocsVecCort<respHi );

zTact = zscore(tactorLocsVecTactTrim);
zDiff = zscore(buttonTactDiffTrim);
zCort = zscore(buttonLocsVecCortTrim);

%tactor = 1e3.*tactorLocsVecTactTrim(abs(zTact)<3);
%difference = 1e3.*buttonTactDiffTrim(abs(zDiff)<3);
%cort = 1e3.*buttonLocsVecCortTrim(abs(zCort)<3);

tactor = 1e3.*tactorLocsVecTactTrim;
difference = 1e3.*buttonTactDiffTrim;
cort = 1e3.*buttonLocsVecCortTrim;

current_direc = pwd;

%% BOX PLOT

combinedInfo = cat(1,cort,difference,tactor);
groups = cat(1,2.*ones(length(cort),1),ones(length(difference),1),0.*ones(length(tactor),1));
figure
prettybox(combinedInfo,groups,[1 0 0; 0 0 1; 0 1 0],1,1)
fig1 = gca;

fig1.XTick = [];
legend(findobj(gca,'Tag','Box'),'Cortical Stimulation Response Times','Tactor Response Time','Experimenter Response Time')
ylabel('Response times (ms)')
title('Reaction Times')

%% HISTOGRAM

figure
nbins = 15;
a = histogram(cort,nbins);
a.FaceColor = [0 1 0];
hold on
b = histogram(tactor,nbins);
b.FaceColor = [0 0 1];

hold on
c = histogram(difference,nbins);
c.FaceColor = [1 0 0];

title('Histogram of response Times')
legend({'Cortical Stimulation Response Times','Tactor Response Time','Experimenter Response Time'})
xlabel('Response time (ms)')
ylabel('Count')


%% kruskal wallis 
combinedInfo = cat(1,cort,difference);
groups = cat(1,2.*ones(length(cort),1),ones(length(difference),1));
pKruskal = kruskalwallis(combinedInfo,groups);
[hKolmogorov,pKolmogorov] = kstest2(cort,difference);
pRank = ranksum(cort,difference);


 %% BOX PLOT - just rxn times

figure
prettybox(combinedInfo,groups,[1 0 0; 0 0 1],1,1)
sigstar({[1,2]},[pRank])
fig1 = gca;

fig1.XTick = [];
legend(findobj(gca,'Tag','Box'),'Cortical Stimulation Response Times','Tactor Response Time')
ylabel('Response times (ms)')
title('Reaction Times')

%% HISTOGRAM - just rxn times 

figure
nbins = 15;
a = histogram(cort,nbins);
a.FaceColor = [0 0 1];
hold on

hold on
c = histogram(difference,nbins);
c.FaceColor = [1 0 0];

title('Histogram of response Times')
legend({'Cortical Stimulation Response Times','Tactor Response Time'})
xlabel('Response time (ms)')
ylabel('Count')
