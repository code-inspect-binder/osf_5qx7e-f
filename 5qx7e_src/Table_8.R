# Analysis code of
# Schmiedek, F., Lövdén, M., Ratcliff, R., & Lindenberger, U. (in press). 
# Practice-related changes in perceptual evidence accumulation correlate with changes in working memory. 
# Journal of Experimental Psychology: General.

# Conducted with R Version 4.1.0 (2021-05-18) & R Studio Version 1.4.1717
# Platform: x86_64-apple-darwin17.0 (64-bit)
# Running under: macOS 12.4

# Load necessary packages
library(lavaan) # Version 0.6-9

# Load data set
setwd("~/papers/cogito_diffusion/drift_WM_change/JEP_General/accepted/OSF_R Code")
cogito<-readRDS("cogito.RDS")
head(cogito)

# VARIABLES
# DIFFUSION MODEL PARAMETERS FOR CHOICE REACTION TIME TASKS
# cvt1_v1:   letters task, pretest, drift rate of condition with masking time 12ms
# cvt1_v2:   letters task, pretest, drift rate of condition with masking time 24ms
# cvt1_v3:   letters task, pretest, drift rate of condition with masking time 47ms
# cvt1_v4:   letters task, pretest, drift rate of condition with masking time 94ms
# cvt1_a:   letters task, pretest, boundary separation
# cvt1_t1:  letters task, pretest, non-decision time
# cvt1_eta: letters task, pretest, trial-to-trial variability of drift rate
# cvt1_sz:  letters task, pretest, trial-to-trial variability of starting point
# cvt1_st:  letters task, pretest, trial-to-trial variability non-decision time
# cvt1_p:   letters task, pretest, probability of contaminant responses
# cvt1_g:   letters task, pretest, chi-square of model fit
# cvt2_v1:   letters task, posttest, drift rate of condition with masking time 12ms
# cvt2_v2:   letters task, posttest, drift rate of condition with masking time 24ms
# cvt2_v3:   letters task, posttest, drift rate of condition with masking time 47ms
# cvt2_v4:   letters task, posttest, drift rate of condition with masking time 94ms
# cvt2_a:   letters task, posttest, boundary separation
# cvt2_t1:  letters task, posttest, non-decision time
# cvt2_eta: letters task, posttest, trial-to-trial variability of drift rate
# cvt2_sz:  letters task, posttest, trial-to-trial variability of starting point
# cvt2_st:  letters task, posttest, trial-to-trial variability non-decision time
# cvt2_p:   letters task, posttest, probability of contaminant responses
# cvt2_g:   letters task, posttest, chi-square of model fit
# oet1_v1:   digits task, pretest, drift rate of condition with masking time 12ms
# oet1_v2:   digits task, pretest, drift rate of condition with masking time 24ms
# oet1_v3:   digits task, pretest, drift rate of condition with masking time 47ms
# oet1_v4:   digits task, pretest, drift rate of condition with masking time 94ms
# oet1_a:   digits task, pretest, boundary separation
# oet1_t1:  digits task, pretest, non-decision time
# oet1_eta: digits task, pretest, trial-to-trial variability of drift rate
# oet1_sz:  digits task, pretest, trial-to-trial variability of starting point
# oet1_st:  digits task, pretest, trial-to-trial variability non-decision time
# oet1_p:   digits task, pretest, probability of contaminant responses
# oet1_g:   digits task, pretest, chi-square of model fit
# oet2_v1:   digits task, posttest, drift rate of condition with masking time 12ms
# oet2_v2:   digits task, posttest, drift rate of condition with masking time 24ms
# oet2_v3:   digits task, posttest, drift rate of condition with masking time 47ms
# oet2_v4:   digits task, posttest, drift rate of condition with masking time 94ms
# oet2_a:   digits task, posttest, boundary separation
# oet2_t1:  digits task, posttest, non-decision time
# oet2_eta: digits task, posttest, trial-to-trial variability of drift rate
# oet2_sz:  digits task, posttest, trial-to-trial variability of starting point
# oet2_st:  digits task, posttest, trial-to-trial variability non-decision time
# oet2_p:   digits task, posttest, probability of contaminant responses
# oet2_g:   digits task, posttest, chi-square of model fit
# syt1_v1:   figures task, pretest, drift rate of condition with masking time 12ms
# syt1_v2:   figures task, pretest, drift rate of condition with masking time 24ms
# syt1_v3:   figures task, pretest, drift rate of condition with masking time 47ms
# syt1_v4:   figures task, pretest, drift rate of condition with masking time 94ms
# syt1_a:   figures task, pretest, boundary separation
# syt1_t1:  figures task, pretest, non-decision time
# syt1_eta: figures task, pretest, trial-to-trial variability of drift rate
# syt1_sz:  figures task, pretest, trial-to-trial variability of starting point
# syt1_st:  figures task, pretest, trial-to-trial variability non-decision time
# syt1_p:   figures task, pretest, probability of contaminant responses
# syt1_g:   figures task, pretest, chi-square of model fit
# syt2_v1:   figures task, posttest, drift rate of condition with masking time 12ms
# syt2_v2:   figures task, posttest, drift rate of condition with masking time 24ms
# syt2_v3:   figures task, posttest, drift rate of condition with masking time 47ms
# syt2_v4:   figures task, posttest, drift rate of condition with masking time 94ms
# syt2_a:   figures task, posttest, boundary separation
# syt2_t1:  figures task, posttest, non-decision time
# syt2_eta: figures task, posttest, trial-to-trial variability of drift rate
# syt2_sz:  figures task, posttest, trial-to-trial variability of starting point
# syt2_st:  figures task, posttest, trial-to-trial variability non-decision time
# syt2_p:   figures task, posttest, probability of contaminant responses
# syt2_g:   figures task, posttest, chi-square of model fit

