# Allen_Gunn_project-
<h1>Project #2 Extract, Transform, and Load</h1>

Project Proposal: We are extracting Obesity Overweight and Weight Control Data from the 2017 Youth Behavioral Surveillance System data from Kaggle.com and comparing it to poverty data for US School Districts from the 2017 US Census API. After extracting and transforming the data, the databases will be loaded into a SQL database in Postgres using python. 


## Description
Project Plan: We are extracting Obesity Overweight and Weight Control Data from the 2017 Youth Behavioral Surveillance System data from Kaggle and comparing it to poverty data for US School Districts from the 2017 census API.

- What was your motivation? 
In the United States of America, obesity is often linked to food deserts, resource-scarce areas, and poverty. This is especially crucial when it comes to the youth aged 5-17 who often rely on school for meals. We wanted to provide a dataset that would allow the relationship between youth in poverty in the school district of different states and obesity, overweight, and weight control data.
We wanted to provide a database to a client who wants to compare Obesity Overweight and Weight Control data from the  Youth Behavioral Surveillance System of 2017 to Census Small Area Income and Poverty Estimates (SAIPE) of income and poverty statistics for all school districts, counties, and states with the ability to focus on the number of children ages 5 to 17, and the number of related children ages 5 to 17 in families in poverty estimates for school districts in 2017 in order to view observable relationship. 
This goes hand and hand with the Obama school nutrituion policy estashblished in 2010. This evidence was clear that correlation of nutrtion standards and lower income areas were signically lowered. This dataset illuminates why the Hunger-Free Kids Act was nessasaty to change childerns health for the better. 
- What problem does it solve?
This database provides access to school district data that has estimates of youth in poverty count by state for a random sample of 100 districts in the US. Additionally, this database includes data that has the 2017 Obesity risk rate by state, race, grade, and gender for youth aged 5-17. This database has the appropriate data needed to observe the school districts that have the most youth in poverty by count and the risk rate for obesity for youths in 2017 by state. 
- What did you learn?
We learned that the Census API is accessible for all for free and the Youth Behavioral Surveillance System is accessible to the public by the CDC. We also learned that you can pull data from any source combine, condense, and analyze data all in one place. In this case we pulled a dataset from kaggle as well as from Cenus API cleaned and then imported it into a database for further analyzation. From there you may join, create relations, and breadown tables further. This is exetremely useful for client and stakeholder visibility. 
## Table of Contents (Optional)

If your README is long, add a table of contents to make it easy for users to find what they need.

- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Installation
<h2><b>Extract</b></h2>
<h4><b> API installation</b></h4>
<br>
1.  Sign up for a free API key with the census website 
<br> -----------------------<br>
https://api.census.gov/data/key_signup.html.
<br> -----------------------<br>
<br>
2.  Utilize this url to query data:
<br> -----------------------<br>
https://api.census.gov/data/timeseries/poverty/saipe/schdist?get=GEOID,SD_NAME,SAEPOV5_17RV_PT&for=school+district+(Secondary)&YEAR=2017
<br> -----------------------
<br><i>The API url used to extract data was built using the Census variable dictionary: </i>
<br> -----------------------<br>https://api.census.gov/data/timeseries/poverty/saipe/variables.html 
<br> -----------------------
<br>--Should other variables be necessary copy them from the variable dictionary behind SAEPOV5_17RV_PT before the "&".
<br>
<br>
1.  In an IPYB file in Jupyther Notebook Utilized the following dependencies: Pandas, requests, us, JSON and pprint.
<br>--import pandas as pd 
<br>--import requests 
<br>--import us
<br>--import json
<br>--from pprint import pprint 
<br>--# api keys
<br>--from api_keys import census
<br>
<br>
2.  Once the url was created it was queried with a Census API key. Create a configuration file that will be added to your Gitnore for your API key. Here we created a file called api_keys.py and imported our ‘census’ API key as a dependency. <br><br>
3.   Once we requested the data from the API, JSON was used to translate the data. Using the following commands:
<br>--# Build query URL
<br>--query_url = url + "&key=" + census 
<br>--# Get poverty data
<br>--pov_response = requests.get(query_url)
<br>--pov_json = pov_response.json()<br><br>
<h2><b>Transform</b></h2>
4.  The data was inputted into Pandas in an almost CSV-like format with the headers of the dataset as the first list within the dataset. This was observable by calling the first row using pov_json[0] (the name of our JSONified data). <br><br>
5.  This allowed us to input the dataset input the data into a data frame using the pd.DataFrame function.
<br>--pov_df=pd.DataFrame(columns=pov_json[0], data=pov_json) <br><br>
6.  Once in a data frame, we dropped the first row so that the headers would not be duplicated and reset the index to reflect that. 
<br>--pov_df.drop(index=pov_df.index[0], axis=0,inplace=True)
<br>--pov_df.reset_index(inplace=True, drop=True) <br><br>
7.  The next step was to clean the data further and make it useable. The state column did not have string variables but only the State FIPS code in the ‘state’ column. Using the US python dictionary the FIPS code was translated to create both the ‘State’ and ‘State Abbreviation’ columns. 
<br>--fips_to_name = us.states.mapping("fips", "name")
<br>--pov_df["State"] = pov_df["state"].map(fips_to_name)
<br>--fips_to_name = us.states.mapping("fips", "abbr")
<br>--pov_df["State Abbr"] = pov_df["state"].map(fips_to_name) <br><br>
8.  <i>(OPTIONAL Renaming columns)</i>The ‘state’ column was renamed to be ‘State Fips’.The 'SAEPOV5_17RV_PT' column was renamed to be 'Ages 5-17 in Families in Poverty, Count Est'. The 'SD_NAME' column was renamed to be 'School Dist Name'. Lastly, the 'school district (secondary)' column was renamed to be ‘School Dist Code'. <br>
--# Rename state colomn to be State Fips code
<br>--pov_df.rename(columns={'state':'State Fips'}, inplace = True)
<br>--# Rename Census data code to appropriate name
<br>--pov_df.rename(columns={'SAEPOV5_17RV_PT':'Ages 5-17 in Families in Poverty, Count Est'}, inplace = True)
<br>--# Rename SD to School District Name
<br>--pov_df.rename(columns={'SD_NAME':'School Dist Name'}, inplace = True)
<br>--# Rename school district (secondary) to School District Code
<br>--pov_df.rename(columns={'school district (secondary)':'School Dist Code'}, inplace = True) <br><br>
9.  <i>(OPTIONAL Reordering columns)</i> The columns were then reorganized to put location data together and school district data together. 
<br>--# Reorder columns 
<br>--pov_df=pov_df[['GEOID','State Fips','State','State Abbr','School Dist Code','School Dist Name','Ages 5-17 in Families in Poverty, Count Est','YEAR']] <br><br>
10. The next step was to clean duplicates and drop null values if there were any. Using the following code: 
<br>--pov_df.drop_duplicates(subset=None, keep='first', inplace=False, ignore_index=False)
<br>--pov_df.dropna(axis=0, how='any', thresh=None, subset=None, inplace=False) <br><br>
11. This left the data frame with 402 entries. For the purpose of this project we sampled 100 rows, reset the index, then saved the data into a CSV titled “School_Poverty_data2017.csv”.
<br>--new_pov_df= pov_df.sample(100)
<br>--new_pov_df.reset_index(inplace=True, drop=True)
<br>--new_pov_df.to_csv("School_Poverty_data2017.csv",index=False, header=True) <br><br>
<h2><b>Extract</b></h2>
<h4><b> CSV Dataset installation</b></h4>
1. Use free dataset on Kaggle site https://www.kaggle.com/datasets/raylo168/dash-yrbss-hs-2017?resource=download&select=Obesity+Overweight+and+Weight+Control.csv
<br><br>
2. Create IPYB in Jupyter Notebook, import all dependencies to clean, import, and manipulate data. 
<br>--import pandas as pd
<br>--from sqlalchemy import create_engine
<br>--from sqlalchemy import create_engine
<br>--import requests
<br>--import json
<br><br>
3. Create varibale to read in dataset into Jupyter Notebook. You must show the location of csv from the folder on your computer. 
<br>--clean_data = "Resources/Obesity Overweight and Weight Control Final Clean.csv"
<br><br>
<h2><b>Transform</b></h2>
4. Convert csv dataset into a dataframe. This will allow you to manipulate data as needed. 
<br>-clean_data_df = pd.read_csv("Obesity Overweight and Weight Control Final Clean.csv")
<br><br>
5. First step in cleaning the data is to remove all null values using the .dropna function. 
<br>
<br>--#Drop all null values
<br>--dropna_data = clean_data_df.dropna()
<br>--#check to ensure all null values were removed
<br>--dropna_data.head(5)
<br><br>
6. Once dataframe no longer has null values create a sandbox dataframe to further work with the data. This allows you to alter the data without affecting the integrity of the orginal dataframe. 
<br>
<br>--Creating Sandbox dataframe
<br>--copy_df = dropna_data.copy()
<br>--copy_df
<br><br>
7. The orginal dataset has a abundance of data to use so create a small sample size. The key advantage of a sample is that less data is needed to be collected and analyse. While still resulting in an accurate represenation of the dataset as a whole. Also, the dataset was much to large to export.
<br><br>
#Create sample using .sample function. <br>
#Choose the disire size of sample(We choose 100 in this case) 
<br>--copy_df.sample(100, replace = True)
<br>--copy_df
<br><br>
8.In addition to dropping null values to clean data you also must ensure there are no duplicate values in the data. 
<br>
<br>--#Remove Duplicates
--<br>copy_df.drop_duplicates(subset=None,keep='first', inplace= False, ignore_index= False)
--# Display dataframe to check if function worked. 
--new_copy_df
<br><br>
9. After cleaning is finished, set the index to reflect the number of rows in dataframe. 
<br>
#Reset Index 
--new_copy_df.reset_index(inplace=True, drop=True)
--new_copy_df
<br><br>
10. Last step is into convert dataframe back into a csv so it can be exported. 
<br>
--#Dataframe to csv <br>
--new_copy_df.to_csv('Obesity Overweight and Weight Control Final Clean.csv')
<br>
<br>
<h2><b>Load into SQL Postgres</b></h2>
<br>
1.	Add dependencies
<br>--import sqlalchemy
<br>--from sqlalchemy import create_engine,inspect, func
<br>--from sqlalchemy_utils import database_exists, create_database
<br>--import pandas as pd
<br>--from api_keys import password
<br><br>
2.	Create your engine that connects Python to PostgresSQL to Pandas in your Jupyter Notebook using the following code. From the config.py file you created (in this case it’s api_keys.py) we will add the Postgres database password and import it to create the engine. 
<br>--engine = create_engine(f'postgresql://postgres:{password}@localhost:5433/obes_pov2017_db')<br><br>
3.	The last part of the engine “obes_pov2017_db” is going to be the name of the database in postgres. However it is not created at this point. Using the sqlalchemy_utils dependency we will add an IF statement that will create the database if the database does <b>NOT</b> exist.
<br>--if not database_exists(engine.url):
<br>-----create_database(engine.url)
<br>># make sure sqalchemy_utils did it correctly 
<br>-----print(database_exists(engine.url))<br><br>
4.	Next connect the CSVs that were created above to Pandas to be read: 
<br>--csv_ob = pd.read_csv('./Obesity Overweight and Weight Control Final Clean.csv')
<br>--csv_cen= pd.read_csv('./School_Poverty_data2017.csv')<br><br>
5.	The last step is to convert the Pandas dataframes to SQL tables in Postgres.
<br>--csv_ob.to_sql(name= "ob_data", con=engine, schema=None, if_exists='append', index= False)
<br>--csv_cen.to_sql(name= "cen_data", con=engine, schema=None, if_exists='append', index= False)
<br><br>
6.	Open Postgres to ensure database was created. <br><br>



