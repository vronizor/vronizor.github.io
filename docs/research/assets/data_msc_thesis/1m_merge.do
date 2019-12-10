// Colombian Coops
// 20/04/18
// Master merging

clear all
set more off

cd "/Users/vinceth/MEGAsync/UB ECONOMICS/Year2_17-18/_Thesis/Data/_Master"


//// Starting with the full list of municipalities, from controls

use "../Controls/stata/muni_controls.dta"

// Merging Boyacá control
merge 1:1 codmun year using "../Displaced/stata/recep_ctr.dta"
drop departamento _merge
replace recep_ok=1 if recep_ok==.

*-------*--------------*-------------------------*------------------*----
// Merging conflict measure 1 (old)

merge m:m codmun year using "../Controls/stata/muni_viol.dta"
drop _merge

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                            15,708  (_merge==3)
    -----------------------------------------
*/

* checking if there are unique pairs of municipalities and years
egen g = group(year codmun)
duplicates r g
* ––> no duplicates, all good

* constructing indices of violence :: violent events by 1'000 inhabitants
gen viol_acem = viola_acem/ctr_pobl_tot*1000
gen viol_my = viola_my/ctr_pobl_tot*1000
lab var viol_acem "Acemoglu et al. (2013) measure of violence"
lab var viol_my "Measure of violence"


* creating violence presence and absence dummies
gen viol_pres = 1 if viol_my>0
replace viol_pres = 0 if viol_my==0
lab var viol_pres "Dummy violence presence"
gen viol_abs = 1 if viol_my==0
replace viol_abs = 0 if viol_my>0
lab var viol_abs "Dummy violence absence"

* creating violence presence and absence dummies (Acem)
gen viol_apres = 1 if viol_acem>0
replace viol_apres = 0 if viol_acem==0
lab var viol_apres "Dummy violence presence"
gen viol_aabs = 1 if viol_acem==0
replace viol_aabs = 0 if viol_acem>0
lab var viol_aabs "Dummy violence absence"

corr viol_abs viol_aabs
/*
             | viol_abs vio~aabs
-------------+------------------
    viol_abs |   1.0000
   viol_aabs |   0.6761   1.0000
*/

* creating logs of violence measure
gen lviol_my = log(viol_my)
lab var lviol_my  "Log old_viol"
gen lviol_myp = log(( viol_my * (15707-1) + .5)/15707)
lab var lviol_myp "Log old_viol"

rename H_coca ctr_coca
order ctr_coca, after(ctr_altura)

gen ctr_pib_pcap = ctr_pib_total/ctr_pobl_tot
lab var ctr_pib_pcap "GDP per capita"

* rename dummies presence, create "any armed group presence" dummy
rename (ELN_ FARC_ AUC_)(presELN presFARC presAUC)
gen presANY=1 if presELN==1 | presFARC==1 | presAUC==1
replace presANY=0 if presELN==0 & presFARC==0 & presAUC==0
order presANY, after(presAUC)
lab var presANY "Dummy for any armed group present"




*-------*--------------*-------------------------*------------------*----
// Merging conflict measure 2 ***HECHOS***

merge m:m codmun year using "../Controls/stata/muni_viol_hechos.dta"
tab codmun year if _merge==2
* municipality 27086 (Belén De Bajirá) is missing from master for all periods


/*
    Result                           # of obs.
    -----------------------------------------
    not matched                         3,600
        from master                     3,589  (_merge==1)
        from using                         11  (_merge==2)

    matched                            12,119  (_merge==3)
    -----------------------------------------
*/

* RUV database ––> replace missings by 0s
replace violabs=0 if violabs==.

* generating rates and logs
gen viol_hech = violabs/ctr_pobl_tot*1000
lab var viol_hech "Conflict violence rate"
gen lviol_hech = log((viol_hech * (15707-1) + .5)/15707)
lab var lviol_hech "Log viol_hechos"

* generating presence/absence dummies
gen violhech_pres=1 if viol_hech>0
replace violhech_pres = 0 if viol_hech==0
gen violhech_abs=1 if viol_hech==0
replace violhech_abs = 0 if viol_hech>0

drop _merge


*-------*--------------*-------------------------*------------------*----
// Merging conflict measure 3 ***dur3ruv***, stays in absolute terms

