// Colombian Coops
// 24/04/18
// Regressions 3, basic selection

clear all
set more off

cd "/Users/vinceth/MEGAsync/UB ECONOMICS/Year2_17-18/_Thesis/Data/_Master"

use master_panel

//// Controls

* LAGGED Acemoglu et al. (2013) controls (missing NBI, poverty proxy) ––> 6 years, 260 munic
global ctr_acem ctr_g_terreno ctr_areaoficialkm2 ctr_pobl_tot ctr_indrural ///
	ctr_coca
	
* LAGGED Acemoglu et al. (2013) controls (missing NBI and coca) ––> 9 years, 1091 munic
global ctr_acem2 ctr_g_terreno ctr_areaoficialkm2 ctr_pobl_tot ctr_indrural

* Seminar version controls (not lagged, missing GDP) ––> full period, all munic
global ctr_sem viol_my ctr_precip_dev




//// Simple interaction

// Displ = Coops_all*Violence , fe

xtreg displr_tot c.coopr_tot##c.viol_my , fe
xtreg displr_tot c.coopr_empl##c.viol_my , fe
xtreg displr_tot c.coopr_asso##c.viol_my , fe



// Displ = L.Coops_all*L.Violence , fe

xtreg displr_tot c.L.coopr_tot##c.L.viol_my , fe
xtreg displr_tot c.L.coopr_empl##c.L.viol_my , fe
xtreg displr_tot c.L.coopr_asso##c.L.viol_my , fe



// Displ = L.Coops_all*L.Violence + AcemCtr , fe

xtreg displr_tot c.L.coopr_tot##c.L.viol_my $ctr_acem , fe
xtreg displr_tot c.L.coopr_empl##c.L.viol_my $ctr_acem , fe
xtreg displr_tot c.L.coopr_asso##c.L.viol_my $ctr_acem , fe

* –––> all positive coeff of coops



// Displ = L.Coops_all*L.Violence + AcemCtr2 , fe

xtreg displr_tot c.L.coopr_tot##c.L.viol_my $ctr_acem2 , fe
xtreg displr_tot c.L.coopr_empl##c.L.viol_my $ctr_acem2 , fe
xtreg displr_tot c.L.coopr_asso##c.L.viol_my $ctr_acem2 , fe

* –––> small and highly insignificant effect of coops



// Displ = L.Coops_all*L.Violence + SeminarCtr , fe

xtreg displr_tot c.L.coopr_tot##c.L.viol_my $ctr_sem , fe
xtreg displr_tot c.L.coopr_empl##c.L.viol_my $ctr_sem , fe
xtreg displr_tot c.L.coopr_asso##c.L.viol_my $ctr_sem , fe

/*
. xtreg displr_tot c.L.coopr_asso##c.L.viol_my $ctr_sem , fe

Fixed-effects (within) regression               Number of obs     =     13,441
Group variable: codmun                          Number of groups  =      1,122

R-sq:                                           Obs per group:
     within  = 0.1218                                         min =          6
     between = 0.2931                                         avg =       12.0
     overall = 0.1840                                         max =         12

                                                F(5,12314)        =     341.73
corr(u_i, Xb)  = 0.1139                         Prob > F          =     0.0000

------------------------------------------------------------------------------------------
              displr_tot |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------------------+----------------------------------------------------------------
              coopr_asso |
                     L1. |  -.0088129   .0029696    -2.97   0.003    -.0146339    -.002992
                         |
                 viol_my |
                     L1. |   2.771314   .2673392    10.37   0.000     2.247287    3.295341
                         |
cL.coopr_asso#cL.viol_my |   .0014331   .0006032     2.38   0.018     .0002507    .0026155
                         |
                 viol_my |   9.486255   .2678689    35.41   0.000      8.96119    10.01132
          ctr_precip_dev |  -.0441342   .0123588    -3.57   0.000    -.0683593   -.0199091
                   _cons |   8.636878   .3817049    22.63   0.000     7.888677     9.38508
-------------------------+----------------------------------------------------------------
                 sigma_u |  17.275157
                 sigma_e |  24.935977
                     rho |   .3242991   (fraction of variance due to u_i)
------------------------------------------------------------------------------------------
F test that all u_i=0: F(1121, 12314) = 5.60                 Prob > F = 0.0000
*/






// Displ = L.Coops_nonFin * L.Violence + SeminarCtr , fe

xtreg displr_tot c.L.coopr_nfin##c.L.viol_my $ctr_sem , fe
xtreg displr_tot c.L.coopr_nfempl##c.L.viol_my $ctr_sem , fe
xtreg displr_tot c.L.coopr_nfasso##c.L.viol_my $ctr_sem , fe

/*
. xtreg displr_tot c.L.coopr_nfasso##c.L.viol_my $ctr_sem , fe

Fixed-effects (within) regression               Number of obs     =     13,441
Group variable: codmun                          Number of groups  =      1,122

R-sq:                                           Obs per group:
     within  = 0.1209                                         min =          6
     between = 0.3008                                         avg =       12.0
     overall = 0.1863                                         max =         12

                                                F(5,12314)        =     338.56
corr(u_i, Xb)  = 0.1176                         Prob > F          =     0.0000

--------------------------------------------------------------------------------------------
                displr_tot |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
---------------------------+----------------------------------------------------------------
              coopr_nfasso |
                       L1. |  -.0228091   .0122353    -1.86   0.062    -.0467922    .0011739
                           |
                   viol_my |
                       L1. |   2.781928    .269666    10.32   0.000      2.25334    3.310515
                           |
cL.coopr_nfasso#cL.viol_my |   .0217202   .0081954     2.65   0.008     .0056559    .0377844
                           |
                   viol_my |   9.545627    .267206    35.72   0.000     9.021862    10.06939
            ctr_precip_dev |  -.0438145   .0123683    -3.54   0.000    -.0680582   -.0195708
                     _cons |   8.468651   .3862116    21.93   0.000     7.711616    9.225686
---------------------------+----------------------------------------------------------------
                   sigma_u |  17.192035
                   sigma_e |  24.950088
                       rho |  .32194179   (fraction of variance due to u_i)
--------------------------------------------------------------------------------------------
F test that all u_i=0: F(1121, 12314) = 5.56                 Prob > F = 0.0000
*/