# PRACTICED WORKING MEMORY TASKS
# nb_pre_acc_pt500:      spatial 3-back, pretest, ISI 500ms
# nb_pre_acc_pt1500:     spatial 3-back, pretest, ISI 1500ms
# nb_pre_acc_pt2500:     spatial 3-back, pretest, ISI 2500ms
# nb_pre_acc_pt3500:     spatial 3-back, pretest, ISI 3500ms
# nb_post_acc_pt500:     spatial 3-back, posttest, ISI 500ms
# nb_post_acc_pt1500:    spatial 3-back, posttest, ISI 1500ms
# nb_post_acc_pt2500:    spatial 3-back, posttest, ISI 2500ms
# nb_post_acc_pt3500:    spatial 3-back, posttest, ISI 3500ms
# as_pre_acc_pt750:      alpha span, pretest, presentation time 750ms
# as_pre_acc_pt1500:     alpha span, pretest, presentation time 1500ms
# as_pre_acc_pt3000:     alpha span, pretest, presentation time 3000ms
# as_pre_acc_pt6000:     alpha span, pretest, presentation time 6000ms
# as_post_acc_pt750:     alpha span, posttest, presentation time 750ms
# as_post_acc_pt1500:    alpha span, posttest, presentation time 1500ms
# as_post_acc_pt3000:    alpha span, posttest, presentation time 3000ms
# as_post_acc_pt6000:    alpha span, posttest, presentation time 6000ms
# mu_pre_acc_pt500:      numerical memory updating, pretest, presentation time 500ms
# mu_pre_acc_pt1250:     numerical memory updating, pretest, presentation time 1250ms
# mu_pre_acc_pt2750:     numerical memory updating, pretest, presentation time 2750ms
# mu_pre_acc_pt5750:     numerical memory updating, pretest, presentation time 5750ms
# mu_post_acc_pt500:      numerical memory updating, posttest, presentation time 500ms
# mu_post_acc_pt1250:     numerical memory updating, posttest, presentation time 1250ms
# mu_post_acc_pt2750:     numerical memory updating, posttest, presentation time 2750ms
# mu_post_acc_pt5750:     numerical memory updating, posttest, presentation time 5750ms

# WORKING MEMORY TRANSFER TASKS
# nb_num_acc:          numerical 3-back, pretest
# nb_num_acc_post:     numerical 3-back, posttest
# animals_num_acc:          animal span, pretest
# animals_num_acc_post:     animal span, posttest
# mus_pre_acc:          spatial memory updating, pretest
# mus_post_acc:         spatial memory updating, posttest