merge m:m codmun year using "../Controls/stata/muni_viol_dur3ruv.dta"

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                         7,140
        from master                     7,140  (_merge==1)
        from using                          0  (_merge==2)

    matched                             8,579  (_merge==3)
*/

* RUV database ––> replace missings by 0s
replace dur3ruv=0 if dur3ruv==.

* generating logs
gen lviol_dur3ruv = log((dur3ruv * (15707-1) + .5)/15707)
lab var lviol_dur3ruv "Log viol_dur3ruv"

drop _merge

*-------*--------------*-------------------------*------------------*----
// Merging conflict measure 4 ***pop_cede, dur2, dur3cede***, stays in absolute terms

merge m:m codmun year using "../Controls/stata/muni_violCEDE.dta"

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                            11
        from master                        11  (_merge==1)
        from using                          0  (_merge==2)

    matched                            15,708  (_merge==3)
    -----------------------------------------
*/

list codmun mun year if _merge==1
* municipality 27086 (Belén De Bajirá) is missing from master for 11 periods

* generating rates and logs
gen violpop = viola_mypop/ctr_pobl_tot*1000
lab var violpop "Conlfict violence rate, CEDE"
gen lviol_pop=log((violpop * (15707-1) +.5) / 150707)
lab var lviol_pop "Log viol_popCede"

gen lviol_dur2 = log((dur2 * (15707-1) + .5)/15707)
lab var lviol_dur2 "Log viol_dur2"

gen lviol_dur3cede = log((dur3cede * (15707-1) + .5)/15707)
lab var lviol_dur3cede "Log viol_dur3cede"

lab var dur2 "Violence measure"

* generating presence/absence dummies
gen violpop_pres=1 if violpop>0
replace violpop_pres = 0 if violpop==0
gen violpop_abs=1 if violpop==0
replace violpop_abs = 0 if violpop>0

gen dur2_pres=0 if dur2==0
replace dur2_pres=1 if dur2>0
gen dur2_abs=0 if dur2>0
replace dur2_abs=1 if dur2==0
lab var dur2_abs "Absence of conflict"

drop _merge

* grouping for ease later
global viol_og violpop dur2
global viol lviol_hech lviol_pop lviol_dur2 lviol_dur3cede lviol_dur3ruv
global violdur23cede lviol_dur2 lviol_dur3cede
global violdur23ruv lviol_dur2 lviol_dur3ruv

sum dur3cede



// Checking consistency across violence measure

corr viol_my violpop viol_hech
corr lviol_hech lviol_pop lviol_dur2 lviol_dur3cede lviol_dur3ruv
/*
. corr viol_my violpop violhech
(obs=13,445)

             |  viol_my  violpop violhech
-------------+---------------------------
     viol_my |   1.0000
     violpop |   0.6358   1.0000
    violhech |   0.4791   0.3761   1.0000
	

. corr lviol_hech lviol_dur2 lviol_dur3ruv lviol_dur3cede
(obs=7,203)

             | lviol_~h lviol_~2 lviol_~v lviol_~e
-------------+------------------------------------
  lviol_hech |   1.0000
  lviol_dur2 |   0.3490   1.0000
lviol_dur3~v |   0.7252   0.3863   1.0000
lviol_dur3~e |   0.1063   0.1594   0.1700   1.0000
*/

sum lviol_hech lviol_dur2 lviol_dur3ruv lviol_dur3cede
/*
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
  lviol_hech |     15,685   -2.164068    4.632918  -10.35501   4.678797
  lviol_dur2 |     12,342   -7.852155    4.712314  -10.35501   5.351795
lviol_dur3~v |     15,719   -3.144073     6.64996  -10.35501   8.729334
lviol_dur3~e |     12,342   -10.01483    1.998752  -10.35501   3.931763

*/


*-----------*--------------------*------------*----------*---------------
// Merging displaced

merge m:m codmun year using "../Displaced/stata/muni_displ.dta"
tab codmun year if _merge==2
* municipality 27086 (Belén De Bajirá) is missing from master for all periods

drop _merge

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                         1,794
        from master                     1,780  (_merge==1)
        from using                         14  (_merge==2)

    matched                            13,928  (_merge==3)
    -----------------------------------------
