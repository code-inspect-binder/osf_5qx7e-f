# Analysis code of
# Schmiedek, F., Lövdén, M., Ratcliff, R., & Lindenberger, U. (in press). 
# Practice-related changes in perceptual evidence accumulation correlate with changes in working memory. 
# Journal of Experimental Psychology: General.

# Conducted with R Version 4.1.0 (2021-05-18) & R Studio Version 1.4.1717
# Platform: x86_64-apple-darwin17.0 (64-bit)
# Running under: macOS 12.4

# Load necessary packages
library(dplyr) # Version 1.0.6
library(tidyverse) # Version 1.3.1
library(ggpubr) # Version 0.4.0
library(rstatix) # Version 0.7.0
library(sjPlot) # Version 2.8.9
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

# Aggregate accuracies of different masking time conditions for each WM task
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

# Descriptive statistics for working memory tasks
mean(cogito$as_pre_acc)
sd(cogito$as_pre_acc)
mean(cogito$as_post_acc)
sd(cogito$as_post_acc)
t.test(cogito$as_pre_acc,cogito$as_post_acc,paired=TRUE)

mean(cogito$mu_pre_acc)
sd(cogito$mu_pre_acc)
mean(cogito$mu_post_acc)
sd(cogito$mu_post_acc)
t.test(cogito$mu_pre_acc,cogito$mu_post_acc,paired=TRUE)

mean(cogito$nb_pre_acc)
sd(cogito$nb_pre_acc)
mean(cogito$nb_post_acc)
sd(cogito$nb_post_acc)
t.test(cogito$nb_pre_acc,cogito$nb_post_acc,paired=TRUE)

mean(cogito$animals_acc)
sd(cogito$animals_acc)
mean(cogito$animals_acc_post)
sd(cogito$animals_acc_post)
t.test(cogito$animals_acc,cogito$animals_acc_post,paired=TRUE)

mean(cogito$nb_num_acc)
sd(cogito$nb_num_acc)
mean(cogito$nb_num_acc_post)
sd(cogito$nb_num_acc_post)
t.test(cogito$nb_num_acc,cogito$nb_num_acc_post,paired=TRUE)

mean(cogito$mu_pre_acc)
sd(cogito$mu_pre_acc)
mean(cogito$mu_post_acc)
sd(cogito$mu_post_acc)
t.test(cogito$mu_pre_acc,cogito$mu_post_acc,paired=TRUE)

# DESCRIPTIVE STATISTICS FOR DIFFUSION MODEL PARAMETERS (Table 1)
#Drift rates, letters task, masking time = 12ms
mean(cogito$cvt1_v1)
sd(cogito$cvt1_v1)
mean(cogito$cvt2_v1)
sd(cogito$cvt2_v1)
t.test(cogito$cvt1_v1,cogito$cvt2_v1,paired=TRUE)
#Drift rates, digits task, masking time = 12ms
mean(cogito$oet1_v1)
sd(cogito$oet1_v1)
mean(cogito$oet2_v1)
sd(cogito$oet2_v1)
t.test(cogito$oet1_v1,cogito$oet2_v1,paired=TRUE)
#Drift rates, figures task, masking time = 12ms
mean(cogito$syt1_v1)
sd(cogito$syt1_v1)
mean(cogito$syt2_v1)
sd(cogito$syt2_v1)
t.test(cogito$syt1_v1,cogito$syt2_v1,paired=TRUE)
#Drift rates, letters task, masking time = 24ms
mean(cogito$cvt1_v2)
sd(cogito$cvt1_v2)
mean(cogito$cvt2_v2)
sd(cogito$cvt2_v2)
t.test(cogito$cvt1_v2,cogito$cvt2_v2,paired=TRUE)
#Drift rates, digits task, masking time = 24ms
mean(cogito$oet1_v2)
sd(cogito$oet1_v2)
mean(cogito$oet2_v2)
sd(cogito$oet2_v2)
t.test(cogito$oet1_v2,cogito$oet2_v2,paired=TRUE)
#Drift rates, figures task, masking time = 24ms
mean(cogito$syt1_v2)
sd(cogito$syt1_v2)
mean(cogito$syt2_v2)
sd(cogito$syt2_v2)
t.test(cogito$syt1_v2,cogito$syt2_v2,paired=TRUE)
#Drift rates, letters task, masking time = 47ms
mean(cogito$cvt1_v3)
sd(cogito$cvt1_v3)
mean(cogito$cvt2_v3)
sd(cogito$cvt2_v3)
t.test(cogito$cvt1_v3,cogito$cvt2_v3,paired=TRUE)
#Drift rates, digits task, masking time = 47ms
mean(cogito$oet1_v3)
sd(cogito$oet1_v3)
mean(cogito$oet2_v3)
sd(cogito$oet2_v3)
t.test(cogito$oet1_v3,cogito$oet2_v3,paired=TRUE)
#Drift rates, figures task, masking time = 47ms
mean(cogito$syt1_v3)
sd(cogito$syt1_v3)
mean(cogito$syt2_v3)
sd(cogito$syt2_v3)
t.test(cogito$syt1_v3,cogito$syt2_v3,paired=TRUE)
#Drift rates, letters task, masking time = 94ms
mean(cogito$cvt1_v4)
sd(cogito$cvt1_v4)
mean(cogito$cvt2_v4)
sd(cogito$cvt2_v4)
t.test(cogito$cvt1_v4,cogito$cvt2_v4,paired=TRUE)
#Drift rates, digits task, masking time = 94ms
mean(cogito$oet1_v4)
sd(cogito$oet1_v4)
mean(cogito$oet2_v4)
sd(cogito$oet2_v4)
t.test(cogito$oet1_v4,cogito$oet2_v4,paired=TRUE)
#Drift rates, figures task, masking time = 94ms
mean(cogito$syt1_v4)
sd(cogito$syt1_v4)
mean(cogito$syt2_v4)
sd(cogito$syt2_v4)
t.test(cogito$syt1_v4,cogito$syt2_v4,paired=TRUE)