# Aggregate accuracies of different masking time conditions for each WM task:
cogito$nb_pre_acc<-(cogito$nb_pre_acc_pt500+cogito$nb_pre_acc_pt1500+cogito$nb_pre_acc_pt2500+cogito$nb_pre_acc_pt3500)/4
cogito$as_pre_acc<-(cogito$as_pre_acc_pt750+cogito$as_pre_acc_pt1500+cogito$as_pre_acc_pt3000+cogito$as_pre_acc_pt6000)/4
cogito$mu_pre_acc<-(cogito$mu_pre_acc_pt500+cogito$mu_pre_acc_pt1250+cogito$mu_pre_acc_pt2750+cogito$mu_pre_acc_pt5750)/4
cogito$nb_post_acc<-(cogito$nb_post_acc_pt500+cogito$nb_post_acc_pt1500+cogito$nb_post_acc_pt2500+cogito$nb_post_acc_pt3500)/4
cogito$as_post_acc<-(cogito$as_post_acc_pt750+cogito$as_post_acc_pt1500+cogito$as_post_acc_pt3000+cogito$as_post_acc_pt6000)/4
cogito$mu_post_acc<-(cogito$mu_post_acc_pt500+cogito$mu_post_acc_pt1250+cogito$mu_post_acc_pt2750+cogito$mu_post_acc_pt5750)/4

# Aggregate drift rates
cogito$cvt1_v<-(cogito$cvt1_v1+cogito$cvt1_v2+cogito$cvt1_v3+cogito$cvt1_v4)/4
cogito$oet1_v<-(cogito$oet1_v1+cogito$oet1_v2+cogito$oet1_v3+cogito$oet1_v4)/4
cogito$syt1_v<-(cogito$syt1_v1+cogito$syt1_v2+cogito$syt1_v3+cogito$syt1_v4)/4
cogito$cvt2_v<-(cogito$cvt2_v1+cogito$cvt2_v2+cogito$cvt2_v3+cogito$cvt2_v4)/4
cogito$oet2_v<-(cogito$oet2_v1+cogito$oet2_v2+cogito$oet2_v3+cogito$oet2_v4)/4
cogito$syt2_v<-(cogito$syt2_v1+cogito$syt2_v2+cogito$syt2_v3+cogito$syt2_v4)/4


# BIVARIATE LATENT CHANGE SCORE MODELS OF DRIFT RATES AND WM TRANSFER TASKS (Table 8)

# Masking time=12ms 
v1_wmt_t12_strong_lcsm <- '
f_v1_t1 =~ cvt1_v1 + l_2*oet1_v1 + l_3*syt1_v1 
f_v1_t2 =~ cvt2_v1 + l_2*oet2_v1 + l_3*syt2_v1

cvt1_v1 ~ 0
cvt2_v1 ~ 0
oet1_v1 ~ i_2*1
oet2_v1 ~ i_2*1
syt1_v1 ~ i_3*1
syt2_v1 ~ i_3*1

cvt1_v1 ~~ cvt2_v1
oet1_v1 ~~ oet2_v1
syt1_v1 ~~ syt2_v1

cvt1_v1 ~~ oet1_v1
cvt2_v1 ~~ oet2_v1

f_v1_t1 ~ 1
d_v1 ~ 1
d_v1 =~ 1*f_v1_t2
f_v1_t2 ~~ 0*f_v1_t2
f_v1_t2 ~ 0 + 1*f_v1_t1

f_v1_t1 ~~ f_v1_t1
d_v1 ~~ d_v1
d_v1 ~~ f_v1_t1

f_wm_t1 =~ animals_acc + l_5*nb_num_acc + l_6*mus_pre_acc 
f_wm_t2 =~ animals_acc_post + l_5*nb_num_acc_post + l_6*mus_post_acc

animals_acc ~ 0
animals_acc_post ~ 0
nb_num_acc ~ i_5*1
nb_num_acc_post ~ i_5*1
mus_pre_acc ~ i_6*1
mus_post_acc ~ i_6*1

d_wm ~ 1
f_wm_t1 ~ 1
d_wm =~ 1*f_wm_t2
f_wm_t2 ~~ 0*f_wm_t2
f_wm_t2 ~ 0 + 1*f_wm_t1

f_wm_t1 ~~ f_wm_t1
d_wm ~~ d_wm
d_wm ~~ f_wm_t1

animals_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

d_wm ~~ f_v1_t1
d_v1 ~~ f_wm_t1
d_wm ~~ d_v1
f_v1_t1 ~~ f_wm_t1
'

fit_v1_wmt_t12_strong_lcsm <- sem(v1_wmt_t12_strong_lcsm, data=cogito, missing='fiml',estimator='ML')
summary(fit_v1_wmt_t12_strong_lcsm,fit.measures=TRUE,standardized=T)
standardizedsolution(fit_v1_wmt_t12_strong_lcsm)

