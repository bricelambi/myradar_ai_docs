.. myradar-ai-docs documentation master file, created by
   sphinx-quickstart on Sat Feb 19 10:40:33 2022.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to myradar-ai-docs's documentation!
===========================================

MyRadar.AI is a set of RESTful API endpoints for accessing weather data for use in data science applications.

Quick Start
===========

.. code-block:: python

   url = f"https://wxroutingapp.azurewebsites.net/point?latlons=[[41.5,-105.1],[36.1,-96.34]]&as_csv=true"
   c = requests.get(url, stream=True) # make a request
   df = pd.read_csv(c.raw, parse_dates=['valid_time'])


Tutorials
=========

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   tutorials
   reference

Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
