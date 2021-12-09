# US-Accidents

**Business Task:**
Analyze the data to find the US state with highest accident count with severity 3 and 4. Find the time of the day when most accidents occur and the description of those accidents. 

**Key Stakeholders:**
1. Anyone reading this document

2. Myself

**Data:** 
This is a countrywide car accident dataset, which covers 49 states of the USA. The accident data are collected from February 2016 to Dec 2020, using multiple APIs that provide streaming traffic incident (or event) data. These APIs broadcast traffic data captured by a variety of entities, such as the US and state departments of transportation, law enforcement agencies, traffic cameras, and traffic sensors within the road-networks. Currently, there are about 1.5 million accident records in this dataset.

**Acknowledgement:**

1. Moosavi, Sobhan, Mohammad Hossein Samavatian, Srinivasan Parthasarathy, and Rajiv Ramnath. “A Countrywide Traffic Accident Dataset.”, 2019.

2. Moosavi, Sobhan, Mohammad Hossein Samavatian, Srinivasan Parthasarathy, Radu Teodorescu, and Rajiv Ramnath. "Accident Risk Prediction based on Heterogeneous Sparse Data: New Dataset and Insights." In proceedings of the 27th ACM SIGSPATIAL International Conference on Advances in Geographic Information Systems, ACM, 2019.
 
**Insights and Recommendations**

1. First we start by finding out which state in the US has the highest amount of accidents. As we can see from the image below, California has the highest no of accidents with a count of 448,484 accidents from February 2016 to Dec 2020.

![Total Accidents Per State](https://user-images.githubusercontent.com/65936796/145345986-8408ffbf-e6ca-40a0-a7fd-178b129d35f6.png)

2. Next we find out the percentage of accidents in California with severity 3 and 4 compared to the total accidents in the US with severity 3 and 4. As we can see from the image below, 10.5 % of all the accidents with severity 3 and 4 occurs in California. The count of accidents equate to 28833.

![Percentage across US](https://user-images.githubusercontent.com/65936796/145346423-d7c48f2e-c31d-4e37-bdd3-bd7691d190f6.png)

3. Out of the 28833 accidents, I found out the count of each accident type (description of the accident) that occured in California during the survey period. I have visualized top 10 accident types along with their count in the below image.

![Top 10](https://user-images.githubusercontent.com/65936796/145346974-114d52b0-11db-4134-89c2-1b8a9eaa40f8.png)

4. Later I worked on finding the time of the day when most accidents occur. As we can see from the image below, most of the accidents start between and including 2 PM and 6 PM. But there is another small spike between and including 6 AM and 9 AM. Observing this, I have assumed that this is the commute time to and from work for most Californians.

![Time of the day](https://user-images.githubusercontent.com/65936796/145347462-ecf55931-8373-4106-9056-4a1c3c203c50.png)

5. Since we know the commute time, I'm now checking the time of the day when the accident type "At I-605 - Accident" occurs the most. As we can see from the image below, 25 of the 52 accidents occur during the commute time mentioned before.

![Time of the Day when At I-605 Accidents occur](https://user-images.githubusercontent.com/65936796/145355285-1548e03c-cc2e-4166-be32-1bd9c98e8f78.png)

6. Even though "At I-605 - Accident" occurs 25 out of 52 times during the commute hour, if we are trying to solve the issue each hour at a time, then this accident type is not the one we have to solve first because the maximum this accident type occurs is at 5 AM and the count is 6. Where as from the below image we can see that "At I-15 - Accident" has a count of 13 accidents split between 6 AM and 6 PM

![Hours Top 10](https://user-images.githubusercontent.com/65936796/145357286-299e4b9a-7fab-4a1a-b706-db4e58de3d8c.png)

7. Recommendation: 

   a. If we want to resolve the accident type with severity 3 and 4 that occurs the most in California, then "At I-605 - Accident" needs to be resolved as it is not just most recurring accident but also occurs 25 out of 52 times in the commute hours.
   
   b. But if we want to resolve the accident type with severity 3 and 4 that occurs the most during the day, then "At I-15 - Accident" needs to be resolved as it occurs 7 times at 6 AM and 6 times at 6 PM, the highest occuring accident during commute hours. Compared to this, "At I-605 - Accident" occurs only 6 times a day and that too at 5 AM which is not a commute time. 

** All images were created using Tableau software. Link to Tableau profile: https://public.tableau.com/app/profile/vikas4821