# ANOVA dependent variable: drift rate independent variable:masking time condition
# letters task, pretest
cv_pre_drift = cogito %>%
  gather(key = "maskingtime", value = "drift", cvt1_v1,cvt1_v2,cvt1_v3,cvt1_v4) %>%
  convert_as_factor(obs, maskingtime)
aov_cv_pre <- anova_test(data = cv_pre_drift , dv = drift, wid = obs, within = maskingtime, type=3, detailed=T)
get_anova_table(aov_cv_pre, correction="none")
# digits task, pretest
oe_pre_drift = cogito %>%
  gather(key = "maskingtime", value = "drift", oet1_v1,oet1_v2,oet1_v3,oet1_v4) %>%
  convert_as_factor(id, maskingtime)
aov_oe_pre <- anova_test(data = oe_pre_drift , dv = drift, wid = id, within = maskingtime, type=3, detailed=T)
get_anova_table(aov_oe_pre, correction="none")
# figures task, pretest
sy_pre_drift = cogito %>%
  gather(key = "maskingtime", value = "drift", syt1_v1,syt1_v2,syt1_v3,syt1_v4) %>%
  convert_as_factor(id, maskingtime)
aov_sy_pre <- anova_test(data = sy_pre_drift , dv = drift, wid = id, within = maskingtime, type=3, detailed=T)
get_anova_table(aov_sy_pre, correction="none")
# letters task, posttest
cv_post_drift = cogito %>%
  gather(key = "maskingtime", value = "drift", cvt2_v1,cvt2_v2,cvt2_v3,cvt2_v4) %>%
  convert_as_factor(id, maskingtime)
aov_cv_post <- anova_test(data = cv_post_drift , dv = drift, wid = id, within = maskingtime, type=3, detailed=T)
get_anova_table(aov_cv_post, correction="none")
# digits task, posttest
oe_post_drift = cogito %>%
  gather(key = "maskingtime", value = "drift", oet2_v1,oet2_v2,oet2_v3,oet2_v4) %>%
  convert_as_factor(id, maskingtime)
aov_oe_post <- anova_test(data = oe_post_drift , dv = drift, wid = id, within = maskingtime, type=3, detailed=T)
get_anova_table(aov_oe_post, correction="none")
# figures task, posttest
sy_post_drift = cogito %>%
  gather(key = "maskingtime", value = "drift", syt2_v1,syt2_v2,syt2_v3,syt2_v4) %>%
  convert_as_factor(id, maskingtime)
aov_sy_post <- anova_test(data = sy_post_drift , dv = drift, wid = id, within = maskingtime, type=3, detailed=T)
get_anova_table(aov_sy_post, correction="none")

#Boundary separation, letters task
mean(cogito$cvt1_a)
sd(cogito$cvt1_a)
mean(cogito$cvt2_a)
sd(cogito$cvt2_a)
t.test(cogito$cvt1_a,cogito$cvt2_a,paired=TRUE)
#Boundary separation, digits task
mean(cogito$oet1_a)
sd(cogito$oet1_a)
mean(cogito$oet2_a)
sd(cogito$oet2_a)
t.test(cogito$oet1_a,cogito$oet2_a,paired=TRUE)
#Boundary separation, figures task
mean(cogito$syt1_a)
sd(cogito$syt1_a)
mean(cogito$syt2_a)
sd(cogito$syt2_a)
t.test(cogito$syt1_a,cogito$syt2_a,paired=TRUE)

# Non-decision time, letters task
mean(cogito$cvt1_t1)
sd(cogito$cvt1_t1)
mean(cogito$cvt2_t1)
sd(cogito$cvt2_t1)
t.test(cogito$cvt1_t1,cogito$cvt2_t1,paired=TRUE)
# Non-decision time, digits task
mean(cogito$oet1_t1)
sd(cogito$oet1_t1)
mean(cogito$oet2_t1)
sd(cogito$oet2_t1)
t.test(cogito$oet1_t1,cogito$oet2_t1,paired=TRUE)
# Non-decision time, figures task
mean(cogito$syt1_t1)
sd(cogito$syt1_t1)
mean(cogito$syt2_t1)
sd(cogito$syt2_t1)
t.test(cogito$syt1_t1,cogito$syt2_t1,paired=TRUE)


# Trial-to-trial variability of drift rate, letters task
mean(cogito$cvt1_eta)
sd(cogito$cvt1_eta)
mean(cogito$cvt2_eta)
sd(cogito$cvt2_eta)
t.test(cogito$cvt1_eta,cogito$cvt2_eta,paired=TRUE)
# Trial-to-trial variability of drift rate, digits task
mean(cogito$oet1_eta)
sd(cogito$oet1_eta)
mean(cogito$oet2_eta)
sd(cogito$oet2_eta)
t.test(cogito$oet1_eta,cogito$oet2_eta,paired=TRUE)
# Trial-to-trial variability of drift rate, figures task
mean(cogito$syt1_eta)
sd(cogito$syt1_eta)
mean(cogito$syt2_eta)
sd(cogito$syt2_eta)
t.test(cogito$syt1_eta,cogito$syt2_eta,paired=TRUE)

