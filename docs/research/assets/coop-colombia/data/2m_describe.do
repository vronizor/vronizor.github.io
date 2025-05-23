// Colombian Coops
// 23/04/18
// Descriptives


clear all
set more off

cd "/Users/vinceth/MEGAsync/UB ECONOMICS/Year2_17-18/_Thesis/Data/_Master"

use master_panel


*-----------------*---------------------*--------*-----------------*-----
*----------*------------*------------*---------------*-------------*-----
// Coops

//// Total numbers

* how many individual coops over the period?
clear
set more off
use "../Supersolidaria/stata/panel_coop.dta"

xtset codconf year
xtsum codconf
/*
Variable         |      Mean   Std. Dev.       Min        Max |    Observations
-----------------+--------------------------------------------+----------------
codconf  overall |  6170.497   3981.404          0      20009 |     N =   82286
         between |              4116.44          0      20009 |     n =   11484
         within  |                    0   6170.497   6170.497 | T-bar = 7.16527
*/
* –––> 11,484 different coops overall years



clear
set more off
use master_panel

sum year coop_tot
xtsum coop_tot
/*
Variable         |      Mean   Std. Dev.       Min        Max |    Observations
-----------------+--------------------------------------------+----------------
coop_tot overall |  12.44119   89.57465          1       2034 |     N =    6614
         between |             72.53436          1   1811.714 |     n =     716
         within  |             10.17243  -411.2731   234.7269 | T-bar = 9.23743
*/
* –––> 716 municipalities with coops over all periods
* –––> on avg, 12.44 coops/mun/year

tab year, summarize(coop_tot)
/*
            |     Summary of All cooperatives
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   10.995833   79.153006         480
       2003 |    12.07438   85.977817         484
       2004 |   13.035639   92.951469         477
       2005 |   13.266402   95.486428         503
       2006 |   13.058824     95.1713         527
       2007 |   13.129278   94.866655         526
       2008 |   13.033465   92.035415         508
       2009 |   13.205645   93.630037         496
       2010 |   13.157895   93.742613         475
       2011 |   12.763948   92.849213         466
       2012 |    12.19213   89.347455         432
       2013 |   11.658879   85.225451         428
       2014 |   11.049296   80.859849         426
       2015 |   10.756477   75.177627         386
------------+------------------------------------
      Total |   12.441185   89.574654       6,614
*/
* –––> inverse U-shape of average number of coops/mun & nbr of mun with coops
* over the period (max 2006-7), now same as first period

display 6614/14
* –––> on average, 472.42 municipalities with coops every year

sort year
by year : egen coop_peryear = sum(coop_tot)
tab year, summarize(coop_peryear)
/*
            |       Summary of coop_peryear
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |        5278           0       1,122
       2003 |        5844           0       1,122
       2004 |        6218           0       1,122
       2005 |        6673           0       1,122
       2006 |        6882           0       1,122
       2007 |        6906           0       1,122
       2008 |        6621           0       1,122
       2009 |        6550           0       1,122
       2010 |        6250           0       1,122
       2011 |        5948           0       1,122
       2012 |        5267           0       1,122
       2013 |        4990           0       1,122
       2014 |        4707           0       1,122
       2015 |        4152           0       1,122
------------+------------------------------------
      Total |   5877.5714   838.08044      15,708
*/
* –––> on avg, 5,877 coops/year. inv U-shape (max 2006), now lower than at the beginning



//// Employees

xtsum coop_empl
/*
Variable         |      Mean   Std. Dev.       Min        Max |    Observations
-----------------+--------------------------------------------+----------------
coop_e~l overall |  229.4457    2520.06          0     103125 |     N =    6616
         between |             1845.631          0   46843.61 |     n =     716
         within  |             1101.512  -22316.87   56510.83 | T-bar = 9.24022
*/
* –––> on avg, 229 coop employees per muni



