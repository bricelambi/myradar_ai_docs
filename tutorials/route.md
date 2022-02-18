
## Get a route forecast and make a plot ##

This tutorial will demonstrate how to make a route based forecast request and plot it on the screen.  A point forecast is data for one point going into the future, each geographic point has many data values.  In a route request, there is an origin and destination and you are returned a route with many points with one data value at each point.

First make a query with a route and destination

```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import requests
import json


init_time = "20211101.0000"
origin = "41.5,-105.1"
destination = "36.1,-96.4"

url = f"https://wxroutingapp.azurewebsites.net/route?origin={origin}&destination={destination}&itime={init_time}&as_csv=true"

c = requests.get(url)
```

Because as_csv=true was included as a URL parameter, the results will be returned as CSV data that can be loaded as a pandas dataframe

```python
df = pd.read_csv(c.raw, parse_dates=['valid_time'])

var_names = ['t','rt','wspd'] # for simplicity we only plot three variables, too many variables would crowd the screen
df = df.loc[df['var_name'].isin(var_names)]

g = sns.FacetGrid(df, row='var_name', sharey=False)
g.map(sns.lineplot, 'valid_time', 'value')
plt.show()

```

![plot results from route forecast](route.png)
