
use "/Users/frankosei-kusi/Desktop/natural earth/_CEMaster.dta"

//extracting life expectancy data//

rename sp_dyn_le00_in life

wbopendata, indicator(SP.DYN.LE00.IN) long

drop lendingtypename lendingtype incomelevelname adminregionname adminregion region

preserve

drop if year<1990

drop if year>2021

drop if regionname=="Latin America and Caribbean"

drop if rgionname=="South Asia"

drop if regionname=="South Asia"

drop if regionname=="Aggregates"

drop if regionname=="East Asia and Pacific"

drop if regionname=="North America"

drop if countryname=="Africa Eastern and Southern"

 drop if countryname=="Africa Western and Central"
 
save "/Users/frankosei-kusi/Desktop/natural earth/_lifex.dta"

//energy use data (kg of oil equivalent per capita)//

rename eg_use_pcap_kg_oe energyuse

wbopendata, indicator(EG.USE.PCAP.KG.OE) long clear

drop lendingtypename lendingtype incomelevelname adminregionname adminregion region

preserve

drop if year<1990

drop if year>2021

drop if regionname=="Latin America and Caribbean"

drop if rgionname=="South Asia"

drop if regionname=="Aggregates"

drop if regionname=="East Asia and Pacific"

drop if regionname=="North America"

drop if countryname=="Africa Eastern and Southern"

drop if countryname=="Africa Western and Central"
 
save "/Users/frankosei-kusi/Desktop/natural earth/_energy.dta"

merge m:m countryname using "/Users/frankosei-kusi/Desktop/natural earth/_lifex.dta"

drop if _merge==1 
// energy use (kg of oil equivalent) per $1,000 GDP (constant 2017 PPP)//

rename eg_use_comm_gd_pp_kd energy

wbopendata, indicator(EG.USE.COMM.GD.PP.KD) long clear

drop lendingtypename lendingtype incomelevelname adminregionname adminregion region

preserve

drop if year<1990

drop if year>2021

drop if regionname=="Latin America and Caribbean"

drop if regionname=="South Asia"

drop if regionname=="Aggregates"

drop if regionname=="East Asia and Pacific"

drop if regionname=="North America"

drop if countryname=="Africa Eastern and Southern"

drop if countryname=="Africa Western and Central"
 
save "/Users/frankosei-kusi/Desktop/natural earth/_energypp.dta"

drop _merge

merge m:m countryname using "/Users/frankosei-kusi/Desktop/natural earth/_energypp.dta"

//CO2 intensity (kg per kg of oil equivalent energy use)//

rename en_atm_co2e_eg_zs carbon

wbopendata, indicator(EN.ATM.CO2E.EG.ZS) long clear

rename EN.ATM.CO2E.EG.ZS carbon

drop lendingtypename lendingtype incomelevelname adminregionname adminregion region

preserve

drop if year<1990

drop if year>2021

drop if regionname=="Latin America and Caribbean"

drop if regionname=="South Asia"

drop if regionname=="Aggregates"

drop if regionname=="East Asia and Pacific"

drop if regionname=="North America"

drop if countryname=="Africa Eastern and Southern"

drop if countryname=="Africa Western and Central"
 
save "/Users/frankosei-kusi/Desktop/natural earth/_emissions.dta"

 merge m:m countryname using "/Users/frankosei-kusi/Desktop/natural earth/_CEMaster.dta"
 
 drop _merge
 
 //CO2 emissions (metric tons per capita)//
 
wbopendata, indicator(EN.ATM.CO2E.PC) long clear

rename en_atm_co2e_pc emissions

drop lendingtypename lendingtype incomelevelname adminregionname adminregion region

preserve

drop if year<1990

drop if year>2020

drop if regionname=="Latin America and Caribbean"

drop if regionname=="South Asia"

drop if regionname=="Aggregates"

drop if regionname=="East Asia and Pacific"

drop if regionname=="North America"

drop if countryname=="Africa Eastern and Southern"

drop if countryname=="Africa Western and Central"
 
save "/Users/frankosei-kusi/Desktop/natural earth/_emimetcap.dta"

 merge m:m countryname using "/Users/frankosei-kusi/Desktop/natural earth/_CEMaster.dta"
 
//Summary Statistics total sample
sum co2mtpc Lifeexpectancyatbirthtotal Deathratecrudeper1000peo energyusekgofoilequivalent ny_gdp_pcap_kd Populationtotal

//summary statistics regional samples

sort region
by region: sum co2mtpc Lifeexpectancyatbirthtotal Deathratecrudeper1000peo energyusekgofoilequivalent ny_gdp_pcap_kd Populationtotal

