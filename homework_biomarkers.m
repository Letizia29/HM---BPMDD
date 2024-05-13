clear all
close all
clc

%% load data
data = readtable("Patient_Master.csv");

DAT_SCAN_SPECT = [data.DATSCAN_CAUDATE_R data.DATSCAN_CAUDATE_L data.DATSCAN_PUTAMEN_R  data.DATSCAN_PUTAMEN_L data.DATSCAN_PUTAMEN_R_ANT data.DATSCAN_PUTAMEN_L_ANT];
%DAT_SCAN_PET =  [data.AV133_RCAUD_S data.AV133_LCAUD_S data.AV133_RPUTANT_S data.AV133_RPUTPOST_S data.AV133_LPUTANT_S data.AV133_LPUTPOST_S];

ROIs_labels = ["Right Caudate", "Left Caudate", "Right Putamen", "Left Putamen", "Left Anterior Putamen", "Right Anterior Putamen"];

idx_HC = find(string(data.COHORT)=='HC');
HC_DAT_SCAN_SPECT = DAT_SCAN_SPECT(idx_HC,:);

idx_PD = find(string(data.COHORT)=='PD');
PD_DAT_SCAN_SPECT = DAT_SCAN_SPECT(idx_PD,:);

idx_SWEDD = find(string(data.COHORT)=='SWEDD');
SWEDD_DAT_SCAN_SPECT = DAT_SCAN_SPECT(idx_SWEDD,:);

idx_Prodromal = find(string(data.COHORT)=='Prodromal');
Prodromal_DAT_SCAN_SPECT = DAT_SCAN_SPECT(idx_Prodromal,:);

NON_HC_DAT_SCAN_SPECT = DAT_SCAN_SPECT([idx_Prodromal; idx_PD; idx_SWEDD],:);

%% histograms
for i=1:6
    subplot(2,3,i)
    histogram(NON_HC_DAT_SCAN_SPECT(:,i),'FaceColor','auto','Normalization','probability')
    xlabel('Striatal binding ratio [adim]')
    title(['SBR in ' ROIs_labels(i)])
    hold on 
    mu_non_hc = mean(NON_HC_DAT_SCAN_SPECT(:,i));
    xline(mu_non_hc,'LineWidth',2,'Color','r')
    histogram(HC_DAT_SCAN_SPECT(:,i),'FaceColor','auto','Normalization','probability')
    mu_hc = mean(HC_DAT_SCAN_SPECT(:,i));
    xline(mu_hc,'LineWidth',2,'Color','b')
    xlabel('Striatal binding ratio [adim]')
    title(['SBR in ' ROIs_labels(i)])
    hold off
    legend('Non healthy','Average DAT non healthy','Healthy controls','Average DAT healthy')
end

%% Analysis missing data ex family history
answers_fam_pd = data.ANYFAMPD;
idx_yes_fam_pd = find(string(answers_fam_pd) =='1');
%yes_fam_pd = answers_fam_pd
num_yes_fam_pd = length(idx_yes_fam_pd);
idx_no_fam_pd = find(string(answers_fam_pd) =='0');
num_no_fam_pd = length(idx_no_fam_pd);
idx_nan_fam_pd = find(string(answers_fam_pd) =='NA');
num_nan_fam_pd = length(idx_nan_fam_pd);

percent_not_nan = (num_no_fam_pd + num_yes_fam_pd)/(num_no_fam_pd + num_yes_fam_pd+num_nan_fam_pd);