#Test covariance of latent change factors
v1_wmt_t12_strong_lcsm_TEST <- '
f_v1_t1 =~ cvt1_v1 + l_2*oet1_v1 + l_3*syt1_v1 
f_v1_t2 =~ cvt2_v1 + l_2*oet2_v1 + l_3*syt2_v1

cvt1_v1 ~ 0
cvt2_v1 ~ 0
oet1_v1 ~ i_2*1
oet2_v1 ~ i_2*1
syt1_v1 ~ i_3*1
syt2_v1 ~ i_3*1

cvt1_v1 ~~ cvt2_v1
oet1_v1 ~~ oet2_v1
syt1_v1 ~~ syt2_v1

cvt1_v1 ~~ oet1_v1
cvt2_v1 ~~ oet2_v1

f_v1_t1 ~ 1
d_v1 ~ 1
d_v1 =~ 1*f_v1_t2
f_v1_t2 ~~ 0*f_v1_t2
f_v1_t2 ~ 0 + 1*f_v1_t1

f_v1_t1 ~~ f_v1_t1
d_v1 ~~ d_v1
d_v1 ~~ f_v1_t1

f_wm_t1 =~ animals_acc + l_5*nb_num_acc + l_6*mus_pre_acc 
f_wm_t2 =~ animals_acc_post + l_5*nb_num_acc_post + l_6*mus_post_acc

animals_acc ~ 0
animals_acc_post ~ 0
nb_num_acc ~ i_5*1
nb_num_acc_post ~ i_5*1
mus_pre_acc ~ i_6*1
mus_post_acc ~ i_6*1

d_wm ~ 1
f_wm_t1 ~ 1
d_wm =~ 1*f_wm_t2
f_wm_t2 ~~ 0*f_wm_t2
f_wm_t2 ~ 0 + 1*f_wm_t1

f_wm_t1 ~~ f_wm_t1
d_wm ~~ d_wm
d_wm ~~ f_wm_t1

animals_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

d_wm ~~ f_v1_t1
d_v1 ~~ f_wm_t1
d_wm ~~ 0*d_v1
f_v1_t1 ~~ f_wm_t1
'

fit_v1_wmt_t12_strong_lcsm_TEST <- sem(v1_wmt_t12_strong_lcsm_TEST, data=cogito, missing='fiml',estimator='ML')
anova(fit_v1_wmt_t12_strong_lcsm,fit_v1_wmt_t12_strong_lcsm_TEST)

# Masking time=24ms 
v2_wmt_t12_strong_lcsm <- '
f_v2_t1 =~ cvt1_v2 + l_2*oet1_v2 + l_3*syt1_v2 
f_v2_t2 =~ cvt2_v2 + l_2*oet2_v2 + l_3*syt2_v2

cvt1_v2 ~ 0
cvt2_v2 ~ 0
oet1_v2 ~ i_2*1
oet2_v2 ~ i_2*1
syt1_v2 ~ i_3*1
syt2_v2 ~ i_3*1

cvt1_v2 ~~ cvt2_v2
oet1_v2 ~~ oet2_v2
syt1_v2 ~~ syt2_v2

cvt1_v2 ~~ oet1_v2
cvt2_v2 ~~ oet2_v2

f_v2_t1 ~ 1
d_v2 ~ 1
d_v2 =~ 1*f_v2_t2
f_v2_t2 ~~ 0*f_v2_t2
f_v2_t2 ~ 0 + 1*f_v2_t1

f_v2_t1 ~~ f_v2_t1
d_v2 ~~ d_v2
d_v2 ~~ f_v2_t1

f_wm_t1 =~ animals_acc + l_5*nb_num_acc + l_6*mus_pre_acc 
f_wm_t2 =~ animals_acc_post + l_5*nb_num_acc_post + l_6*mus_post_acc

animals_acc ~ 0
animals_acc_post ~ 0
nb_num_acc ~ i_5*1
nb_num_acc_post ~ i_5*1
mus_pre_acc ~ i_6*1
mus_post_acc ~ i_6*1

d_wm ~ 1
f_wm_t1 ~ 1
d_wm =~ 1*f_wm_t2
f_wm_t2 ~~ 0*f_wm_t2
f_wm_t2 ~ 0 + 1*f_wm_t1

