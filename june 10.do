//emissions and its effects in selected countries//

import excel "/Users/frankosei-kusi/Desktop/energy and growth nexus/developing and developed nations/updated pdata.xlsx", sheet("Sheet1") firstrow clear

drop if countrycode==72
drop if countrycode==76
drop if countrycode==80
drop if countrycode==82
drop if countrycode==85
drop if countrycode==88
drop if countrycode==90
drop if countrycode==102
drop if countrycode==83


xtset countrycode year
gen lcarbon=log(co2mtpc)
gen llife=log(Lifeexpectancyatbirthtotal)
gen ldeath=log(Deathratecrudeper1000peo)
gen lenergy=log(energyusekgofoilequivalent)
gen lenuse=log(N)
gen ltrade=log(tradeofGDP)
gen lpop=log(Populationtotal)
gen lurban=log(Urbanpopulation)
gen lurpop=log(Urbanpopulationoftotalpop)
gen lurgrowth=log(Urbanpopulationgrowthannual)
gen lgdppc=log(gdppercapitacurrentUS)
gen lgrem=log(Totalgreenhousegasemissions)
gen gdpsquared=lgdppc^2
gen gdpcube=lgdppc^3
gen carpc=lcarbon/lpop

//descriptive statistics//

sort regionname
by regionname: summarize 

#delimit cr

#delimit ;
graph twoway  (scatter co2mtpc Lifeexpectancyatbirthtotal, jitter(12))
              (lfit co2mtpc Lifeexpectancyatbirthtotal)
              (qfit co2mtpc Lifeexpectancyatbirthtotal),
			   name(scat6, replace) if rcd_1==1 ;
			   			   
#delimit cr

#delimit ;
graph twoway  (scatter co2mtpc energyusekgofoilequivalent, jitter(12))
              (lfit co2mtpc energyusekgofoilequivalent)
              (qfit co2mtpc energyusekgofoilequivalent),
			   name(scat6, replace);

#delimit ;
graph twoway  (scatter co2mtpc N, jitter(12))
              (lfit co2mtpc N),
			   name(scat6, replace);

			   #delimit ;
graph twoway  (scatter co2mtpc Deathratecrudeper1000peo , jitter(12))
              (lfit co2mtpc Deathratecrudeper1000peo),
			   name(scat6, replace);
			   
#delimit ;
graph twoway  (scatter co2mtpc Populationtotal, jitter(12))
              (lfit co2mtpc Populationtotal),
               name(scat6, replace);
			   
			   #delimit ;
graph twoway  (scatter co2mtpc gdppercapitacurrentUS, jitter(12))
              (lfit co2mtpc gdppercapitacurrentUS)
              (qfit co2mtpc gdppercapitacurrentUS),
			   name(scat6, replace);
			
#delimit ;
graph twoway  (scatter co2mtpc gdppercapitacurrentUS if rcd_1==1, jitter(12))
              (lfit co2mtpc gdppercapitacurrentUS)
              (qfit co2mtpc gdppercapitacurrentUS),
			   name(scat6, replace);
			   
#delimit ;			   
graph twoway  (scatter co2mtpc gdppercapitacurrentUS if rcd_1==2, jitter(12))
              (lfit co2mtpc gdppercapitacurrentUS)
              (qfit co2mtpc gdppercapitacurrentUS),
			   name(scat6, replace);
			   
			   
#delimit ;
graph twoway  (scatter co2mtpc gdppercapitacurrentUS if rcd_1==3, jitter(7))
              (lfit co2mtpc gdppercapitacurrentUS)
              (qfit co2mtpc gdppercapitacurrentUS),
			   name(scat6, replace);
			   #delimit ;
graph twoway  (scatter co2mtpc gdppercapitacurrentUS if regionname==europe and central asia, jitter(12))
              (lfit co2mtpc gdppercapitacurrentUS)
              (qfit co2mtpc gdppercapitacurrentUS),
			   name(scat6, replace);

collapse (mean) co2mtpc, by(country)
sort co2mtpc
list
collapse (mean) co2mtpc, by(region)
sort co2mtpc
list

collapse (mean) energyusekgofoilequivalent, by(country)
sort energyusekgofoilequivalent
list


collapse (mean) Populationtotal, by(country)
sort Populationtotal
list

collapse (mean) Lifeexpectancyatbirthtotal, by(country)
sort Lifeexpectancyatbirthtotal
list

collapse (mean) Deathratecrudeper1000peo, by(country)
sort Deathratecrudeper1000peo
list

collapse (mean) gdppercapitacurrentUS, by(country)
sort gdppercapitacurrentUS
list