# Trial-to-trial variability of starting point, letters task
mean(cogito$cvt1_sz)
sd(cogito$cvt1_sz)
mean(cogito$cvt2_sz)
sd(cogito$cvt2_sz)
t.test(cogito$cvt1_sz,cogito$cvt2_sz,paired=TRUE)
# Trial-to-trial variability of starting point, digits task
mean(cogito$oet1_sz)
sd(cogito$oet1_sz)
mean(cogito$oet2_sz)
sd(cogito$oet2_sz)
t.test(cogito$oet1_sz,cogito$oet2_sz,paired=TRUE)
# Trial-to-trial variability of starting point, figures task
mean(cogito$syt1_sz)
sd(cogito$syt1_sz)
mean(cogito$syt2_sz)
sd(cogito$syt2_sz)
t.test(cogito$syt1_sz,cogito$syt2_sz,paired=TRUE)

# Trial-to-trial variability of non-decision time, letters task
mean(cogito$cvt1_st)
sd(cogito$cvt1_st)
mean(cogito$cvt2_st)
sd(cogito$cvt2_st)
t.test(cogito$cvt1_st,cogito$cvt2_st,paired=TRUE)
# Trial-to-trial variability of non-decision time, digits task
mean(cogito$oet1_st)
sd(cogito$oet1_st)
mean(cogito$oet2_st)
sd(cogito$oet2_st)
t.test(cogito$oet1_st,cogito$oet2_st,paired=TRUE)
# Trial-to-trial variability of non-decision time, figures task
mean(cogito$syt1_st)
sd(cogito$syt1_st)
mean(cogito$syt2_st)
sd(cogito$syt2_st)
t.test(cogito$syt1_st,cogito$syt2_st,paired=TRUE)

# Probability of contaminant responses, letters task
mean(cogito$cvt1_p)
sd(cogito$cvt1_p)
mean(cogito$cvt2_p)
sd(cogito$cvt2_p)
t.test(cogito$cvt1_p,cogito$cvt2_p,paired=TRUE)
# Probability of contaminant responses, digits task
mean(cogito$oet1_p)
sd(cogito$oet1_p)
mean(cogito$oet2_p)
sd(cogito$oet2_p)
t.test(cogito$oet1_p,cogito$oet2_p,paired=TRUE)
# Probability of contaminant responses, figures task
mean(cogito$syt1_p)
sd(cogito$syt1_p)
mean(cogito$syt2_p)
sd(cogito$syt2_p)
t.test(cogito$syt1_p,cogito$syt2_p,paired=TRUE)

# Chi-square of diffusion model fits
mean(cogito$cvt1_g)
mean(cogito$cvt2_g)
mean(cogito$oet1_g)
mean(cogito$oet2_g)
mean(cogito$syt1_g)
mean(cogito$syt2_g)

# Correlations of drift rates and working memory tasks (Table 2)
cor(cogito[,c("cvt1_v1", "cvt1_v2","cvt1_v3","cvt1_v4", 
        "oet1_v1", "oet1_v2","oet1_v3","oet1_v4", 
        "syt1_v1", "syt1_v2","syt1_v3","syt1_v4",
        "cvt2_v1", "cvt2_v2","cvt2_v3","cvt2_v4", 
        "oet2_v1", "oet2_v2","oet2_v3","oet2_v4", 
        "syt2_v1", "syt2_v2","syt2_v3","syt2_v4",
        "as_pre_acc","nb_pre_acc","mu_pre_acc",
        "animals_acc","nb_num_acc","mus_pre_acc",
        "as_post_acc","nb_post_acc","mu_post_acc",
        "animals_acc_post","nb_num_acc_post","mus_post_acc")], method = "pearson")

# Test difference of correlations of working memory tasks and drift rates between pre- and posttest 
# by fitting a model with corresponding correlations constrained to be equal

# Standardize all relevant variables
scogito<-scale(cogito)