f_wm_t1 ~~ f_wm_t1
d_wm ~~ d_wm
d_wm ~~ f_wm_t1

animals_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

d_wm ~~ f_v2_t1
d_v2 ~~ f_wm_t1
d_wm ~~ d_v2
f_v2_t1 ~~ f_wm_t1
'

fit_v2_wmt_t12_strong_lcsm <- sem(v2_wmt_t12_strong_lcsm, data=cogito, missing='fiml',estimator='ML')
summary(fit_v2_wmt_t12_strong_lcsm,fit.measures=TRUE,standardized=T)
standardizedsolution(fit_v2_wmt_t12_strong_lcsm)

#Test covariance of latent change factors
v2_wmt_t12_strong_lcsm_TEST <- '
f_v2_t1 =~ cvt1_v2 + l_2*oet1_v2 + l_3*syt1_v2 
f_v2_t2 =~ cvt2_v2 + l_2*oet2_v2 + l_3*syt2_v2

cvt1_v2 ~ 0
cvt2_v2 ~ 0
oet1_v2 ~ i_2*1
oet2_v2 ~ i_2*1
syt1_v2 ~ i_3*1
syt2_v2 ~ i_3*1

cvt1_v2 ~~ cvt2_v2
oet1_v2 ~~ oet2_v2
syt1_v2 ~~ syt2_v2

cvt1_v2 ~~ oet1_v2
cvt2_v2 ~~ oet2_v2

f_v2_t1 ~ 1
d_v2 ~ 1
d_v2 =~ 1*f_v2_t2
f_v2_t2 ~~ 0*f_v2_t2
f_v2_t2 ~ 0 + 1*f_v2_t1

f_v2_t1 ~~ f_v2_t1
d_v2 ~~ d_v2
d_v2 ~~ f_v2_t1

f_wm_t1 =~ animals_acc + l_5*nb_num_acc + l_6*mus_pre_acc 
f_wm_t2 =~ animals_acc_post + l_5*nb_num_acc_post + l_6*mus_post_acc

animals_acc ~ 0
animals_acc_post ~ 0
nb_num_acc ~ i_5*1
nb_num_acc_post ~ i_5*1
mus_pre_acc ~ i_6*1
mus_post_acc ~ i_6*1

d_wm ~ 1
f_wm_t1 ~ 1
d_wm =~ 1*f_wm_t2
f_wm_t2 ~~ 0*f_wm_t2
f_wm_t2 ~ 0 + 1*f_wm_t1

f_wm_t1 ~~ f_wm_t1
d_wm ~~ d_wm
d_wm ~~ f_wm_t1

animals_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

d_wm ~~ f_v2_t1
d_v2 ~~ f_wm_t1
d_wm ~~ 0*d_v2
f_v2_t1 ~~ f_wm_t1
'

fit_v2_wmt_t12_strong_lcsm_TEST <- sem(v2_wmt_t12_strong_lcsm_TEST, data=cogito, missing='fiml',estimator='ML')
anova(fit_v2_wmt_t12_strong_lcsm,fit_v2_wmt_t12_strong_lcsm_TEST)

# Masking time=47ms 
v3_wmt_t12_strong_lcsm <- '
f_v3_t1 =~ cvt1_v3 + l_2*oet1_v3 + l_3*syt1_v3 
f_v3_t2 =~ cvt2_v3 + l_2*oet2_v3 + l_3*syt2_v3

cvt1_v3 ~ 0
cvt2_v3 ~ 0
oet1_v3 ~ i_2*1
oet2_v3 ~ i_2*1
syt1_v3 ~ i_3*1
syt2_v3 ~ i_3*1

cvt1_v3 ~~ cvt2_v3
oet1_v3 ~~ oet2_v3
syt1_v3 ~~ syt2_v3

cvt1_v3 ~~ oet1_v3
cvt2_v3 ~~ oet2_v3

f_v3_t1 ~ 1
d_v3 ~ 1
d_v3 =~ 1*f_v3_t2
f_v3_t2 ~~ 0*f_v3_t2
f_v3_t2 ~ 0 + 1*f_v3_t1

f_v3_t1 ~~ f_v3_t1
d_v3 ~~ d_v3
d_v3 ~~ f_v3_t1

f_wm_t1 =~ animals_acc + l_5*nb_num_acc + l_6*mus_pre_acc 
f_wm_t2 =~ animals_acc_post + l_5*nb_num_acc_post + l_6*mus_post_acc