tab year, summarize(coop_empl)
/*
            |  Summary of Cooperative employees
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   128.60104   1194.5771         480
       2003 |   162.75606   1447.0246         487
       2004 |   214.98323   1859.6406         477
       2005 |   307.79874   2575.8742         502
       2006 |   221.38335   2109.7665         530
       2007 |    213.5157   2158.7618         523
       2008 |   339.21063   4626.5903         508
       2009 |      321.29    4319.608         500
       2010 |       201.2   2189.7329         475
       2011 |   240.04104   2529.0367         463
       2012 |    231.1455   1992.6442         433
       2013 |   208.07459   1868.3168         429
       2014 |   200.74057    1584.316         424
       2015 |   199.53506    1502.511         385
------------+------------------------------------
      Total |   229.44567   2520.0602       6,616
*/
* –––> max aveg employees in 2008

sort year
by year : egen coop_empl_peryear = sum(coop_empl)
tab year, summarize(coop_empl_peryear)
/*
            |    Summary of coop_empl_peryear
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |     61728.5           0       1,122
       2003 |   79262.203           0       1,122
       2004 |      102547           0       1,122
       2005 |   154514.97           0       1,122
       2006 |   117333.17           0       1,122
       2007 |   111668.71           0       1,122
       2008 |      172319           0       1,122
       2009 |      160645           0       1,122
       2010 |       95570           0       1,122
       2011 |      111139           0       1,122
       2012 |      100086           0       1,122
       2013 |       89264           0       1,122
       2014 |       85114           0       1,122
       2015 |       76821           0       1,122
------------+------------------------------------
      Total |   108429.47     31894.4      15,708
*/
* –––> 108,000 employees on average, max 2008, now back to 2003 level



//// Members

xtsum coop_asso
/*
Variable         |      Mean   Std. Dev.       Min        Max |    Observations
-----------------+--------------------------------------------+----------------
coop_a~o overall |  9748.596   80487.28          0    1863724 |     N =    6616
         between |             63564.74          0    1384061 |     n =     716
         within  |              19882.4  -621293.8   489411.2 | T-bar = 9.24022
*/
* ––––> on avg 9,700 coop members/munic, max 1,863,724!
sort coop_asso
* –––> Bogota the biggest, since beginning >1,000,000


tab year, summarize(coop_asso)
/*
            |   Summary of Cooperative members
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   5415.1479   43048.479         480
       2003 |   5926.3368   47411.894         487
       2004 |   6957.8071   56705.348         477
       2005 |   7217.0717   60467.638         502
       2006 |   7479.6849   63804.707         530
       2007 |   8192.7973   69211.093         523
       2008 |   9360.2421   77911.228         508
       2009 |      9930.4   81156.493         500
       2010 |   11215.339   90200.523         475
       2011 |   11383.778   89940.717         463
       2012 |   12789.233   99133.266         433
       2013 |   13668.205    106451.8         429
       2014 |   14170.281   108190.74         424
       2015 |   15825.013    111679.8         385
------------+------------------------------------
      Total |   9748.5961   80487.283       6,616
*/
* –––> constant growth of coop members


sort year
by year : egen coop_asso_peryear = sum(coop_asso)
tab year, summarize(coop_asso_peryear)
/*
            |    Summary of coop_asso_peryear
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |     2599271           0       1,122
       2003 |     2886126           0       1,122
       2004 |     3318874           0       1,122
       2005 |     3622970           0       1,122
       2006 |     3964233           0       1,122
       2007 |     4284833           0       1,122
       2008 |     4755003           0       1,122
       2009 |     4965200           0       1,122
       2010 |     5327286           0       1,122
       2011 |     5270689           0       1,122
       2012 |     5537738           0       1,122
       2013 |     5863660           0       1,122
       2014 |     6008199           0       1,122
       2015 |     6092630           0       1,122
------------+------------------------------------
      Total |     4606908   1129585.1      15,708
*/
* –––> on avg, 4,606,908 members/year, constantly growing, almost x3 since 2002


//// Financial coops

xtsum coop_fin
/*
Variable         |      Mean   Std. Dev.       Min        Max |    Observations
-----------------+--------------------------------------------+----------------
coop_fin overall |  .4649335   2.923615          0         79 |     N =    6616
         between |             2.319814          0   49.07143 |     n =     716
         within  |             .6963163   -14.6065    30.3935 | T-bar = 9.24022
*/
* –––> on avg, 0.5 financial coop / mun