## Usage

<h4><b> Install depencies for API  </b></h4>
  
<br>--# create addtional config file for API key  
<br>
<br>--Select new in the top right hand corner
<br>-- Select "Text file" 
<br>
![Screen Shot 2022-06-11 at 3 27 52 PM](https://user-images.githubusercontent.com/101233216/173202945-7d8acc7b-942d-47e6-abe7-7f8b3f4d348b.png)
<br>
<br>--# Create varibale for API key 
<br> --Input your postress password
<br>
![image](https://user-images.githubusercontent.com/101233216/173202992-5986ece9-136b-450d-9293-7d349d0be805.png)  
<br>
<br>--#import decepecies from cell 1
<br>--Create varibles to import API into Jupyter Notebook 
<br>
![image](https://user-images.githubusercontent.com/101233216/173202892-9035a7f3-e981-457d-96fc-43d44dd23dbc.png)
<br>
<h4><b> Importing Sqlalchemy  </b></h4>
<br>--# Use for following depencies for Sqlalchemy 
<br> ![image](https://user-images.githubusercontent.com/101233216/173203151-2a840061-1225-4afa-99fa-4f655a29580e.png)
<br><br>
<h4><b> Import CSV  </b></h4>
<br> 1. -- Import dependines from cell 2 
<br> 2. --Create variable to read in csv from cell 3
<br> 3. -- Convert csv to dataframe using .read from cell 4 
<br>  
 ![image](https://user-images.githubusercontent.com/101233216/173203290-55a7a8e3-122a-44c2-8751-39f8c2cfaab3.png)
<br>
<h4><b> Dataframe to Database transfer  </b></h4>
<br> 
<br>--# Once database is transfered it should populate on left side of pgAdmin
<br> --Navigate to tables to ensure tables in database were create properly
<br> 
![image](https://user-images.githubusercontent.com/101233216/173203350-9e2f7223-4ec9-4d7c-8c35-c273f2a6ff82.png)
<br>  
<br>
  
## Credits

List your collaborators:
<br>Hannah Allen - https://github.com/hanniecodes
<br>Peter Gunn - https://github.com/Peterg0205<br> 
www.Census.gov
<br>www.Kaggle.com


---
