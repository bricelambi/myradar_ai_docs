

    routes: [{
      time_series:{ //see data dictionary for list of variables
        cloud_cover:[...],
	t:[...],
      	...
      },
      valid_times: [...], //list of epoch timestamps that match time series data
      route:{...}, //optional if include_route=true
      points: "...", //encoded polyline as string
   }]