tab year, summarize(coop_fin)
/*
            |  Summary of Financial cooperatives
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |       .6375   4.1483264         480
       2003 |   .56468172   3.7498182         487
       2004 |   .52830189     3.41981         477
       2005 |   .46812749   3.0304476         502
       2006 |   .43207547   2.8827283         530
       2007 |   .43403442   2.9054296         523
       2008 |   .42716535   2.7008309         508
       2009 |        .426   2.6763501         500
       2010 |   .43578947   2.6252553         475
       2011 |   .39956803   2.3192587         463
       2012 |   .42494226   2.3618352         433
       2013 |   .42424242   2.3386172         429
       2014 |   .42924528   2.3569611         424
       2015 |   .47272727   2.4695877         385
------------+------------------------------------
      Total |   .46493349   2.9236147       6,616
*/
* –––> avg number of fin coops has been declining until 2011, slightly increased since


by year : egen coop_fin_peryear = sum(coop_fin)
tab year, summarize(coop_fin_peryear)
/*
            |     Summary of coop_fin_peryear
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |         306           0       1,122
       2003 |         275           0       1,122
       2004 |         252           0       1,122
       2005 |         235           0       1,122
       2006 |         229           0       1,122
       2007 |         227           0       1,122
       2008 |         217           0       1,122
       2009 |         213           0       1,122
       2010 |         207           0       1,122
       2011 |         185           0       1,122
       2012 |         184           0       1,122
       2013 |         182           0       1,122
       2014 |         182           0       1,122
       2015 |         182           0       1,122
------------+------------------------------------
      Total |   219.71429   36.722958      15,708
*/
* –––> on avg, 219 mun with at least 1 fin coop., has been declining


//// Proportion (importance) of fin coops

tab year, summarize(coop_fin_pr)
/*
            | Summary of Proportion of Financial
            |            cooperatives
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   9.3606892   25.257875         480
       2003 |   8.0881586   23.247449         487
       2004 |   8.2186519   24.197644         477
       2005 |   7.6468766   23.357013         502
       2006 |   6.9935155   22.625274         530
       2007 |   6.5038518   21.485843         523
       2008 |   6.4681471     21.5289         508
       2009 |   6.4535273   21.394153         500
       2010 |   7.1759692   22.879761         475
       2011 |   5.7913646   19.929938         463
       2012 |    6.342854   20.689831         433
       2013 |   6.4483098   20.833127         429
       2014 |   6.7285118   21.394987         424
       2015 |   7.8189013   22.720803         385
------------+------------------------------------
      Total |   7.1459624   22.319625       6,616
*/
* –––> more/less stable proportion, avg proportion of fin coop around 7% (slight decline)


tab year, summarize(coop_fempl_pr)
/*
            | Summary of Proportion of Fin. Coop.
            |              employees
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   12.218031   29.149462         353
       2003 |   12.155356   28.973491         375
       2004 |   11.947419    29.27525         376
       2005 |   8.6264064   25.196352         486
       2006 |    9.504292   26.270752         459
       2007 |   9.8666031   26.478046         440
       2008 |   12.594017   30.140875         388
       2009 |   12.731862   30.288816         385
       2010 |   12.975901   30.454073         377
       2011 |     11.5724   28.571615         372
       2012 |    12.06711   28.999877         358
       2013 |   11.902096   28.863153         366
       2014 |   12.349541   29.685835         367
       2015 |    14.01375   31.339791         331
------------+------------------------------------
      Total |   11.612696   28.732407       5,433
*/
* –––> more or less stable too, avg  prop. of fin. coop. employees around 11% (slight increase)


tab year, summarize(coop_fasso_pr)
/*
            | Summary of Proportion of Fin. Coop.
            |               members
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   13.482676   31.520518         449
       2003 |   13.928344   32.055647         465
       2004 |   13.722715    31.71459         462
       2005 |   12.925026   31.108228         502
       2006 |   12.080349   30.271108         530
       2007 |   11.968577   30.130495         523
       2008 |   12.162679   30.387325         508
       2009 |   12.401125   30.684816         500
       2010 |   12.996108   31.400881         473
       2011 |   12.376481   30.811428         457
       2012 |   13.471594   32.074095         429
       2013 |   13.678792   32.357731         425
       2014 |   14.039787    32.76309         418
       2015 |   15.626469   34.347365         380
------------+------------------------------------
      Total |   13.127237   31.452683       6,521
*/
* –––> slight increase of, avg prop. of fin. coop. members around 13%