*/


* setting missing displacement as 0
ds displ_*
foreach v in `r(varlist)' {
	replace `v' = 0 if `v' ==.
}

* constructing indices of displacement :: displaced by 1'000 inhabitants
ds displ_*
foreach v in `r(varlist)' {
	gen `v'_r = `v'/ctr_pobl_tot*1000
}
rename *_r displr__*
rename *_displ_* **
lab var displr_tot "Total displaced (1000s)"
lab var displr_m "Male displaced"
lab var displr_f "Female displaced"
lab var displr_l "LGBTI displaced"
lab var displr_gend_un "Unkn. gender displaced"
lab var displr_child "Children displaced"
lab var displr_adul "Adults displaced"
lab var displr_seni "Seniors displaced"
lab var displr_age_un "Unkn. age displaced"
lab var displr_youn "Youth displaced"
lab var displr_old "All adults displaced"
lab var displr_eur "No ethnicity displaced"
lab var displr_afr "Afro-Colombian displaced"
lab var displr_indi "Indigenous displaced"
lab var displr_cdisc "With disability displaced"
lab var displr_sdisc "Without disability displaced"

* repacing missings (gen by dividing by 0) by 0
ds displr_*
foreach v in `r(varlist)' {
	replace `v'=0 if ctr_pobl_tot==0
}

* constructing per habitant rate
ds displ_*
foreach v in `r(varlist)' {
	gen `v'_h = `v'/ctr_pobl_tot
}
rename *_h displh__*
rename *_displ_* **
lab var displh_tot "Proportion displaced"
lab var displh_m "Male displaced"
lab var displh_f "Female displaced"
lab var displh_l "LGBTI displaced"
lab var displh_gend_un "Unkn. gender displaced"
lab var displh_child "Children displaced"
lab var displh_adul "Adults displaced"
lab var displh_seni "Seniors displaced"
lab var displh_age_un "Unkn. age displaced"
lab var displh_youn "Youth displaced"
lab var displh_old "All adults displaced"
lab var displh_eur "No ethnicity displaced"
lab var displh_afr "Afro-Colombian displaced"
lab var displh_indi "Indigenous displaced"
lab var displh_cdisc "With disability displaced"
lab var displh_sdisc "Without disability displaced"

* dummy for displaced municipality (and its contrary)
gen displ_dum = 1 if displ_tot!=0
replace displ_dum = 0 if displ_tot==0
gen displ_abs = 1 if displ_tot==0
replace displ_abs = 0 if displ_tot!=0
lab var displ_dum "Displaced dummy"
lab var displ_abs "Absence of displacement"

*-----------------*---------------------*-----------*-------------*-----
// Merging coops

merge m:m codmun year using "../Supersolidaria/stata/muni_coop.dta"
drop _merge

/*

    Result                           # of obs.
    -----------------------------------------
    not matched                         9,108
        from master                     9,108  (_merge==1)
        from using                          0  (_merge==2)

    matched                             6,614  (_merge==3)
    -----------------------------------------
*/

* setting missing coops as 0

ds coop_*
foreach v in `r(varlist)' {
	replace `v' = 0 if `v' ==.
}

* constructing indices of cooperative presence :: employment and members by 1'000 inhabitants
/* More efficient but too late
ds coop_*
foreach v in `r(varlist)' {
	gen `v'_r = `v'/ctr_pobl_tot*1000
}
rename *_r coopre__*
order coopre__*, after(coopr_nfasso)
gen good=1 if coopre__*==coopr_*
rename *_coop_* **
*/