collapse (mean) co2mtpc, by(regionname)
sort co2mtpc
list

collapse (mean) Lifeexpectancyatbirthtotal, by(regionname)
sort Lifeexpectancyatbirthtotal
list

collapse (mean) energyusekgofoilequivalent, by(regionname)
sort energyusekgofoilequivalent
list

collapse (mean) Populationtotal, by(regionname)
sort Populationtotal
list

collapse (mean) Deathratecrudeper1000peo, by(regionname)
sort Deathratecrudeper1000peo
list

collapse (mean) gdppercapitacurrentUS, by(regionname)
sort gdppercapitacurrentUS
list


sum co2mtpc if rcd_1==1
sum co2mtpc if rcd_1==2
sum co2mtpc if rcd_1==3

sum energyusekgofoilequivalent if rcd_1==1
sum energyusekgofoilequivalent if rcd_1==2
sum energyusekgofoilequivalent if rcd_1==3

sum Populationtotal if rcd_1==1
sum Populationtotal if rcd_1==2
sum Populationtotal if rcd_1==3

sum gdppercapitacurrentUS if rcd_1==1
sum gdppercapitacurrentUS if rcd_1==2
sum gdppercapitacurrentUS if rcd_1==3

sum Lifeexpectancyatbirthtotal if rcd_1==1
sum Lifeexpectancyatbirthtotal if rcd_1==2
sum Lifeexpectancyatbirthtotal if rcd_1==3

sum Deathratecrudeper1000peo if rcd_1==1
sum Deathratecrudeper1000peo if rcd_1==2
sum Deathratecrudeper1000peo if rcd_1==3


rename Lifeexpectancyatbirthtotal life
rename Deathratecrudeper1000peo death
rename energyusekgofoilequivalent energy
rename Populationtotal pop
rename Urbanpopulation urban
rename tradeofGDP trade

gen lcarbon=log(co2mtpc)
gen llife=log(life)
gen ldeath=log(death)
gen lenergy=log(energy)
gen lenuse=log(N)
gen ltrade=log(trade)
gen lpop=log(pop)
gen lurban=log(urban)
gen lurpop=log(urpop)
gen lurgrowth=log(Urbanpopulationgrowthannual)
gen lgdppc=log(gdppercapitacurrentUS)
gen gdpsquared=lgdppc^2
gen carpc=lcarbon/lpop

//first differences//

gen dlcarbon=d.lcarbon
gen dllife=d.llife
gen dldeath=d.ldeath
gen dlenergy=d.lenergy
gen dlenuse=d.lenuse
gen dltrade=d.ltrade
gen dlpop=d.lpop
gen dlurban=d.lurban
gen dlurpop=d.lurpop
gen dlurgrowth=d.lurgrowth
gen dlgdppc=d.lgdppc

// panel unit root testing//
//levin chu, hadri, haris tsavalis, breitung all require strongly balanced data//
//and are referred to as first generational unit root testing//

//im pesaran and shin//
xtunitroot ips lenuse, trend lags(1)
xtunitroot ips lgrem, trend lags(1)
xtunitroot ips lcarbon, trend lags(1)
xtunitroot ips llife, trend lags(1)
xtunitroot ips ldeath, trend lags(1)
xtunitroot ips lenergy, trend lags(1)
xtunitroot ips lenuse, trend lags(1)
xtunitroot ips ltrade, trend lags(1)
xtunitroot ips lpop, trend lags(1)
xtunitroot ips lurban, trend lags(1)
xtunitroot ips lurpop, trend lags(1)

xtunitroot ips d.lcarbon, trend lags(1)
xtunitroot ips d.llife, trend lags(1)
xtunitroot ips d.ldeath, trend lags(1)
xtunitroot ips d.lenergy, trend lags(1)
xtunitroot ips d.lenuse, trend lags(1)
xtunitroot ips d.ltrade, trend lags(1)
xtunitroot ips d.lpop, trend lags(1)
xtunitroot ips d.lurban, trend lags(1)
xtunitroot ips d.lurpop, trend lags(1)
//no observations//
xtunitroot ips lurgrowth, trend lags(1)
xtunitroot ips lgdppc, trend lags(1)