# Lavaan model with equality constraints
model_constrained<-'
cvt1_t1 ~~ r01*as_pre_acc
cvt1_t1 ~~ r02*nb_pre_acc
cvt1_t1 ~~ r03*mu_pre_acc
cvt1_t1 ~~ r04*animals_acc
cvt1_t1 ~~ r05*nb_num_acc
cvt1_t1 ~~ r06*mus_pre_acc
cvt1_t2 ~~ r07*as_pre_acc
cvt1_t2 ~~ r08*nb_pre_acc
cvt1_t2 ~~ r09*mu_pre_acc
cvt1_t2 ~~ r10*animals_acc
cvt1_t2 ~~ r11*nb_num_acc
cvt1_t2 ~~ r12*mus_pre_acc
cvt1_t3 ~~ r13*as_pre_acc
cvt1_t3 ~~ r14*nb_pre_acc
cvt1_t3 ~~ r15*mu_pre_acc
cvt1_t3 ~~ r16*animals_acc
cvt1_t3 ~~ r17*nb_num_acc
cvt1_t3 ~~ r18*mus_pre_acc
cvt1_t4 ~~ r19*as_pre_acc
cvt1_t4 ~~ r20*nb_pre_acc
cvt1_t4 ~~ r21*mu_pre_acc
cvt1_t4 ~~ r22*animals_acc
cvt1_t4 ~~ r23*nb_num_acc
cvt1_t4 ~~ r24*mus_pre_acc
oet1_t1 ~~ r25*as_pre_acc
oet1_t1 ~~ r26*nb_pre_acc
oet1_t1 ~~ r27*mu_pre_acc
oet1_t1 ~~ r28*animals_acc
oet1_t1 ~~ r29*nb_num_acc
oet1_t1 ~~ r30*mus_pre_acc
oet1_t2 ~~ r31*as_pre_acc
oet1_t2 ~~ r32*nb_pre_acc
oet1_t2 ~~ r33*mu_pre_acc
oet1_t2 ~~ r34*animals_acc
oet1_t2 ~~ r35*nb_num_acc
oet1_t2 ~~ r36*mus_pre_acc
oet1_t3 ~~ r37*as_pre_acc
oet1_t3 ~~ r38*nb_pre_acc
oet1_t3 ~~ r39*mu_pre_acc
oet1_t3 ~~ r40*animals_acc
oet1_t3 ~~ r41*nb_num_acc
oet1_t3 ~~ r42*mus_pre_acc
oet1_t4 ~~ r43*as_pre_acc
oet1_t4 ~~ r44*nb_pre_acc
oet1_t4 ~~ r45*mu_pre_acc
oet1_t4 ~~ r46*animals_acc
oet1_t4 ~~ r47*nb_num_acc
oet1_t4 ~~ r48*mus_pre_acc
syt1_t1 ~~ r49*as_pre_acc
syt1_t1 ~~ r50*nb_pre_acc
syt1_t1 ~~ r51*mu_pre_acc
syt1_t1 ~~ r52*animals_acc
syt1_t1 ~~ r53*nb_num_acc
syt1_t1 ~~ r54*mus_pre_acc
syt1_t2 ~~ r55*as_pre_acc
syt1_t2 ~~ r56*nb_pre_acc
syt1_t2 ~~ r57*mu_pre_acc
syt1_t2 ~~ r58*animals_acc
syt1_t2 ~~ r59*nb_num_acc
syt1_t2 ~~ r60*mus_pre_acc
syt1_t3 ~~ r61*as_pre_acc
syt1_t3 ~~ r62*nb_pre_acc
syt1_t3 ~~ r63*mu_pre_acc
syt1_t3 ~~ r64*animals_acc
syt1_t3 ~~ r65*nb_num_acc
syt1_t3 ~~ r66*mus_pre_acc
syt1_t4 ~~ r67*as_pre_acc
syt1_t4 ~~ r68*nb_pre_acc
syt1_t4 ~~ r69*mu_pre_acc
syt1_t4 ~~ r70*animals_acc
syt1_t4 ~~ r71*nb_num_acc
syt1_t4 ~~ r72*mus_pre_acc

cvt1_t1 ~~ as_post_acc
cvt1_t1 ~~ nb_post_acc
cvt1_t1 ~~ mu_post_acc
cvt1_t1 ~~ animals_acc_post
cvt1_t1 ~~ nb_num_acc_post
cvt1_t1 ~~ mus_post_acc
cvt1_t2 ~~ as_post_acc
cvt1_t2 ~~ nb_post_acc
cvt1_t2 ~~ mu_post_acc
cvt1_t2 ~~ animals_acc_post
cvt1_t2 ~~ nb_num_acc_post
cvt1_t2 ~~ mus_post_acc
cvt1_t3 ~~ as_post_acc
cvt1_t3 ~~ nb_post_acc
cvt1_t3 ~~ mu_post_acc
cvt1_t3 ~~ animals_acc_post
cvt1_t3 ~~ nb_num_acc_post
cvt1_t3 ~~ mus_post_acc
cvt1_t4 ~~ as_post_acc
cvt1_t4 ~~ nb_post_acc
cvt1_t4 ~~ mu_post_acc
cvt1_t4 ~~ animals_acc_post
cvt1_t4 ~~ nb_num_acc_post
cvt1_t4 ~~ mus_post_acc
oet1_t1 ~~as_post_acc
oet1_t1 ~~nb_post_acc
oet1_t1 ~~mu_post_acc
oet1_t1 ~~animals_acc_post
oet1_t1 ~~nb_num_acc_post
oet1_t1 ~~mus_post_acc
oet1_t2 ~~as_post_acc
oet1_t2 ~~nb_post_acc
oet1_t2 ~~mu_post_acc
oet1_t2 ~~animals_acc_post
oet1_t2 ~~nb_num_acc_post
oet1_t2 ~~mus_post_acc
oet1_t3 ~~as_post_acc
oet1_t3 ~~nb_post_acc
oet1_t3 ~~mu_post_acc
oet1_t3 ~~animals_acc_post
oet1_t3 ~~nb_num_acc_post
oet1_t3 ~~mus_post_acc
oet1_t4 ~~as_post_acc
oet1_t4 ~~nb_post_acc
oet1_t4 ~~mu_post_acc
oet1_t4 ~~animals_acc_post
oet1_t4 ~~nb_num_acc_post
oet1_t4 ~~mus_post_acc
syt1_t1 ~~ as_post_acc
syt1_t1 ~~ nb_post_acc
syt1_t1 ~~ mu_post_acc
syt1_t1 ~~ animals_acc_post
syt1_t1 ~~ nb_num_acc_post
syt1_t1 ~~ mus_post_acc
syt1_t2 ~~ as_post_acc
syt1_t2 ~~ nb_post_acc
syt1_t2 ~~ mu_post_acc
syt1_t2 ~~ animals_acc_post
syt1_t2 ~~ nb_num_acc_post
syt1_t2 ~~ mus_post_acc
syt1_t3 ~~ as_post_acc
syt1_t3 ~~ nb_post_acc
syt1_t3 ~~ mu_post_acc
syt1_t3 ~~ animals_acc_post
syt1_t3 ~~ nb_num_acc_post
syt1_t3 ~~ mus_post_acc
syt1_t4 ~~ as_post_acc
syt1_t4 ~~ nb_post_acc
syt1_t4 ~~ mu_post_acc
syt1_t4 ~~ animals_acc_post
syt1_t4 ~~ nb_num_acc_post
syt1_t4 ~~ mus_post_acc