animals_acc ~ 0
animals_acc_post ~ 0
nb_num_acc ~ i_5*1
nb_num_acc_post ~ i_5*1
mus_pre_acc ~ i_6*1
mus_post_acc ~ i_6*1

d_wm ~ 1
f_wm_t1 ~ 1
d_wm =~ 1*f_wm_t2
f_wm_t2 ~~ 0*f_wm_t2
f_wm_t2 ~ 0 + 1*f_wm_t1

f_wm_t1 ~~ f_wm_t1
d_wm ~~ d_wm
d_wm ~~ f_wm_t1

animals_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

d_wm ~~ f_v3_t1
d_v3 ~~ f_wm_t1
d_wm ~~ d_v3
f_v3_t1 ~~ f_wm_t1
'

fit_v3_wmt_t12_strong_lcsm <- sem(v3_wmt_t12_strong_lcsm, data=cogito, missing='fiml',estimator='ML')
summary(fit_v3_wmt_t12_strong_lcsm,fit.measures=TRUE,standardized=T)
standardizedsolution(fit_v3_wmt_t12_strong_lcsm)

#Test covariance of latent change factors
v3_wmt_t12_strong_lcsm_TEST <- '
f_v3_t1 =~ cvt1_v3 + l_2*oet1_v3 + l_3*syt1_v3 
f_v3_t2 =~ cvt2_v3 + l_2*oet2_v3 + l_3*syt2_v3

cvt1_v3 ~ 0
cvt2_v3 ~ 0
oet1_v3 ~ i_2*1
oet2_v3 ~ i_2*1
syt1_v3 ~ i_3*1
syt2_v3 ~ i_3*1

cvt1_v3 ~~ cvt2_v3
oet1_v3 ~~ oet2_v3
syt1_v3 ~~ syt2_v3

cvt1_v3 ~~ oet1_v3
cvt2_v3 ~~ oet2_v3

f_v3_t1 ~ 1
d_v3 ~ 1
d_v3 =~ 1*f_v3_t2
f_v3_t2 ~~ 0*f_v3_t2
f_v3_t2 ~ 0 + 1*f_v3_t1

f_v3_t1 ~~ f_v3_t1
d_v3 ~~ d_v3
d_v3 ~~ f_v3_t1

f_wm_t1 =~ animals_acc + l_5*nb_num_acc + l_6*mus_pre_acc 
f_wm_t2 =~ animals_acc_post + l_5*nb_num_acc_post + l_6*mus_post_acc

animals_acc ~ 0
animals_acc_post ~ 0
nb_num_acc ~ i_5*1
nb_num_acc_post ~ i_5*1
mus_pre_acc ~ i_6*1
mus_post_acc ~ i_6*1

d_wm ~ 1
f_wm_t1 ~ 1
d_wm =~ 1*f_wm_t2
f_wm_t2 ~~ 0*f_wm_t2
f_wm_t2 ~ 0 + 1*f_wm_t1

f_wm_t1 ~~ f_wm_t1
d_wm ~~ d_wm
d_wm ~~ f_wm_t1

animals_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

d_wm ~~ f_v3_t1
d_v3 ~~ f_wm_t1
d_wm ~~ 0*d_v3
f_v3_t1 ~~ f_wm_t1
'

fit_v3_wmt_t12_strong_lcsm_TEST <- sem(v3_wmt_t12_strong_lcsm_TEST, data=cogito, missing='fiml',estimator='ML')
anova(fit_v3_wmt_t12_strong_lcsm,fit_v3_wmt_t12_strong_lcsm_TEST)

# Masking time=94ms 
v4_wmt_t12_strong_lcsm <- '
f_v4_t1 =~ cvt1_v4 + l_2*oet1_v4 + l_3*syt1_v4 
f_v4_t2 =~ cvt2_v4 + l_2*oet2_v4 + l_3*syt2_v4

cvt1_v4 ~ 0
cvt2_v4 ~ 0
oet1_v4 ~ i_2*1
oet2_v4 ~ i_2*1
syt1_v4 ~ i_3*1
syt2_v4 ~ i_3*1

cvt1_v4 ~~ cvt2_v4
oet1_v4 ~~ oet2_v4
syt1_v4 ~~ syt2_v4