correlation analysis
corr  co2mtpc Lifeexpectancyatbirthtotal Deathratecrudeper1000peo energyusekgofoilequivalent ny_gdp_pcap_kd Populationtotal
pwcorr co2mtpc Lifeexpectancyatbirthtotal Deathratecrudeper1000peo energyusekgofoilequivalent ny_gdp_pcap_kd Populationtotal, star(0.05) sig

 *generate groups according to regions
 
 egen _region = group(regionname)
 
 // CO2 emissions (kg per PPP $ of GDP)//
 
 wbopendata, indicator(SP.URB.TOTL.IN.ZS) long clear
 rename sp_urb_totl_in_zs urbanpercent
 
 *unitroot tests
 *Im pesaran and shin
 *Im-Pesaran-Shin unit-root urban
 xtunitroot ips urban
 xtunitroot ips urban, trend demean
 xtunitroot ips lnurban, trend demean
 xtunitroot ips lnurban, trend demean lags(1)
 *unitroot achieved
 xtunitroot ips dlnurban, trend demean lags(1) 
 
 *Im-Pesaran-Shin unit-root urban population %
 xtunitroot ips urbanpercent, trend demean lags(1)
 *unitroot achieved
 xtunitroot ips urbanpercent
 
 *unitroot test for deathrate
 xtunitroot ips deathrate
 xtunitroot ips deathrate, trend demean lags(1)
 
 *unitroot tests gdp current
 *Im-Pesaran-Shin unit-root test for gdpcurrent
 xtunitroot ips gdpcurrent
 xtunitroot ips gdpcurrent, trend demean lags(1)
 
 *unitroot achieved
 xtunitroot ips lngdpcurrent, trend demean lags(1)
 
 *Im-Pesaran-Shin unit-root test for gdpconstant
  xtunitroot ips gdpconstant
  xtunitroot ips gdpconstant, trend demean lags(1)
  
  *unitroot achieved
  xtunitroot ips lngdpconstant, trend demean lags(1)
  
  *Im-Pesaran-Shin unit-root test for carbonkt
  Im-Pesaran-Shin unit-root test for carbonkt
  
  *unitroot achieved
  xtunitroot ips carbonkt, trend demean lags(1)
  
  Im-Pesaran-Shin unit-root test for emissions
  xtunitroot ips emissions
  
  *unitroot achieved
  xtunitroot ips emissions, trend demean lags(1)
  
  *Im-Pesaran-Shin unit-root test for life
  xtunitroot ips life
  
  *unitroot achieved
  xtunitroot ips life, trend demean lags(1)
 
 * principal sample estimation
 //model 1
 xtpcse lncarbon lnlife lnenergy lnpop lnGDPpcap i.year, corr(ar1) hetonly pairwise
 xtgls lncarbon lnlife lnenergy lnpop lnGDPpcap i.year,  corr(ar1) p(het) force
 
//model 2
xtpcse lncarbon lndeath lnenergy lnpop lnGDPpcap i.year, corr(ar1) hetonly pairwise 
xtgls lncarbon lndeath lnenergy lnpop lnGDPpcap i.year,  corr(ar1) p(het) force 

//model 3
 xtpcse lnlife lncarbon lnenergy lnpop lnGDPpcap i.year, pairwise hetonly corr(ar1)
 xtgls lnlife lncarbon lnenergy lnpop lnGDPpcap i.year, p(het) corr(ar1) force

*region-wise estimation
*model 1 
*Panel corrected standard errors
xtpcse lncarbon lnlife lnenergy lnpop lnGDPpcap  i.year   if  region==1, pairwise corr(ar1) hetonly 
xtpcse lncarbon lnlife lnenergy lnpop lnGDPpcap  i.year   if  region==2, pairwise corr(ar1) hetonly 
xtpcse lncarbon lnlife lnenergy lnpop lnGDPpcap  i.year   if  region==3, pairwise corr(ar1) hetonly 
  
*model 2
*Panel corrected standard errors
xtpcse lncarbon lndeath lnenergy lnpop lnGDPpcap i.year if region==1, corr(ar1) hetonly pairwise 
xtpcse lncarbon lndeath lnenergy lnpop lnGDPpcap i.year if region==2, corr(ar1) hetonly pairwise 
xtpcse lncarbon lndeath lnenergy lnpop lnGDPpcap i.year if region==3, corr(ar1) hetonly pairwise  

*Model 3
*Panel Corrected Standard Errors
xtpcse lnlife lncarbon lnenergy lnpop lnGDPpcap i.year if region==1, pairwise hetonly corr(ar1)
xtpcse lnlife lncarbon lnenergy lnpop lnGDPpcap i.year if region==2, pairwise hetonly corr(ar1)
xtpcse lnlife lncarbon lnenergy lnpop lnGDPpcap i.year if region==3, pairwise hetonly corr(ar1)
 
*Feasible Generalised Least Squares
*model 1
xtgls lncarbon lnlife lnenergy lnpop lnGDPpcap  i.year if  region==1, corr(ar1) p(het) force
xtgls lncarbon lnlife lnenergy lnpop lnGDPpcap  i.year if  region==2, corr(ar1) p(het) force
xtgls lncarbon lnlife lnenergy lnpop lnGDPpcap  i.year if  region==3, corr(ar1) p(het) force
 
*Feasible Generalised Least Squares
*model 2
xtgls lncarbon lndeath lnenergy lnpop lnGDPpcap i.year  if region==1, corr(ar1) p(het) force 
xtgls lncarbon lndeath lnenergy lnpop lnGDPpcap i.year  if region==2, corr(ar1) p(het) force
xtgls lncarbon lndeath lnenergy lnpop lnGDPpcap i.year  if region==3, corr(ar1) p(het) force 

*Feasible Generalised Least Squares
*model 3  
xtgls lnlife lncarbon lnenergy lnpop lnGDPpcap i.year  if region==1, p(het) corr(ar1) force 
xtgls lnlife lncarbon lnenergy lnpop lnGDPpcap i.year  if region==2, p(het) corr(ar1) force
xtgls lnlife lncarbon lnenergy lnpop lnGDPpcap i.year  if region==3, p(het) corr(ar1) force


**testing for kuznets curve
//total Sample estimation
xtpcse lncarbon lnlife lnenergy lnGDPpcap gdp2, hetonly pairwise corr(ar1)

//region-wise estimation
xtpcse lncarbon lnlife lnpop lnGDPpcap gdp2  i.year if region==1, hetonly pairwise corr(ar1)

xtpcse lncarbon lnlife lnpop lnGDPpcap gdp2  i.year if region==2, hetonly pairwise corr(ar1)

xtpcse lncarbon lnlife lnpop lnGDPpcap gdp2  i.year if region==3, hetonly pairwise corr(ar1)
 
 