//fisher type unit root testing//
// augmented dickey fuller, 
 xtunitroot fisher lcarbon, dfuller trend lags(0)
 xtunitroot fisher lcarbon, dfuller trend lags(1)
 xtunitroot fisher lcarbon, dfuller drift lags(1)
 xtunitroot fisher llife, dfuller trend lags(0)
 xtunitroot fisher llife, dfuller trend lags(1)
 xtunitroot fisher llife, dfuller drift lags(1)
 xtunitroot fisher ldeath, dfuller trend lags(0)
 xtunitroot fisher ldeath, dfuller trend lags(1)
 xtunitroot fisher ldeath, dfuller drift lags(1)
 xtunitroot fisher lenergy, dfuller trend lags(0)
 xtunitroot fisher lenergy, dfuller trend lags(1)
 xtunitroot fisher lenergy, dfuller drift lags(1)
 xtunitroot fisher lenuse, dfuller trend lags(0)
 xtunitroot fisher lenuse, dfuller trend lags(1)
 xtunitroot fisher lenuse, dfuller drift lags(1)
 xtunitroot fisher ltrade, dfuller trend lags(0)
 xtunitroot fisher ltrade, dfuller trend lags(1)
 xtunitroot fisher ltrade, dfuller drift lags(1)
 xtunitroot fisher lpop, dfuller trend lags(0)
 xtunitroot fisher lpop, dfuller trend lags(1)
 xtunitroot fisher lpop, dfuller drift lags(1)
 xtunitroot fisher lurgrowth, dfuller trend lags(0)
 xtunitroot fisher lurgrowth, dfuller trend lags(1)
 xtunitroot fisher lurgrowth, dfuller drift lags(1)
 xtunitroot fisher lgdppc, dfuller trend lags(0)
 xtunitroot fisher lgdppc, dfuller trend lags(1)
 xtunitroot fisher lgdppc, dfuller drift lags(0)
 
 
 // unitroot testing pperron//
 xtunitroot fisher lcarbon, pperron trend lags(0)
 xtunitroot fisher lcarbon, pperron trend lags(1)
 xtunitroot fisher lcarbon, pperron lags(0)
 xtunitroot fisher lcarbon, pperron lags(1)
 
 xtunitroot fisher llife, pperron trend lags(0)
 xtunitroot fisher llife, pperron trend lags(1)
 xtunitroot fisher llife, pperron lags(0)
 xtunitroot fisher llife, pperron lags(1)

 xtunitroot fisher ldeath, pperron trend lags(0)
 xtunitroot fisher ldeath, pperron trend lags(1)
 xtunitroot fisher ldeath, pperron lags(0)
 xtunitroot fisher ldeath, pperron lags(1)
 
 xtunitroot fisher lenergy, pperron trend lags(0)
 xtunitroot fisher lenergy, pperron trend lags(1)
 xtunitroot fisher lenergy, pperron lags(0)
 xtunitroot fisher lenergy, pperron lags(1)
 
 xtunitroot fisher lenuse, pperron trend lags(0)
 xtunitroot fisher lenuse, pperron trend lags(1)
 xtunitroot fisher lenuse, pperron lags(0)
 xtunitroot fisher lenuse, pperron lags(1)
 
 xtunitroot fisher ltrade, pperron trend lags(0)
 xtunitroot fisher ltrade, pperron trend lags(1)
 xtunitroot fisher ltrade, pperron lags(0)
 xtunitroot fisher ltrade, pperron lags(1)
 
 
 xtunitroot fisher lpop, pperron trend lags(0)
 xtunitroot fisher lpop, pperron trend lags(1)
 xtunitroot fisher lpop, pperron lags(0)
 xtunitroot fisher lpop, pperron lags(1)
 
 xtunitroot fisher lurgrowth, pperron trend lags(0)
 xtunitroot fisher lurgrowth, pperron trend lags(1)
 xtunitroot fisher lurgrowth, pperron lags(0)
 xtunitroot fisher lurgrowth, pperron lags(1)
 
 xtunitroot fisher lgdppc, pperron trend lags(0)
 xtunitroot fisher lgdppc, pperron trend lags(1)
 xtunitroot fisher lgdppc, pperron lags(0)
 xtunitroot fisher lgdppc, pperron lags(1)
 
 // pesaran CD-test//
 xtcd lcarbon
 xtcd llife
 xtcd ldeath
 //the cross sectional dependence test for energy was done with 86 groups//
 xtcd lenergy
 xtcd lenuse
 xtcd lpop
 xtcd lgdppc
 
 xtcdf lcarbon
 xtcdf llife
 xtcdf ldeath
 xtcdf lenergy
 xtcdf lenuse
 xtcdf lpop
 xtcdf lgdppc
 
 //cointegration test//
  xtcointtest westerlund lcarbon lenergy llife lgdppc lpop, trend allpanels demean
  xtcointtest westerlund lcarbon lenergy llife lgdppc lpop, trend demean
  xtcointtest kao lcarbon lenergy llife lgdppc lpop, demean
  xtcointtest kao lcarbon lenergy llife lgdppc lpop, demean
  xtcointtest pedroni lcarbon lenergy llife lgdppc lpop, trend demean
  xtcointtest pedroni lgrem llife lenergy lpop lgdppc, trend demean
  xtcointtest pedroni lgrem llife lenergy lpop lgdppc, trend
  xtcointtest westerlund lgrem llife lenergy lpop lgdppc, allpanels
  xtcointtest westerlund lgrem llife lenergy lpop lgdppc, trend allpanels
  
  //main sample xtscc(GLS-RE)//
  xtscc lcarbon llife lenergy lgdppc lpop i.year, re lag(2)
  xtscc llife lcarbon lgdppc lenergy i.year, re lag(4)
  xtscc lcarbon llife lenergy lpop lgdppc i.year, re lag(4)
  
  //xtpcse//
  xtpcse lcarbon llife lenergy lpop lgdppc i.year, corr(ar1)  pairwise
  xtpcse lcarbon ldeath lenergy lpop lgdppc i.year, corr(ar1) het pairwise
  xtpcse ldeath lcarbon lenergy lgdppc i.year, corr(ar1) het pairwise
  xtscc  ldeath lcarbon lenergy lgdppc i.year, re lag(4)
  
  //xtpcse lcarbon llife lenuse lurpop lgdppc, corr(ar1) het pairwise // model 1//
  //xtscc  lcarbon llife lenuse lurpop lgdppc, re lag(4)// model// driscoll Kraay//
  
  xtscc lcarbon llife lenergy lpop lgdppc i.year, re lag(1)
  
  xtregar lcarbon llife lenergy lpop lgdppc, re  
  
  
  //xtpcse lcarbon llife lenuse lurpop lgdppc i.year, corr(ar1) het pairwise // the correct equation// 