cvt2_t1 ~~ as_pre_acc
cvt2_t1 ~~ nb_pre_acc
cvt2_t1 ~~ mu_pre_acc
cvt2_t1 ~~ animals_acc
cvt2_t1 ~~ nb_num_acc
cvt2_t1 ~~ mus_pre_acc
cvt2_t2 ~~ as_pre_acc
cvt2_t2 ~~ nb_pre_acc
cvt2_t2 ~~ mu_pre_acc
cvt2_t2 ~~ animals_acc
cvt2_t2 ~~ nb_num_acc
cvt2_t2 ~~ mus_pre_acc
cvt2_t3 ~~ as_pre_acc
cvt2_t3 ~~ nb_pre_acc
cvt2_t3 ~~ mu_pre_acc
cvt2_t3 ~~ animals_acc
cvt2_t3 ~~ nb_num_acc
cvt2_t3 ~~ mus_pre_acc
cvt2_t4 ~~ as_pre_acc
cvt2_t4 ~~ nb_pre_acc
cvt2_t4 ~~ mu_pre_acc
cvt2_t4 ~~ animals_acc
cvt2_t4 ~~ nb_num_acc
cvt2_t4 ~~ mus_pre_acc
oet2_t1 ~~as_pre_acc
oet2_t1 ~~nb_pre_acc
oet2_t1 ~~mu_pre_acc
oet2_t1 ~~animals_acc
oet2_t1 ~~nb_num_acc
oet2_t1 ~~mus_pre_acc
oet2_t2 ~~as_pre_acc
oet2_t2 ~~nb_pre_acc
oet2_t2 ~~mu_pre_acc
oet2_t2 ~~animals_acc
oet2_t2 ~~nb_num_acc
oet2_t2 ~~mus_pre_acc
oet2_t3 ~~as_pre_acc
oet2_t3 ~~nb_pre_acc
oet2_t3 ~~mu_pre_acc
oet2_t3 ~~animals_acc
oet2_t3 ~~nb_num_acc
oet2_t3 ~~mus_pre_acc
oet2_t4 ~~as_pre_acc
oet2_t4 ~~nb_pre_acc
oet2_t4 ~~mu_pre_acc
oet2_t4 ~~animals_acc
oet2_t4 ~~nb_num_acc
oet2_t4 ~~mus_pre_acc
syt2_t1 ~~ as_pre_acc
syt2_t1 ~~ nb_pre_acc
syt2_t1 ~~ mu_pre_acc
syt2_t1 ~~ animals_acc
syt2_t1 ~~ nb_num_acc
syt2_t1 ~~ mus_pre_acc
syt2_t2 ~~ as_pre_acc
syt2_t2 ~~ nb_pre_acc
syt2_t2 ~~ mu_pre_acc
syt2_t2 ~~ animals_acc
syt2_t2 ~~ nb_num_acc
syt2_t2 ~~ mus_pre_acc
syt2_t3 ~~ as_pre_acc
syt2_t3 ~~ nb_pre_acc
syt2_t3 ~~ mu_pre_acc
syt2_t3 ~~ animals_acc
syt2_t3 ~~ nb_num_acc
syt2_t3 ~~ mus_pre_acc
syt2_t4 ~~ as_pre_acc
syt2_t4 ~~ nb_pre_acc
syt2_t4 ~~ mu_pre_acc
syt2_t4 ~~ animals_acc
syt2_t4 ~~ nb_num_acc
syt2_t4 ~~ mus_pre_acc

cvt1_t1 ~~ cvt1_t2
cvt1_t1 ~~ cvt1_t3
cvt1_t1 ~~ cvt1_t4
cvt1_t2 ~~ cvt1_t3
cvt1_t2 ~~ cvt1_t4
cvt1_t3 ~~ cvt1_t4

cvt1_t1 ~~ oet1_t1
cvt1_t1 ~~ oet1_t2
cvt1_t1 ~~ oet1_t3
cvt1_t1 ~~ oet1_t4
cvt1_t2 ~~ oet1_t1
cvt1_t2 ~~ oet1_t2
cvt1_t2 ~~ oet1_t3
cvt1_t2 ~~ oet1_t4
cvt1_t3 ~~ oet1_t1
cvt1_t3 ~~ oet1_t2
cvt1_t3 ~~ oet1_t3
cvt1_t3 ~~ oet1_t4
cvt1_t4 ~~ oet1_t1
cvt1_t4 ~~ oet1_t2
cvt1_t4 ~~ oet1_t3
cvt1_t4 ~~ oet1_t4

