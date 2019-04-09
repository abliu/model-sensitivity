library(survival)

data_dir = <INSERT YOUR DATA DIRECTORY HERE>
baseline_df = read.csv(file.path(data_dir, 'baseline.csv'))
outcomes_df = read.csv(file.path(data_dir, 'outcomes.csv'))
stopifnot(nrow(baseline_df) == nrow(outcomes_df))
stopifnot(setequal(baseline_df['MASKID'], outcomes_df['MASKID']))
coxph_df = merge(baseline_df, outcomes_df, by = 'MASKID')

# calculate hazard ratio for primary outcome
res_cox_primary_outcome = coxph(Surv(time = T_PRIMARY, event = EVENT_PRIMARY) ~ INTENSIVE, coxph_df)
summary(res_cox_primary_outcome)
# Call:
#   coxph(formula = Surv(time = T_PRIMARY, event = EVENT_PRIMARY) ~ 
#           INTENSIVE, data = coxph_df)
# 
# n= 9361, number of events= 562 
# 
# coef exp(coef) se(coef)      z Pr(>|z|)    
# INTENSIVE -0.28132   0.75479  0.08515 -3.304 0.000954 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# exp(coef) exp(-coef) lower .95 upper .95
# INTENSIVE    0.7548      1.325    0.6388    0.8919
# 
# Concordance= 0.534  (se = 0.011 )
# Rsquare= 0.001   (max possible= 0.658 )
# Likelihood ratio test= 11.02  on 1 df,   p=0.0009019
# Wald test            = 10.92  on 1 df,   p=0.0009537
# Score (logrank) test = 10.99  on 1 df,   p=0.0009172

# calculate hazard ratio for death
res_cox_death = coxph(Surv(time = T_DEATH, event = EVENT_DEATH) ~ INTENSIVE, coxph_df)
summary(res_cox_death)
# Call:
#   coxph(formula = Surv(time = T_DEATH, event = EVENT_DEATH) ~ INTENSIVE, 
#         data = coxph_df)
# 
# n= 9361, number of events= 365 
# 
# coef exp(coef) se(coef)      z Pr(>|z|)   
# INTENSIVE -0.3077    0.7352   0.1059 -2.905  0.00367 **
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# exp(coef) exp(-coef) lower .95 upper .95
# INTENSIVE    0.7352       1.36    0.5974    0.9047
# 
# Concordance= 0.538  (se = 0.014 )
# Rsquare= 0.001   (max possible= 0.499 )
# Likelihood ratio test= 8.54  on 1 df,   p=0.003474
# Wald test            = 8.44  on 1 df,   p=0.003667
# Score (logrank) test = 8.51  on 1 df,   p=0.003535

# How to stratify by NEWSITEID?