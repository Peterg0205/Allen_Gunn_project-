# Allen_Gunn_project-
Project 2 

Project Plan: We are extracting Obesity Overweight and Weight Control Data from the 2017 Youth Behavioral Surveillance System data from Kaggle and comparing it to poverty data for US School Districts from the 2017 census API.



## Description
Project Plan: We are extracting Obesity Overweight and Weight Control Data from the 2017 Youth Behavioral Surveillance System data from Kaggle and comparing it to poverty data for US School Districts from the 2017 census API.

- What was your motivation? 
In the United States of America, obesity is often linked to food deserts, resource-scarce areas, and poverty. This is especially crucial when it comes to the youth aged 5-17 who often rely on school for meals. We wanted to provide a dataset that would allow the relationship between youth in poverty in the school district of different states and obesity, overweight, and weight control data.
We wanted to provide a database to a client who wants to compare Obesity Overweight and Weight Control data from the  Youth Behavioral Surveillance System of 2017 to Census Small Area Income and Poverty Estimates (SAIPE) of income and poverty statistics for all school districts, counties, and states with the ability to focus on the number of children ages 5 to 17, and the number of related children ages 5 to 17 in families in poverty estimates for school districts in 2017 in order to view observable relationship. 
This goes hand and hand with the Obama school nutrituion policy estashblished in 2010. This evidence was clear that correlation of nutrtion standards and lower income areas were signically lowered. This dataset illuminates why the Hunger-Free Kids Act was nessasaty to change childerns health for the better. 
- What problem does it solve?
This database provides access to school district data that has estimates of youth in poverty count by state for a random sample of 100 districts in the US. Additionally, this database includes data that has the 2017 Obesity risk rate by state, race, grade, and gender for youth aged 5-17. This database has the appropriate data needed to observe the school districts that have the most youth in poverty by count and the risk rate for obesity for youths in 2017 by state. 
- What did you learn?
We learned that the Census API is accessible for all for free and the Youth Behavioral Surveillance System is accessible to the public by the CDC.  


## Table of Contents (Optional)

If your README is long, add a table of contents to make it easy for users to find what they need.

- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Installation

<b> API installation</b>
<br>
1.	Sign up for a free API key with the census website https://api.census.gov/data/key_signup.html.
2.	Utilize this url to query data: --https://api.census.gov/data/timeseries/poverty/saipe/schdist?get=GEOID,SD_NAME,SAEPOV5_17RV_PT&for=school+district+(Secondary)&YEAR=2017
a.	The API url used to extract data was built using the Census variable dictionary. https://api.census.gov/data/timeseries/poverty/saipe/variables.html 
b.	Should other variables be necessary copy them from the variable dictionary behind SAEPOV5_17RV_PT before the &.
1.	In an IPYB file in Jupyther Notebook <b>Utilized the following dependencies: Pandas, requests, us, JSON and pprint. </b>
a.	import pandas as pd 
b.	import requests 
c.	import us
d.	import json
e.	from pprint import pprint 
f.	# api keys
g.	from api_keys import census
2.	Once the url was created it was queried with a Census API key. Create a configuration file that will be added to your Gitnore for your API key. Here we created a file called api_keys.py and imported our ‘census’ API key as a dependency. 
3.	 Once we requested the data from the API, JSON was used to translate the data. Using the following commands: 
a.	# Build query URL
b.	query_url = url + "&key=" + census 
c.	# Get poverty data
d.	pov_response = requests.get(query_url)
e.	pov_json = pov_response.json()
4.	The data was inputted into Pandas in an almost CSV-like format with the headers of the dataset as the first list within the dataset. This was observable by calling the first row using pov_json[0] (the name of our JSONified data). 
5.	This allowed us to input the dataset input the data into a data frame using the pd.DataFrame function. 
a.	pov_df=pd.DataFrame(columns=pov_json[0], data=pov_json)
6.	Once in a data frame, we dropped the first row so that the headers would not be duplicated and reset the index to reflect that. 
a.	pov_df.drop(index=pov_df.index[0], axis=0,inplace=True)
b.	pov_df.reset_index(inplace=True, drop=True)
7.	The next step was to clean the data further and make it useable. The state column did not have string variables but only the State FIPS code in the ‘state’ column. Using the US python dictionary the FIPS code was translated to create both the ‘State’ and ‘State Abbreviation’ columns. 
a.	fips_to_name = us.states.mapping("fips", "name")
b.	pov_df["State"] = pov_df["state"].map(fips_to_name)
c.	fips_to_name = us.states.mapping("fips", "abbr")
d.	pov_df["State Abbr"] = pov_df["state"].map(fips_to_name)
8.	<i>(OPTIONAL Renaming columns)</i>The ‘state’ column was renamed to be ‘State Fips’.The 'SAEPOV5_17RV_PT' column was renamed to be 'Ages 5-17 in Families in Poverty, Count Est'. The 'SD_NAME' column was renamed to be 'School Dist Name'. Lastly, the 'school district (secondary)' column was renamed to be ‘School Dist Code'.
a.	# Rename state colomn to be State Fips code
b.	pov_df.rename(columns={'state':'State Fips'}, inplace = True)
c.	# Rename Census data code to appropriate name
d.	pov_df.rename(columns={'SAEPOV5_17RV_PT':'Ages 5-17 in Families in Poverty, Count Est'}, inplace = True)
e.	# Rename SD to School District Name
f.	pov_df.rename(columns={'SD_NAME':'School Dist Name'}, inplace = True)
g.	# Rename school district (secondary) to School District Code
h.	pov_df.rename(columns={'school district (secondary)':'School Dist Code'}, inplace = True)
9.	<i>(OPTIONAL Reordering columns)</i>The columns were then reorganized to put location data together and school district data together. 
a.	# Reorder columns 
b.	pov_df=pov_df[['GEOID','State Fips','State','State Abbr','School Dist Code','School Dist Name','Ages 5-17 in Families in Poverty, Count Est','YEAR']]
c.	pov_df
10.	 The next step was to clean duplicates and drop null values if there were any. Using the following code: 
a.	pov_df.drop_duplicates(subset=None, keep='first', inplace=False, ignore_index=False)
b.	pov_df.dropna(axis=0, how='any', thresh=None, subset=None, inplace=False)
11.	This left the data frame with 402 entries. For the purpose of this project we sampled 100 rows, reset the index, then saved the data into a CSV titled “School_Poverty_data2017.csv”.
a.	new_pov_df= pov_df.sample(100)
b.	new_pov_df.reset_index(inplace=True, drop=True)
c.	new_pov_df.to_csv("School_Poverty_data2017.csv",index=False, header=True)


## Usage

Provide instructions and examples for use. Include screenshots as needed.

To add a screenshot, create an `assets/images` folder in your repository and upload your screenshot to it. Then, using the relative filepath, add it to your README using the following syntax:

    ```md
    ![alt text](assets/images/screenshot.png)
    ```

## Credits

List your collaborators, if any, with links to their GitHub profiles.

If you used any third-party assets that require attribution, list the creators with links to their primary web presence in this section.

If you followed tutorials, include links to those here as well.

## License

The last section of a high-quality README file is the license. This lets other developers know what they can and cannot do with your project. If you need help choosing a license, refer to [https://choosealicense.com/](https://choosealicense.com/).

---