cvt1_t1 ~~ syt1_t1
cvt1_t1 ~~ syt1_t2
cvt1_t1 ~~ syt1_t3
cvt1_t1 ~~ syt1_t4
cvt1_t2 ~~ syt1_t1
cvt1_t2 ~~ syt1_t2
cvt1_t2 ~~ syt1_t3
cvt1_t2 ~~ syt1_t4
cvt1_t3 ~~ syt1_t1
cvt1_t3 ~~ syt1_t2
cvt1_t3 ~~ syt1_t3
cvt1_t3 ~~ syt1_t4
cvt1_t4 ~~ syt1_t1
cvt1_t4 ~~ syt1_t2
cvt1_t4 ~~ syt1_t3
cvt1_t4 ~~ syt1_t4

cvt1_t1 ~~ cvt2_t1
cvt1_t1 ~~ cvt2_t2
cvt1_t1 ~~ cvt2_t3
cvt1_t1 ~~ cvt2_t4
cvt1_t2 ~~ cvt2_t1
cvt1_t2 ~~ cvt2_t2
cvt1_t2 ~~ cvt2_t3
cvt1_t2 ~~ cvt2_t4
cvt1_t3 ~~ cvt2_t1
cvt1_t3 ~~ cvt2_t2
cvt1_t3 ~~ cvt2_t3
cvt1_t3 ~~ cvt2_t4
cvt1_t4 ~~ cvt2_t1
cvt1_t4 ~~ cvt2_t2
cvt1_t4 ~~ cvt2_t3
cvt1_t4 ~~ cvt2_t4


cvt1_t1 ~~ oet2_t1
cvt1_t1 ~~ oet2_t2
cvt1_t1 ~~ oet2_t3
cvt1_t1 ~~ oet2_t4
cvt1_t2 ~~ oet2_t1
cvt1_t2 ~~ oet2_t2
cvt1_t2 ~~ oet2_t3
cvt1_t2 ~~ oet2_t4
cvt1_t3 ~~ oet2_t1
cvt1_t3 ~~ oet2_t2
cvt1_t3 ~~ oet2_t3
cvt1_t3 ~~ oet2_t4
cvt1_t4 ~~ oet2_t1
cvt1_t4 ~~ oet2_t2
cvt1_t4 ~~ oet2_t3
cvt1_t4 ~~ oet2_t4

cvt1_t1 ~~ syt2_t1
cvt1_t1 ~~ syt2_t2
cvt1_t1 ~~ syt2_t3
cvt1_t1 ~~ syt2_t4
cvt1_t2 ~~ syt2_t1
cvt1_t2 ~~ syt2_t2
cvt1_t2 ~~ syt2_t3
cvt1_t2 ~~ syt2_t4
cvt1_t3 ~~ syt2_t1
cvt1_t3 ~~ syt2_t2
cvt1_t3 ~~ syt2_t3
cvt1_t3 ~~ syt2_t4
cvt1_t4 ~~ syt2_t1
cvt1_t4 ~~ syt2_t2
cvt1_t4 ~~ syt2_t3
cvt1_t4 ~~ syt2_t4




#digits_pre
oet1_t1 ~~ oet1_t2
oet1_t1 ~~ oet1_t3
oet1_t1 ~~ oet1_t4
oet1_t2 ~~ oet1_t3
oet1_t2 ~~ oet1_t4
oet1_t3 ~~ oet1_t4

oet1_t1 ~~ syt1_t1
oet1_t1 ~~ syt1_t2
oet1_t1 ~~ syt1_t3
oet1_t1 ~~ syt1_t4
oet1_t2 ~~ syt1_t1
oet1_t2 ~~ syt1_t2
oet1_t2 ~~ syt1_t3
oet1_t2 ~~ syt1_t4
oet1_t3 ~~ syt1_t1
oet1_t3 ~~ syt1_t2
oet1_t3 ~~ syt1_t3
oet1_t3 ~~ syt1_t4
oet1_t4 ~~ syt1_t1
oet1_t4 ~~ syt1_t2
oet1_t4 ~~ syt1_t3
oet1_t4 ~~ syt1_t4

oet1_t1 ~~ cvt2_t1
oet1_t1 ~~ cvt2_t2
oet1_t1 ~~ cvt2_t3
oet1_t1 ~~ cvt2_t4
oet1_t2 ~~ cvt2_t1
oet1_t2 ~~ cvt2_t2
oet1_t2 ~~ cvt2_t3
oet1_t2 ~~ cvt2_t4
oet1_t3 ~~ cvt2_t1
oet1_t3 ~~ cvt2_t2
oet1_t3 ~~ cvt2_t3
oet1_t3 ~~ cvt2_t4
oet1_t4 ~~ cvt2_t1
oet1_t4 ~~ cvt2_t2
oet1_t4 ~~ cvt2_t3
oet1_t4 ~~ cvt2_t4


oet1_t1 ~~ oet2_t1
oet1_t1 ~~ oet2_t2
oet1_t1 ~~ oet2_t3
oet1_t1 ~~ oet2_t4
oet1_t2 ~~ oet2_t1
oet1_t2 ~~ oet2_t2
oet1_t2 ~~ oet2_t3
oet1_t2 ~~ oet2_t4
oet1_t3 ~~ oet2_t1
oet1_t3 ~~ oet2_t2
oet1_t3 ~~ oet2_t3
oet1_t3 ~~ oet2_t4
oet1_t4 ~~ oet2_t1
oet1_t4 ~~ oet2_t2
oet1_t4 ~~ oet2_t3
oet1_t4 ~~ oet2_t4