//// Proportions in municipalities with at least 1 fin coop

tab year if coop_fin>=1, summarize(coop_fin_pr)
/*
            | Summary of Proportion of Financial
            |            cooperatives
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   44.931308   38.370801         100
       2003 |   41.030554   37.402201          96
       2004 |   42.153731    39.79223          93
       2005 |   42.652579   39.511491          90
       2006 |   42.604175   40.174553          87
       2007 |   40.017818   38.879943          85
       2008 |    39.11689   39.226462          84
       2009 |    38.87667   38.851715          83
       2010 |   41.568114   40.200514          82
       2011 |   36.235159   37.357121          74
       2012 |   37.114268   37.088108          74
       2013 |   37.894862   37.037673          73
       2014 |   39.080671   37.514665          73
       2015 |   41.236671   36.824932          73
------------+------------------------------------
      Total |   40.512157    38.38383       1,167
*/
* –––> proportion of fin. coop. jumps at around 40% when at least 1 fin. coop. in the mun


tab year if coop_fin>=1, summarize(coop_fempl_pr)
/*

            | Summary of Proportion of Fin. Coop.
            |              employees
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   46.880055   40.545075          92
       2003 |   47.981668   40.033715          95
       2004 |   48.303544   41.450606          93
       2005 |   46.582594   40.885761          90
       2006 |   50.143334   40.174504          87
       2007 |   51.074181   39.170335          85
       2008 |   58.172366   39.402338          84
       2009 |   59.057431   39.076102          83
       2010 |   59.657497   38.547552          82
       2011 |   58.174767   37.424084          74
       2012 |   58.378724    37.04257          74
       2013 |    59.67352   36.509983          73
       2014 |   62.086046   36.726699          73
       2015 |   63.541798   36.205785          73
------------+------------------------------------
      Total |   54.483402   39.218874       1,158
*/
* –––> prop of fin. empl. ~54%, increasing


tab year if coop_fin>=1, summarize(coop_fasso_pr)
/*

            | Summary of Proportion of Fin. Coop.
            |               members
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   63.059597   39.065724          96
       2003 |   68.175579   36.531529          95
       2004 |   68.170908   35.887053          93
       2005 |   72.092923   33.674891          90
       2006 |   73.592931   32.511953          87
       2007 |    73.64195    32.33888          85
       2008 |   73.555252   32.715608          84
       2009 |    74.70557   31.913527          83
       2010 |   74.965353   32.291962          82
       2011 |   76.433135   31.097095          74
       2012 |   78.098835   30.250744          74
       2013 |   79.636801   28.985544          73
       2014 |   80.392204   28.435676          73
       2015 |   81.343261   28.109876          73
------------+------------------------------------
      Total |   73.668428   33.042118       1,162
*/
* –––> prop. of fin. members ~73%, increasing



*-----------------*---------------------*--------*-----------------*-----
*----------*------------*------------*---------------*-------------*-----
// Displacement

//// Total numbers

xtsum displ_tot
/* 
Variable         |      Mean   Std. Dev.       Min        Max |    Observations
-----------------+--------------------------------------------+----------------
displ_~t overall |  387.2944   1192.776          1      51158 |     N =   13942
         between |             838.9971          1    17460.5 |     n =    1117
         within  |             805.6886  -15561.21   34084.79 | T-bar = 12.4816
*/
* –––> 1,117 municipalities with displaced people at some point
* –––> on avg, 387 displ/mun/year

tab year, summarize(displ_tot)
/*
            |     Summary of Total displaced
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   737.97495   1818.0889       1,038
       2003 |   445.51553   1051.8618       1,030
       2004 |   406.98168   823.76166       1,037
       2005 |   458.46449    948.3598       1,042
       2006 |   443.34674   953.57833       1,044
       2007 |   463.05019   1197.0854       1,056
       2008 |   427.13411   1020.2699       1,029
       2009 |   271.45418   723.55512         982
       2010 |   253.73304   747.75216         914
       2011 |   300.99355   1252.5057         930
       2012 |   283.46425   1113.5546         965
       2013 |   308.92543   1475.1623         979
       2014 |   314.11954   1814.0494         962
       2015 |   243.12206    985.1659         934
------------+------------------------------------
      Total |   387.29443   1192.7758      13,942
*/
display 13942/14
* –––> on avg, 995 municipalities experienced forced displacement every year