gen coopr_tot = coop_tot/ctr_pobl_tot*10000
gen coopr_fin = coop_fin/ctr_pobl_tot*10000 
gen coopr_nfin = coop_nfin/ctr_pobl_tot*10000
gen coopr_empl = coop_empl/ctr_pobl_tot*10000
gen coopr_fempl = coop_fempl/ctr_pobl_tot*10000
gen coopr_nfempl = coop_nfempl/ctr_pobl_tot*10000
gen coopr_asso = coop_asso/ctr_pobl_tot*10000
gen coopr_fasso = coop_fasso/ctr_pobl_tot*10000
gen coopr_nfasso = coop_nfasso/ctr_pobl_tot*10000
gen coopr_prodasso = coop_prodasso/ctr_pobl_tot*10000
gen coopr_tipfinasso = coop_tipfinasso/ctr_pobl_tot*10000
gen coopr_tipNfinasso = coop_tipNfinasso/ctr_pobl_tot*10000
lab var coopr_tot "Cooperatives"
lab var coopr_fin "Financial Coop."
lab var coopr_nfin "Non-fin. cooperatives"
lab var coopr_empl "Coop. employees"
lab var coopr_fempl "Fin. Coop. employees"
lab var coopr_nfempl "Non-fin. Coop. employees"
lab var coopr_asso "Coop. members"
lab var coopr_fasso "Fin. Coop. members"
lab var coopr_nfasso "Non-fin. Coop. members"

global assos coopr_asso coopr_fasso coopr_nfasso coopr_prodasso coopr_tipfinasso coopr_tipNfinasso

* constructing indices of relative importance of financial coops (compared to all coops)
gen coop_fin_pr = coop_fin/coop_tot*100
gen coop_nfin_pr = coop_nfin/coop_tot*100
gen coop_fempl_pr = coop_fempl/coop_empl*100
gen coop_nfempl_pr = coop_nfempl/coop_empl*100
gen coop_fasso_pr = coop_fasso/coop_asso*100
gen coop_nfasso_pr = coop_nfasso/coop_asso*100
lab var coop_fin_pr "Proportion of Financial cooperatives"
lab var coop_nfin_pr "Proportion of Non-financial cooperatives"
lab var coop_fempl_pr "Proportion of Fin. Coop. employees"
lab var coop_nfempl_pr "Proportion of Non-fin. Coop. employees"
lab var coop_fasso_pr "Proportion of Fin. Coop. members"
lab var coop_nfasso_pr "Proportion of Non-fin. Coop. members"

* repacing missings (gen by dividing by 0) by 0
ds coopr_* *_pr
foreach v in `r(varlist)' {
	replace `v'=0 if ctr_pobl_tot==0
}

* creating presence dummy if at least one coop that year
gen coop_pres = 1 if coop_tot>0
replace coop_pres = 0 if coop_tot==0
lab var coop_pres "Dummy presence of cooperative"

* creating presence dummy if at least one coop member that year
gen coop_mem_pres = 1 if coop_asso>0
replace coop_mem_pres = 0 if coop_asso==0
lab var coop_mem_pres "Dummy presence of cooperative member"
gen coop_mem_abs = 1 if coop_asso==0
replace coop_mem_abs = 0 if coop_asso>0
lab var coop_mem_abs "Absence of cooperative members"


* creating categories of population
tab ctr_pobl_tot if ctr_pobl_tot==0
/*
      Popul |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |         23      100.00      100.00
------------+-----------------------------------
      Total |         23      100.00
*/
* –––> 23 municipalities with 0 population
gen ctr_size = 1 if ctr_pobl_tot<20000
replace ctr_size = 2 if ctr_pobl_tot>=20000 & ctr_pobl_tot<200000
replace ctr_size = 3 if ctr_pobl_tot>=200000 & ctr_pobl_tot<1000000
replace ctr_size = 4 if ctr_pobl_tot>=1000000
lab var ctr_size "Municipality size group"

tab ctr_size
* hist ctr_size

*-----------------*---------------------*-----------*-------------*-----
// Creating categorical variables for main vars

* diplacement categories
sum displr_tot, det
/*
         Total displaced
-------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0     
25%     .8167933              0     

50%     3.535537                    
                        Largest     
75%     13.03571       656.1182
90%     34.99223       686.4658     
95%     57.73146       765.6877     
99%     133.1573       781.8154 
*/
gen displr_int = 1 if displ_tot==0
replace displr_int = 2 if displ_tot>0 & displ_tot<4
replace displr_int = 3 if displ_tot>4 & displ_tot<35
replace displr_int = 4 if displ_tot>35
lab var displr_int "Displacement category"