cvt1_v4 ~~ oet1_v4
cvt2_v4 ~~ oet2_v4

f_v4_t1 ~ 1
d_v4 ~ 1
d_v4 =~ 1*f_v4_t2
f_v4_t2 ~~ 0*f_v4_t2
f_v4_t2 ~ 0 + 1*f_v4_t1

f_v4_t1 ~~ f_v4_t1
d_v4 ~~ d_v4
d_v4 ~~ f_v4_t1

f_wm_t1 =~ animals_acc + l_5*nb_num_acc + l_6*mus_pre_acc 
f_wm_t2 =~ animals_acc_post + l_5*nb_num_acc_post + l_6*mus_post_acc

animals_acc ~ 0
animals_acc_post ~ 0
nb_num_acc ~ i_5*1
nb_num_acc_post ~ i_5*1
mus_pre_acc ~ i_6*1
mus_post_acc ~ i_6*1

d_wm ~ 1
f_wm_t1 ~ 1
d_wm =~ 1*f_wm_t2
f_wm_t2 ~~ 0*f_wm_t2
f_wm_t2 ~ 0 + 1*f_wm_t1

f_wm_t1 ~~ f_wm_t1
d_wm ~~ d_wm
d_wm ~~ f_wm_t1

animals_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

d_wm ~~ f_v4_t1
d_v4 ~~ f_wm_t1
d_wm ~~ d_v4
f_v4_t1 ~~ f_wm_t1
'

fit_v4_wmt_t12_strong_lcsm <- sem(v4_wmt_t12_strong_lcsm, data=cogito, missing='fiml',estimator='ML')
summary(fit_v4_wmt_t12_strong_lcsm,fit.measures=TRUE,standardized=T)
standardizedsolution(fit_v4_wmt_t12_strong_lcsm)

#Test covariance of latent change factors
v4_wmt_t12_strong_lcsm_TEST <- '
f_v4_t1 =~ cvt1_v4 + l_2*oet1_v4 + l_3*syt1_v4 
f_v4_t2 =~ cvt2_v4 + l_2*oet2_v4 + l_3*syt2_v4

cvt1_v4 ~ 0
cvt2_v4 ~ 0
oet1_v4 ~ i_2*1
oet2_v4 ~ i_2*1
syt1_v4 ~ i_3*1
syt2_v4 ~ i_3*1

cvt1_v4 ~~ cvt2_v4
oet1_v4 ~~ oet2_v4
syt1_v4 ~~ syt2_v4

cvt1_v4 ~~ oet1_v4
cvt2_v4 ~~ oet2_v4

f_v4_t1 ~ 1
d_v4 ~ 1
d_v4 =~ 1*f_v4_t2
f_v4_t2 ~~ 0*f_v4_t2
f_v4_t2 ~ 0 + 1*f_v4_t1

f_v4_t1 ~~ f_v4_t1
d_v4 ~~ d_v4
d_v4 ~~ f_v4_t1

f_wm_t1 =~ animals_acc + l_5*nb_num_acc + l_6*mus_pre_acc 
f_wm_t2 =~ animals_acc_post + l_5*nb_num_acc_post + l_6*mus_post_acc

animals_acc ~ 0
animals_acc_post ~ 0
nb_num_acc ~ i_5*1
nb_num_acc_post ~ i_5*1
mus_pre_acc ~ i_6*1
mus_post_acc ~ i_6*1

d_wm ~ 1
f_wm_t1 ~ 1
d_wm =~ 1*f_wm_t2
f_wm_t2 ~~ 0*f_wm_t2
f_wm_t2 ~ 0 + 1*f_wm_t1

f_wm_t1 ~~ f_wm_t1
d_wm ~~ d_wm
d_wm ~~ f_wm_t1

animals_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

d_wm ~~ f_v4_t1
d_v4 ~~ f_wm_t1
d_wm ~~ 0*d_v4
f_v4_t1 ~~ f_wm_t1
'

fit_v4_wmt_t12_strong_lcsm_TEST <- sem(v4_wmt_t12_strong_lcsm_TEST, data=cogito, missing='fiml',estimator='ML')
anova(fit_v4_wmt_t12_strong_lcsm,fit_v4_wmt_t12_strong_lcsm_TEST)

# Averaged masking times
v_wmt_t12_strong_lcsm <- '
f_v_t1 =~ cvt1_v + l_2*oet1_v + l_3*syt1_v 
f_v_t2 =~ cvt2_v + l_2*oet2_v + l_3*syt2_v