oet1_t1 ~~ syt2_t1
oet1_t1 ~~ syt2_t2
oet1_t1 ~~ syt2_t3
oet1_t1 ~~ syt2_t4
oet1_t2 ~~ syt2_t1
oet1_t2 ~~ syt2_t2
oet1_t2 ~~ syt2_t3
oet1_t2 ~~ syt2_t4
oet1_t3 ~~ syt2_t1
oet1_t3 ~~ syt2_t2
oet1_t3 ~~ syt2_t3
oet1_t3 ~~ syt2_t4
oet1_t4 ~~ syt2_t1
oet1_t4 ~~ syt2_t2
oet1_t4 ~~ syt2_t3
oet1_t4 ~~ syt2_t4

#figures-pre
syt1_t1 ~~ syt1_t2
syt1_t1 ~~ syt1_t3
syt1_t1 ~~ syt1_t4
syt1_t2 ~~ syt1_t3
syt1_t2 ~~ syt1_t4
syt1_t3 ~~ syt1_t4

syt1_t1 ~~ cvt2_t1
syt1_t1 ~~ cvt2_t2
syt1_t1 ~~ cvt2_t3
syt1_t1 ~~ cvt2_t4
syt1_t2 ~~ cvt2_t1
syt1_t2 ~~ cvt2_t2
syt1_t2 ~~ cvt2_t3
syt1_t2 ~~ cvt2_t4
syt1_t3 ~~ cvt2_t1
syt1_t3 ~~ cvt2_t2
syt1_t3 ~~ cvt2_t3
syt1_t3 ~~ cvt2_t4
syt1_t4 ~~ cvt2_t1
syt1_t4 ~~ cvt2_t2
syt1_t4 ~~ cvt2_t3
syt1_t4 ~~ cvt2_t4

syt1_t1 ~~ oet2_t1
syt1_t1 ~~ oet2_t2
syt1_t1 ~~ oet2_t3
syt1_t1 ~~ oet2_t4
syt1_t2 ~~ oet2_t1
syt1_t2 ~~ oet2_t2
syt1_t2 ~~ oet2_t3
syt1_t2 ~~ oet2_t4
syt1_t3 ~~ oet2_t1
syt1_t3 ~~ oet2_t2
syt1_t3 ~~ oet2_t3
syt1_t3 ~~ oet2_t4
syt1_t4 ~~ oet2_t1
syt1_t4 ~~ oet2_t2
syt1_t4 ~~ oet2_t3
syt1_t4 ~~ oet2_t4

syt1_t1 ~~ syt2_t1
syt1_t1 ~~ syt2_t2
syt1_t1 ~~ syt2_t3
syt1_t1 ~~ syt2_t4
syt1_t2 ~~ syt2_t1
syt1_t2 ~~ syt2_t2
syt1_t2 ~~ syt2_t3
syt1_t2 ~~ syt2_t4
syt1_t3 ~~ syt2_t1
syt1_t3 ~~ syt2_t2
syt1_t3 ~~ syt2_t3
syt1_t3 ~~ syt2_t4
syt1_t4 ~~ syt2_t1
syt1_t4 ~~ syt2_t2
syt1_t4 ~~ syt2_t3
syt1_t4 ~~ syt2_t4

#letters- post
cvt2_t1 ~~ cvt2_t2
cvt2_t1 ~~ cvt2_t3
cvt2_t1 ~~ cvt2_t4
cvt2_t2 ~~ cvt2_t3
cvt2_t2 ~~ cvt2_t4
cvt2_t3 ~~ cvt2_t4

cvt2_t1 ~~ oet2_t1
cvt2_t1 ~~ oet2_t2
cvt2_t1 ~~ oet2_t3
cvt2_t1 ~~ oet2_t4
cvt2_t2 ~~ oet2_t1
cvt2_t2 ~~ oet2_t2
cvt2_t2 ~~ oet2_t3
cvt2_t2 ~~ oet2_t4
cvt2_t3 ~~ oet2_t1
cvt2_t3 ~~ oet2_t2
cvt2_t3 ~~ oet2_t3
cvt2_t3 ~~ oet2_t4
cvt2_t4 ~~ oet2_t1
cvt2_t4 ~~ oet2_t2
cvt2_t4 ~~ oet2_t3
cvt2_t4 ~~ oet2_t4

cvt2_t1 ~~ syt2_t1
cvt2_t1 ~~ syt2_t2
cvt2_t1 ~~ syt2_t3
cvt2_t1 ~~ syt2_t4
cvt2_t2 ~~ syt2_t1
cvt2_t2 ~~ syt2_t2
cvt2_t2 ~~ syt2_t3
cvt2_t2 ~~ syt2_t4
cvt2_t3 ~~ syt2_t1
cvt2_t3 ~~ syt2_t2
cvt2_t3 ~~ syt2_t3
cvt2_t3 ~~ syt2_t4
cvt2_t4 ~~ syt2_t1
cvt2_t4 ~~ syt2_t2
cvt2_t4 ~~ syt2_t3
cvt2_t4 ~~ syt2_t4

#digits-post
oet2_t1 ~~ oet2_t2
oet2_t1 ~~ oet2_t3
oet2_t1 ~~ oet2_t4
oet2_t2 ~~ oet2_t3
oet2_t2 ~~ oet2_t4
oet2_t3 ~~ oet2_t4