// exclude panel 24 26 32//

//xtgls//  xtgls lcarbon llife lenuse lurpop lgdppc, p(iid) corr(ar1) force//
//the year is not regularly spaced so we used the force option to indicate as though they were regular//

// MODEL 1 //

xtpcse lcarbon llife lenuse lurpop lgdppc, corr(ar1) het pairwise
xtgls lcarbon llife lenuse lurpop lgdppc, corr(ar1) p(iid) force

//MODEL 11//
xtpcse lcarbon ldeath lenuse lurpop lgdppc, corr(ar1) het pairwise
xtgls  lcarbon ldeath lenuse lurpop lgdppc, corr(ar1) p(iid) force

//MODEL 111//
xtpcse llife lcarbon lenergy lurpop lgdppc, corr(ar1) het pairwise
xtgls llife lcarbon lenergy lurpop lgdppc, corr(ar1) p(iid) force 

// Regional Analysis//

//PANEL CORRECTED STANDARD ERRORS//*********
//MODEL 1 //**********************

sort rcd_1
by rcd_1: xtpcse lcarbon llife lenuse lurpop lgdppc, corr(ar1) het pairwise

//MODEL 11//
sort rcd_1
by rcd_1: xtpcse lcarbon ldeath lenuse lurpop lgdppc, corr(ar1) het pairwise

// MODEL 111//
sort rcd_1
by rcd_1: xtpcse llife lenuse lcarbon lurpop lgdppc, corr(ar1) het pairwise

//REGIONAL ANALYSIS//
// FEASIBLE GENERALISED LEAST SQUARES//
//MODEL 1//
sort rcd_1

by rcd_1: xtgls lcarbon llife lenuse lurpop lgdppc, corr(ar1) p(iid) force

//MODEL 11//
sort rcd_1
by rcd_1: xtgls lcarbon ldeath lenuse lurpop lgdppc, corr(ar1) p(iid) force

//MODEL 111//
sort rcd_1
by rcd_1: xtgls llife lenuse lcarbon lurpop lgdppc, corr(ar1) p(iid) force

//KUZNET CURVE REGIONS//
//MENA//

import excel "/Users/frankosei-kusi/Desktop/energy and growth nexus/middle east.xlsx", sheet("Sheet3") firstrow

xtgls lcarbon llife lenuse lurpop lgdppc gdpsquared, corr(ar1) p(iid) force

utest lgdppc lgdppcsquared

xtgls lcarbon llife lenuse lurpop lgdppc gdpsquared gdpcube, corr(ar1) p(iid) force

utest lgdppcsquared gdpcube

//ECA//


 
 



