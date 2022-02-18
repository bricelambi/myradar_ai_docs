
## Points ##

The "points" endpoint can be used for getting a single forecast cycle for one or more points.  For every point that is requested, you will receive a time series for each weather variable provided.  This endpoint has the following parameters:

  + latlons - 2d array of lat/lon points as JSON string
  + itime - date string in format YYYYmmdd.HHMM that will be the begining time of the forecast, can be in the past, default to current time
  + as_csv - if 'true' will return CSV data rather than JSON

The JSON response for a point request has the following structure:

    data : {
      valid_times:[...],
      cloud_cover:[[...]],
      t:[[...]],
      ...
    }

Each weather variable below 'data' will contain a 2d array whose length on the first dimension is the number of points requested.  The 'valid_times' variable is an array of epoch timestamps that matches the length of the time series data.  Each point's data will be at its corresponding index in the array.  See data dictionary below for description of variables and units


## Routes ##

The "routes" endpoint will perform a driving directions lookup between an origin and destination then provide a single time series that represents the weather forecast at each point along the route.  Unlike the 'points' endpoint, the 'routes' endpoint will always return only one time series for each weather variable.  This endpoint accepts the following parameters:

  + origin        - lat,lon pair for the origin point (eg 41.5,-105.1)
  + destination   - lat,lon pair for the destiantion point
  + itime         - initial time for the forecast (aka departure time)
  + include_route - if 'true' then include the complete driving directions response from mapping engine
  + as_csv        - if 'true' return results as CSV rather than JSON

The JSON response for a route request has the following structure:

    routes:[{
      valid_times:[...],
      points:"...",
      time_series:{
        cloud_cover:[...],
        t:[...],
        ...
      }
    }]

Each weather variable below 'time_series' will contain a 1d array that is the length of the route as provided by the driving directions enging.  'valid_times' is a list of epoch timestamps that represents the time the mapping engine believes you will arrive at that waypoint.  The 'points' string is an encoded polyline that contains the lat/lon points the mapping engine provided.

## Historical Data ##

The 'histdata' endpoint builds a continuous time series of data for one or more points between a begin time and end time.  This endpoint accepts the following parameters:

  + begin_time (url path parameter) - begin time in format YYYYmmdd.HHMM
  + end_time (url path parameter) - end time in format YYYYmmdd.HHMM
  + latlons - 2d array of lat/lon points as JSON string 

This endpoint will return a NetCDF with the following structure

```
netcdf data {
dimensions:
        vtime_str = 99 ;
        string13 = 13 ;
        var = 17 ;
        point = 3 ;
        vtime = 108 ;
        string36 = 36 ;
        string11 = 11 ;
        string8 = 8 ;
variables:
        double vtime(vtime) ;
                vtime:_FillValue = NaN ;
        char vtime_str(vtime_str, string13) ;
                vtime_str:_Encoding = "utf-8" ;
        char var(var, string11) ;
                var:_Encoding = "utf-8" ;
        double data(var, point, vtime) ;
                data :_FillValue = NaN ;
        char run_time(string8) ;
                run_time:_Encoding = "utf-8" ;
        char point(point, string36) ;
                point:_Encoding = "utf-8" ;
data:

```


## 2D ##

The 2D endpoint provides weather data as 256x256 mercator tiles with several options for encoding.  This endpoint follows the typical x/y/zoom system and accepts the following url path parameters:

  + product - the name of the product to be requested (HRRR wind speed, GOES CMI, etc)
  + valid_time - the valid time to request in format YYYYmmdd.HHMM
  + x/y/zoom - the x/y/zoom coordinates of the tile being requested

Example URL:

```
https://wxroutingapp.azurewebsites.net/fcst_tile/hrrr.precip.surface/20211210.1200/10/22/6
```

This will return a PNG...talk more about encoding options here


## Data Dictionary ##

The 1d time series data dictionary is as follows:

  * vddsf - Visible Diffuse Downward Solar Flux w/m^2
  * vbdsf - Visible Beam Downward Solar Flux w/m^2
  * rad - Downward Short-Wave Radiation Flux w/m^2
  * d_rad - Lagged rad
  * d_prate - Lagged precip rate
  * d_snod - Lagged snow depth
  * prate - Precip Rate mm/hr
  * ptype - precip type
  * rh - Relative Humidity 0-100
  * snod - Snow Depth mm
  * cloud_cover - Cloud Cover 0-100
  * t - Air Temp C
  * rt - Road Temp C
  * wspd - Wind Speed m/s
  * wdir - Wind Direction 0-360

2D product names:

    + hrrr.DLWRF.surface
    + hrrr.DSWRF.surface
    + hrrr.LAG_DSWRF.surface
    + hrrr.LAG_PRATE.surface
    + hrrr.LAG_SNOD.surface
    + hrrr.PRATE.surface
    + hrrr.PRES.surface
    + hrrr.PTYPE.surface
    + hrrr.RH.2_m_above_ground
    + hrrr.SNOD.surface
    + hrrr.TCDC.entire_atmosphere
    + hrrr.TMP.2_m_above_ground
    + hrrr.TMP.surface
    + hrrr.VBDSF.surface
    + hrrr.VDDSF.surface
    + hrrr.WDIR.10_m_above_ground
    + hrrr.WSPD.10_m_above_ground
    * SeamlessHSR
    - ABI-L2-CMIPC