* violence intensity categories
sum viol_my, detail
/*
      Measure of violence
-------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0
25%     .0794344              0

50%     .2813731               
                        Largest
75%     .6596306       14.88643
90%      1.30662       16.29528
95%     1.989212       18.33167
99%     4.345464       54.48718 
*/
gen viol_int = 1 if viol_my==0
replace viol_int = 2 if viol_my>0 & viol_my<.3
replace viol_int = 3 if viol_my>.3 & viol_my<1.3
replace viol_int = 4 if viol_my>1.3
lab var viol_int "Violence category"

* coop membership intensity categories
sum coopr_asso, detail
/*
         Coop. members
-------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0
25%            0              0

50%            0               
                        Largest
75%     3.870968       7935.149
90%     45.01594       9102.562
95%      140.407       10277.83
99%      563.727       11184.91
*/
gen coopr_asso_int = 1 if coopr_asso==0
replace coopr_asso_int = 2 if coopr_asso>0 & coopr_asso<4
replace coopr_asso_int = 3 if coopr_asso>4 & coopr_asso<45
replace coopr_asso_int = 4 if coopr_asso>45
lab var coopr_asso_int "Coop membership category"


* rurality categories
sum ctr_indrural, detail
/*
           Rurality
-------------------------------
      Percentiles      Smallest
 1%     .0280966       .0009618
 5%     .1112653       .0010083
10%     .1978869       .0010604
25%      .421511       .0011239

50%     .6171694               
                        Largest
75%     .7682119              1
90%     .8620561              1
95%     .9132363              1
99%            1              1
*/
gen ctr_rural = 1 if ctr_indrural>0.8
replace ctr_rural = 2 if ctr_indrural<0.8 & ctr_indrural>0.6
replace ctr_rural = 3 if ctr_indrural<0.6 & ctr_indrural>0.4
replace ctr_rural = 4 if ctr_indrural<0.4
lab var ctr_rural "Rurality category"

// Rural municipalities according to Ibañez & Vélez (2008)

* pop < 10,000 & rurality >0.5
gen ctr_rural_ib = 1 if ctr_pobl_tot<=10000 & ctr_indrural>=0.5
replace ctr_rural_ib = 0 if ctr_pobl_tot>10000 | ctr_indrural<0.5
lab var ctr_rural_ib "Rural municipality"
sum ctr_rural_ib

* IB alt :: pop < 20,000 & rurality >0.5
gen ctr_rural_ibalt = 1 if ctr_pobl_tot<=20000 & ctr_indrural>=0.5
replace ctr_rural_ibalt = 0 if ctr_pobl_tot>20000 | ctr_indrural<0.5
lab var ctr_rural_ibalt "Rural municipality"
sum ctr_rural_ibalt

*-----------------*---------------------*-----------*-------------*-----
// Cleaning

order coopr_* displr_* viol_* ctr_*, after(municipio)
drop g depd mund mun
rename municipio mun
format mun %28s
format dep %22s
format displ* coop* ctr_* viol_my %9.3gc
format coop_asso %12.0gc

* labelling
lab var year "Year"
lab var codmun "Municipal code"

* dropping Belén de Bajira, territorial dispute, sometimes a municipilaty,
* sometimes a suburb of Riosucio
drop if codmun==27086

* Adding marginal value to coop membership, displacement rate and violence
gen lcoopr_assop = log(( coopr_asso * (15707-1) + .5)/15707)
gen lcoopr_fassop = log(( coopr_fasso * (15707-1) + .5)/15707)
gen lcoopr_nfassop = log(( coopr_nfasso * (15707-1) + .5)/15707)
gen lcoopr_prodassop = log(( coopr_prodasso * (15707-1) + .5)/15707)
gen lcoopr_tipfinassop = log(( coopr_tipfinasso * (15707-1) + .5)/15707)
gen lcoopr_tipNfinassop = log(( coopr_tipNfinasso * (15707-1) + .5)/15707)
lab var lcoopr_assop "Log Coop. members"

gen lcoopr_totp = log(( coopr_tot * (15707-1) + .5)/15707)
lab var lcoopr_assop "Log Coop. presence"

gen ldisplr_totp = log(( displr_tot * (15707-1) + .5)/15707)
lab var ldisplr_totp "Log Total displaced (1000s)"

gen ldisplh_totp = log(( displh_tot * (15707-1) + .5)/15707)
lab var ldisplh_totp "Log Proportion displaced"