oet2_t1 ~~ syt2_t1
oet2_t1 ~~ syt2_t2
oet2_t1 ~~ syt2_t3
oet2_t1 ~~ syt2_t4
oet2_t2 ~~ syt2_t1
oet2_t2 ~~ syt2_t2
oet2_t2 ~~ syt2_t3
oet2_t2 ~~ syt2_t4
oet2_t3 ~~ syt2_t1
oet2_t3 ~~ syt2_t2
oet2_t3 ~~ syt2_t3
oet2_t3 ~~ syt2_t4
oet2_t4 ~~ syt2_t1
oet2_t4 ~~ syt2_t2
oet2_t4 ~~ syt2_t3
oet2_t4 ~~ syt2_t4

syt2_t1 ~~ syt2_t2
syt2_t1 ~~ syt2_t3
syt2_t1 ~~ syt2_t4
syt2_t2 ~~ syt2_t3
syt2_t2 ~~ syt2_t4
syt2_t3 ~~ syt2_t4

as_pre_acc ~~ nb_pre_acc
as_pre_acc ~~ mu_pre_acc
as_pre_acc ~~ animals_acc
as_pre_acc ~~ nb_num_acc
as_pre_acc ~~ mus_pre_acc
as_pre_acc ~~ as_post_acc
as_pre_acc ~~ nb_post_acc
as_pre_acc ~~ mu_post_acc
as_pre_acc ~~ animals_acc_post
as_pre_acc ~~ nb_num_acc_post
as_pre_acc ~~ mus_post_acc

nb_pre_acc ~~ mu_pre_acc
nb_pre_acc ~~ animals_acc
nb_pre_acc ~~ nb_num_acc
nb_pre_acc ~~ mus_pre_acc
nb_pre_acc ~~ as_post_acc
nb_pre_acc ~~ nb_post_acc
nb_pre_acc ~~ mu_post_acc
nb_pre_acc ~~ animals_acc_post
nb_pre_acc ~~ nb_num_acc_post
nb_pre_acc ~~ mus_post_acc

mu_pre_acc ~~ animals_acc
mu_pre_acc ~~ nb_num_acc
mu_pre_acc ~~ mus_pre_acc
mu_pre_acc ~~ as_post_acc
mu_pre_acc ~~ nb_post_acc
mu_pre_acc ~~ mu_post_acc
mu_pre_acc ~~ animals_acc_post
mu_pre_acc ~~ nb_num_acc_post
mu_pre_acc ~~ mus_post_acc

animals_acc ~~ nb_num_acc
animals_acc ~~ mus_pre_acc
animals_acc ~~ as_post_acc
animals_acc ~~ nb_post_acc
animals_acc ~~ mu_post_acc
animals_acc ~~ animals_acc_post
animals_acc ~~ nb_num_acc_post
animals_acc ~~ mus_post_acc

nb_num_acc ~~ mus_pre_acc
nb_num_acc ~~ as_post_acc
nb_num_acc ~~ nb_post_acc
nb_num_acc ~~ mu_post_acc
nb_num_acc ~~ animals_acc_post
nb_num_acc ~~ nb_num_acc_post
nb_num_acc ~~ mus_post_acc

mus_pre_acc ~~ as_post_acc
mus_pre_acc ~~ nb_post_acc
mus_pre_acc ~~ mu_post_acc
mus_pre_acc ~~ animals_acc_post
mus_pre_acc ~~ nb_num_acc_post
mus_pre_acc ~~ mus_post_acc

as_post_acc ~~ nb_post_acc
as_post_acc ~~ mu_post_acc
as_post_acc ~~ animals_acc_post
as_post_acc ~~ nb_num_acc_post
as_post_acc ~~ mus_post_acc

nb_post_acc ~~ mu_post_acc
nb_post_acc ~~ animals_acc_post
nb_post_acc ~~ nb_num_acc_post
nb_post_acc ~~ mus_post_acc

mu_post_acc ~~ animals_acc_post
mu_post_acc ~~ nb_num_acc_post
mu_post_acc ~~ mus_post_acc

animals_acc_post ~~ nb_num_acc_post
animals_acc_post ~~ mus_post_acc

nb_num_acc_post ~~ mus_post_acc
'  

fit_constrained <- sem(model_constrained, data = scogito)
summary(fit_constrained, standardized = TRUE)

# Correlations of boundary separation and working memory tasks (Supplemental Table S1)
cor(cogito[,c("cvt1_a","oet1_a","syt1_a", 
              "cvt2_a","oet2_a","syt2_a",  
              "as_pre_acc","nb_pre_acc","mu_pre_acc",
              "animals_acc","nb_num_acc","mus_pre_acc",
              "as_post_acc","nb_post_acc","mu_post_acc",
              "animals_acc_post","nb_num_acc_post","mus_post_acc")], method = "pearson")

# Correlations of non-decision time and working memory tasks (Supplemental Table S2)
cor(cogito[,c("cvt1_t1","oet1_t1","syt1_t1", 
              "cvt2_t1","oet2_t1","syt2_t1",  
              "as_pre_acc","nb_pre_acc","mu_pre_acc",
              "animals_acc","nb_num_acc","mus_pre_acc",
              "as_post_acc","nb_post_acc","mu_post_acc",
              "animals_acc_post","nb_num_acc_post","mus_post_acc")], method = "pearson")