by year : egen displ_peryear = sum(displ_tot)
tab year, summarize(displ_peryear)
/*
            |      Summary of displ_peryear
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |      765979           0       1,122
       2003 |      458843           0       1,122
       2004 |      421989           0       1,122
       2005 |      477621           0       1,122
       2006 |      462714           0       1,122
       2007 |      488829           0       1,122
       2008 |      439432           0       1,122
       2009 |      266559           0       1,122
       2010 |      231873           0       1,122
       2011 |      279898           0       1,122
       2012 |      273498           0       1,122
       2013 |      302405           0       1,122
       2014 |      302171           0       1,122
       2015 |      227023           0       1,122
------------+------------------------------------
      Total |      385631   141404.74      15,708
*/
* –––> on avg, 385,631 displaced/year

egen all_displ = total(displ_tot)
sum all_displ
/*
    Variable |        Obs        Mean  
-------------+------------------------
   all_displ |     15,708     5398834
*/
* –––> in my period, 5'398'834 displaced in total



*-----------------*---------------------*--------*-----------------*-----
*----------*------------*------------*---------------*-------------*-----
// Conflict intensitiy – My proxy

xtsum viol_my
/*
Variable         |      Mean   Std. Dev.       Min        Max |    Observations
-----------------+--------------------------------------------+----------------
viol_my  overall |  .5191625   1.017773          0   54.48718 |     N =   14563
         between |             .6035916          0   6.947588 |     n =    1122
         within  |             .8193797  -6.428425   48.05875 |     T = 12.9795
*/
* –––> on average, violence index is 0.5, min 0 and max 54.48


missings list viol_my if year<2015, identify(year codmun)
* the missing option when generating viol_my: "if all values in varlist are 
* missing for an observation, viol_my is set to missing."
* –––> from 2002 to 2007, 5 municipalities with missing violence.
* –––> 2015, no measures of violence

tab year, summarize(viol_my)
/*
            |   Summary of My proxy measure of
            |              violence
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   .07447513   .23959246       1,118
       2003 |    1.132981   1.6754106       1,118
       2004 |   .88767516    2.121947       1,118
       2005 |   .68489678   1.0958484       1,118
       2006 |   .63329482   .96670127       1,118
       2007 |    .5295861    .7052202       1,119
       2008 |    .4781823   .72457423       1,122
       2009 |   .42859543   .64964999       1,122
       2010 |   .38415867   .59768564       1,122
       2011 |   .39551124   .61059794       1,122
       2012 |   .43812093   .64545532       1,122
       2013 |   .39511249   .62410951       1,122
       2014 |   .28946522   .37565696       1,122
------------+------------------------------------
      Total |   .51916253   1.0177732      14,563
*/
* –––> measure of violence for 1,122 municipalities at most

tab year, summarize(viol_acem)
/*
            |  Summary of Acemoglu et al. (2013)
            |         measure of violence
        Año |        Mean   Std. Dev.       Freq.
------------+------------------------------------
       2002 |   .30664443   .50331008       1,118
       2003 |   1.1721625    1.693905       1,118
       2004 |    .9828435   1.6258775       1,118
       2005 |   .85396494   1.1081001       1,118
       2006 |   .80504629   1.0780173       1,118
       2007 |   .72533114   .92770129       1,119
       2008 |   .56610217   .69316975       1,122
       2009 |   .40747696   .41992113       1,122
       2010 |    .3790743   .43443983       1,122
       2011 |   .37878894   .42889579       1,122
       2012 |   .42034371   .45752205       1,122
       2013 |   .39620135   .40532643       1,122
       2014 |   .12914186   .18208721         989
------------+------------------------------------
      Total |    .5824746   .94521024      14,430
*/


sort codmun year