* Justifying adding a marginal value to violence too :: not a perfect 
* correspondance between no displaced and no violence
/*
corr viol_abs displ_abs
(obs=15,707)

             | viol_abs displ_~s
-------------+------------------
    viol_abs |   1.0000
   displ_abs |   0.2553   1.0000
*/


* !!! dropping municipalities where more people left than there was inhabitants !!!
drop if displr_tot>1000
/*
* creating logs of rate vars
ds displr_* coopr_*
foreach v in `r(varlist)' {
	gen l`v' = log(`v')
	local label : variable label `v'
	label variable l`v' `"Log `label'"'
}

drop ldisplr_int lcoopr_asso_int
*/
* expanding nbi measures
*replace ctr_nbi=

* set up panel
xtset codmun year

* Dropping 2002 because of violence measure (2015 automatically dropped because violence missing)
* drop if year==2002


* need to construct lagged variables, zoib doesn't recognize time-series operators
gen lcoopr_assop_lag = L.lcoopr_assop
lab var lcoopr_assop_lag "L.Log Coop. members"

gen lcoopr_fassop_lag = L.lcoopr_fassop
lab var lcoopr_fassop_lag "L.Log Coop. members"

gen lcoopr_nfassop_lag = L.lcoopr_nfassop
lab var lcoopr_nfassop_lag "L.Log Non-fin. Coop. members"

gen lcoopr_prodassop_lag = L.lcoopr_prodassop
lab var lcoopr_prodassop_lag "L.Log Production Coop. members"

gen lcoopr_tipfinassop_lag = L.lcoopr_tipfinassop
lab var lcoopr_tipfinassop_lag "L.LogFin. Coop. members (econ. act.)"

gen lcoopr_tipNfinassop_lag = L.lcoopr_tipNfinassop
lab var lcoopr_tipNfinassop_lag "L.Log Non-fin. Coop. members (econ. act.)"

gen lviol_myp_lag = L.lviol_myp
lab var lviol_myp_lag "Log Measure of violence"

gen lviol_hech_lag = L.lviol_hech
gen lviol_pop_lag = L.lviol_pop
gen lviol_dur2_lag = L.lviol_dur2
gen lviol_dur3cede_lag = L.lviol_dur3cede
gen lviol_dur3ruv_lag = L.lviol_dur3ruv

lab var lviol_hech_lag "Log viol_hechos"
lab var lviol_pop_lag "Log viol_popCede"
lab var lviol_dur2_lag "Log viol_dur2"
lab var lviol_dur3cede_lag "Log viol_dur3cede"
lab var lviol_dur3ruv_lag "Log viol_dur3ruv"

global viol_lags lviol_hech_lag lviol_pop_lag lviol_dur2_lag lviol_dur3cede_lag lviol_dur3ruv_lag

* creating sum of displaced by municipality over the whole period
egen overal_displmun = sum(displ_tot), by(codmun)

global timespan "if year>=2003 & year<=2013"
* creating time-avgs
local reg "lcoopr_assop* $viol $viol_lags"
foreach v of varlist `reg'{
	egen `v'_mean = mean(`v') $timespan, by(codmun)
}
/*
foreach v of varlist `reg'{
	egen `v'_mean_big = mean(`v'), by(codmun)
}

global means *_mean

/*
* time-avgs, on original variables
ds $assos $viol_og
local reg "$assos $viol_og"
foreach v of varlist `reg'{
	egen `v'_mean_og = mean(`v'), by(codmun)
	gen `v'_logmean_og = log((`v'_mean_og* (15707-1) + .5)/15707)
}

order *_logmean_og, last
order *_mean, last
*/

gen chk1=0
replace chk1= lcoopr_assop_mean-lcoopr_assop_lag_mean
order lcoopr_assop_lag_mean chk1, after(lcoopr_assop_mean)
sum chk1
sum chk1, det

gen chk2=0
replace chk2= lcoopr_assop_lag_mean-lcoopr_assop_lag_mean_big
order lcoopr_assop_lag_mean_big chk2, after(lcoopr_assop_lag_mean)
sum chk2
sum chk2, det
*/
* some order
order displh_tot displr_tot ldisplh_tot ldisplr_totp lcoopr_assop* $viol ///
	$viol_lags $means , after(mun)

save master_panel, replace