cvt1_v ~ 0
cvt2_v ~ 0
oet1_v ~ i_2*1
oet2_v ~ i_2*1
syt1_v ~ i_3*1
syt2_v ~ i_3*1

cvt1_v ~~ cvt2_v
oet1_v ~~ oet2_v
syt1_v ~~ syt2_v

cvt1_v ~~ oet1_v
cvt2_v ~~ oet2_v

f_v_t1 ~ 1
d_v ~ 1
d_v =~ 1*f_v_t2
f_v_t2 ~~ 0*f_v_t2
f_v_t2 ~ 0 + 1*f_v_t1

f_v_t1 ~~ f_v_t1
d_v ~~ d_v
d_v ~~ f_v_t1

f_wm_t1 =~ animals_acc + l_5*nb_num_acc + l_6*mus_pre_acc 
f_wm_t2 =~ animals_acc_post + l_5*nb_num_acc_post + l_6*mus_post_acc

animals_acc ~ 0
animals_acc_post ~ 0
nb_num_acc ~ i_5*1
nb_num_acc_post ~ i_5*1
mus_pre_acc ~ i_6*1
mus_post_acc ~ i_6*1

d_wm ~ 1
f_wm_t1 ~ 1
d_wm =~ 1*f_wm_t2
f_wm_t2 ~~ 0*f_wm_t2
f_wm_t2 ~ 0 + 1*f_wm_t1

f_wm_t1 ~~ f_wm_t1
d_wm ~~ d_wm
d_wm ~~ f_wm_t1

animals_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

d_wm ~~ f_v_t1
d_v ~~ f_wm_t1
d_wm ~~ d_v
f_v_t1 ~~ f_wm_t1
'

fit_v_wmt_t12_strong_lcsm <- sem(v_wmt_t12_strong_lcsm, data=cogito, missing='fiml',estimator='ML')
summary(fit_v_wmt_t12_strong_lcsm,fit.measures=TRUE,standardized=T)
standardizedsolution(fit_v_wmt_t12_strong_lcsm)

#Test covariance of latent change factors
v_wmt_t12_strong_lcsm_TEST <- '
f_v_t1 =~ cvt1_v + l_2*oet1_v + l_3*syt1_v 
f_v_t2 =~ cvt2_v + l_2*oet2_v + l_3*syt2_v

cvt1_v ~ 0
cvt2_v ~ 0
oet1_v ~ i_2*1
oet2_v ~ i_2*1
syt1_v ~ i_3*1
syt2_v ~ i_3*1

cvt1_v ~~ cvt2_v
oet1_v ~~ oet2_v
syt1_v ~~ syt2_v

cvt1_v ~~ oet1_v
cvt2_v ~~ oet2_v

f_v_t1 ~ 1
d_v ~ 1
d_v =~ 1*f_v_t2
f_v_t2 ~~ 0*f_v_t2
f_v_t2 ~ 0 + 1*f_v_t1

f_v_t1 ~~ f_v_t1
d_v ~~ d_v
d_v ~~ f_v_t1

f_wm_t1 =~ animals_acc + l_5*nb_num_acc + l_6*mus_pre_acc 
f_wm_t2 =~ animals_acc_post + l_5*nb_num_acc_post + l_6*mus_post_acc

animals_acc ~ 0
animals_acc_post ~ 0
nb_num_acc ~ i_5*1
nb_num_acc_post ~ i_5*1
mus_pre_acc ~ i_6*1
mus_post_acc ~ i_6*1

d_wm ~ 1
f_wm_t1 ~ 1
d_wm =~ 1*f_wm_t2
f_wm_t2 ~~ 0*f_wm_t2
f_wm_t2 ~ 0 + 1*f_wm_t1

f_wm_t1 ~~ f_wm_t1
d_wm ~~ d_wm
d_wm ~~ f_wm_t1

animals_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

d_wm ~~ f_v_t1
d_v ~~ f_wm_t1
d_wm ~~ 0*d_v
f_v_t1 ~~ f_wm_t1
'

fit_v_wmt_t12_strong_lcsm_TEST <- sem(v_wmt_t12_strong_lcsm_TEST, data=cogito, missing='fiml',estimator='ML')
anova(fit_v_wmt_t12_strong_lcsm,fit_v_wmt_t12_strong_lcsm_TEST)