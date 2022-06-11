# Allen_Gunn_project-
Project 2 

Project Plan: We are extracting Obesity Overweight and Weight Control Data from the 2017 Youth Behavioral Surveillance System data from Kaggle and comparing it to poverty data for US School Districts from the 2017 census API.
Steps for Extracting , Transforming , and Loading data for Census API data: 
Utilized the following dependencies: Pandas, requests, us, JSON and pprint. 
Data: collected data utilizing the Census API for the Small Area Income and Poverty Estimates (SAIPE) [School Districts: 1995, 1997, 1999-2016] data. https://www.census.gov/data/developers/data-sets/Poverty-Statistics.html This data set is part of a program that provides annual estimates of income and poverty statistics for all school districts, counties, and states with the ability to focus on the number of children ages 5 to 17, and the number of related children ages 5 to 17 in families in poverty estimates for school districts. The API url used to extract data was built using the Census variable dictionary. https://api.census.gov/data/timeseries/poverty/saipe/variables.html The API is free to use and only required a simple email sign-up at this website https://api.census.gov/data/key_signup.html. 
Once the url was created it was queried with a Census API key. Once we requested the data from the API, JSON was used to translate the data. The data was inputted into Pandas in an almost CSV-like format with the headers of the dataset as the first list within the dataset. This was observable by calling the first row using pov_json[0] (the name of our JSONified data) . This allowed us to input the dataset input the data into a data frame using the pd.DataFrame function. Once in a data frame, we dropped the first row so that the headers would not be duplicated and reset the index to reflect that. 
The next step was to clean the data further and make it useable for the client. The state column did not have string variables but only the State FIPS code in the ‘state’ column. Using the US python dictionary the FIPS code was translated to create both the ‘State’ and ‘State Abbreviation’ columns. The ‘state’ column was renamed to be ‘State Fips’. The 'SAEPOV5_17RV_PT' column was renamed to be 'Ages 5-17 in Families in Poverty, Count Est'. The 'SD_NAME' column was renamed to be 'School Dist Name'. Lastly, the 'school district (secondary)' column was renamed to be ‘School Dist Code'. The columns were then reorganized to put location data together and school district data together.  The next step was to clean duplicates and drop null values if there were any. This left the data frame with 402 entries. For the purpose of this project we sampled 100 rows, reset the index, then saved the data into a CSV titled “School_Poverty_data2017.csv”. 


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

What are the steps required to install your project? Provide a step-by-step description of how to get the development environment running.

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
