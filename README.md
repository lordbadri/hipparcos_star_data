# hipparcos_star_data

#planets_1.m 

Extracts all the hipparcos photometry data for planet hosting hipparcos stars and saves it into the directory.
I have uploaded the data files the program extracts hip_planet_host_data
I recommend running this code once a week as the servers get updated weekly, and new exoplanet host stars will be flagged.
The naming cconvention I have followed is as HIP_star-number_number-of-planets.tbl


#HIP_all_stars.m 

Extracts photometry data for all the hipparcos stars, over 118000. This code will take a long time to run.
The data extracted will be over 2GB, I would suggest leaving it to run overnight.
I am working on implementing this is Pyspark but the delay is due to the fact that we have to request and extract the file from
the server.


