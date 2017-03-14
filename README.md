# AcroRcCurveFinder

This is a quick MATLAB script (*.m), I wrote to help me responsibly feel out a good RC curve in both the KISS Flight Controller & BetaFlight FC that has equal sensitivity at "center-stick" & the same end points at "full-stick". It generates a number of RC curves that meet the center slope & end-point criteria you define while varying the degree of width for the curve's center-stick linearity region. The two output plots both have a legend with the RC Rate, Rate, & Curve (for KISS) or RC Rate, Rate, & RC Expo (for Betaflight) shenanigan parameters for each curve that the KISS configurator then uses. Below is a test output:

# Test output plots:
![rc_output_s150_e900_kiss](https://cloud.githubusercontent.com/assets/3208983/23920119/68812a6a-08c7-11e7-8380-17765a2cec84.jpg)
![rc_output_s150_e900_bf](https://cloud.githubusercontent.com/assets/3208983/23920120/688fe58c-08c7-11e7-9e19-0817772e8b2c.jpg)

![rc_output_s200_e900_kiss](https://cloud.githubusercontent.com/assets/3208983/23920122/68a18846-08c7-11e7-9be5-86a71b1b6ca1.jpg)
![rc_output_s200_e900_bf](https://cloud.githubusercontent.com/assets/3208983/23920121/689d247c-08c7-11e7-83ab-0b99de04b098.jpg)

# Application
To provide a little more user friendly way to find an RC-curve that fits your desired flight profile without the constant end-points & center sensitivity parameters changing. 

## TODO:
Make a more portable version that can be used out in the field while flying. 
