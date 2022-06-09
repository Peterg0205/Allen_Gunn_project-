-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/br8ib9
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/br8ib9
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Census_api" (
    "GEOID" INT   NOT NULL PRIMARY KEY,
    "State_Fips" INT   NOT NULL,
    "State" VARCHAR   NOT NULL,
    "State_Abbr" VARCHAR   NOT NULL,
    "School_Dist_Code" INT   NOT NULL,
    "School_Dist_Name" VARCHAR   NOT NULL,
    "Ages_5-17_in_Families_in_Poverty,Count_Est" INT   NOT NULL,
    "YEAR" INT   NOT NULL

);

CREATE TABLE "Overweight_data" (
    "YEAR" VARCHAR   NOT NULL,
    "LocationAbbr" VARCHAR   NOT NULL,
    "LocationDesc" VARCHAR   NOT NULL,
    "ShortQuestionText" VARCHAR   NOT NULL,
    "Greater_Risk_Question" VARCHAR   NOT NULL,
    "Greater_Risk_Data_Value" INT   NOT NULL,
    "Greater_Risk_Low_Confidence_Limit" INT   NOT NULL,
    "Greater_Risk_High_Confidence_Limit" INT   NOT NULL,
    "Lesser_Risk_Question" VARCHAR   NOT NULL,
    "Lesser_Risk_Data_Value" INT   NOT NULL,
    "Lesser_Risk_Low_Confidence_Limit" INT   NOT NULL,
    "Lesser_Risk_High_Confidence_Limit" INT   NOT NULL,
    "Sample_Size" INT   NOT NULL,
    "Sex" VARCHAR   NOT NULL,
    "Race" VARCHAR   NOT NULL,
    "Grade" VARCHAR   NOT NULL,
    "GeoLocation" INT   NOT NULL,
    "LocationId" INT   NOT NULL Primary key,
    "StratificationType" VARCHAR   NOT NULL
);
