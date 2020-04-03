% Section 1

CV = readtable('COVID-19-geographic-disbtribution-worldwide-2020-04-02.xlsx');

[countries] = unique(CV.countriesAndTerritories);
[countries_code] = unique(CV.countryterritoryCode);
each_country1 = cell(length(countries),1);
cases_sum1 = zeros(length(countries),1);
deaths_sum1 = zeros(length(countries),1);
popul1 = zeros(length(countries),1);
for ii = 1:length(countries)
    each_country = CV(strcmp(CV.countriesAndTerritories,countries(ii)),:);
    each_country1{ii} = each_country;
    popul = each_country.popData2018(1); 
    popul1(ii) = popul;
    cases_sum = sum(each_country.cases);
    cases_sum1(ii) = cases_sum; % cases per country
    deaths_sum = sum(each_country.deaths);
    deaths_sum1(ii) = deaths_sum; % deaths per country
end

total_cases = sum(CV.cases);
total_deaths = sum(CV.deaths);
total_popul = sum(popul1(~isnan(popul1)));
perc_pop_cases_total = (total_cases/total_popul);
perc_pop_deaths_total = (total_deaths/total_popul);

perc_pop_cases = (cases_sum1./popul1)*100;
perc_pop_deaths = (deaths_sum1./popul1)*100;

country_sel = categorical({'Australia','Brazil','Chile','China','Italy', ...
    'Spain','United_States_of_America','World'});
[C,ia,~] = intersect(countries,country_sel);

figure(1)
hold on
for jj = 1:(length(country_sel)-1)
    t = categorical(datetime(each_country1{ia(jj),1}.dateRep,'InputFormat','dd/MM/yyyy'));
    x = (each_country1{ia(jj),1}.cases);
    plot(t,x)
    legend(['',cellstr(country_sel)])
end
xticks([t(end) t(end-20) t(end-40) t(end-60) t(end-80) t(1)]);
xtickangle(45)
ylabel('Cases')
title('Cases of COVID-19 along time')

figure(2)
hold on
for jj = 1:length(country_sel)
    if jj == length(country_sel)
        bar(country_sel(jj),perc_pop_cases_total)
    else
        bar(country_sel(jj),perc_pop_cases(ia(jj)))
    end
end
ylabel('Cases/Population (%)')

figure(3)
hold on
for jj = 1:length(country_sel)
    if jj == length(country_sel)
        bar(country_sel(jj),perc_pop_deaths_total)
    else
        bar(country_sel(jj),perc_pop_deaths(ia(jj)))
    end
end
ylabel('Deaths/Population (%)')



