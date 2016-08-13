# hipparcos_star_data

planets_1.m extracts all the hipparcos photometry data for planet hosting hipparcos stars and saves it into the directory.
I have uploaded the data files the program extracts hip_planet_host_data
I recommend running this code once a week as the servers get updated weekly, and new exoplanet host stars will be flagged.

HIP_all_stars.m extracts photometry data for all the hipparcos stars, over 118000. This code will take a long time to run.
The data extracted will be over 2GB, I would suggest leaving it to run overnight.
I am working on implementing this is Pyspark but the delay is due to the fact that we have to request and extract the file from
the server.


