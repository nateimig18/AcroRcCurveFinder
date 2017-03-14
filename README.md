# AcroRcCurveFinder

This is a quick MATLAB script (*.m), I wrote to help me responsibly feel out a good RC curve in both the KISS Flight Controller & BetaFlight FC that has equal sensitivity at "center-stick" & the same end points at "full-stick". It generates a number of RC curves that meet the center slope & end-point criteria you define while varying the degree of width for the curve's center-stick linearity region. The two output plots both have a legend with the RC Rate, Rate, & Curve (for KISS) or RC Rate, Rate, & RC Expo (for Betaflight) shenanigan parameters for each curve that the KISS configurator then uses. Below is a test output:

# Test output plots:
![rc_output_kiss_s200_e900](https://cloud.githubusercontent.com/assets/3208983/23919726/fc397016-08c5-11e7-8ec3-c604a77f7617.jpg)
![rc_output_bf_s200_e900](https://cloud.githubusercontent.com/assets/3208983/23919843/75d6ce78-08c6-11e7-9e2d-3398a03defec.jpg)

# Application
To provide a little more user friendly way to find an RC-curve that fits your desired flight profile without the constant end-points & center sensitivity parameters changing. 

## TODO:
Make a more portable version that can be used out in the field while flying. 
