# Pewlett-Hackard-Analysis

## Overview of the analysis
Pewlett Hackard company is preparing the retirement packages for baby boomers who are going to retire at a rapid pace and planning for thounsands of vacancies in the future. This project is to build a dataset by SQL to find out who and how many will be eligible for retirement by departments, titles, and for mentoring the next generation employees. The picture shown below is entity relationship diagram of relationtional databases I would use for analysis.

![The ERD](https://github.com/ZiwenLyu/Pewlett-Hackard-Analysis/blob/main/EmployeeDB.png)


## Results
First, I found retirement eligible staff with thier titles by retrieving employee data, setting employee number as primary key, joining two tables, and filtering their birth dates between 1952-01-01 and 1955-12-31. There are 133,776 employees eligible for retirement, but then I discerned that some employees have changed their position or got promoted so their infos repeated for several times.

![The retirement with titles](https://github.com/ZiwenLyu/Pewlett-Hackard-Analysis/blob/main/retirement_titles.png)

Therefore, I modified the query to retrieve employees' most recent positions and filter on their hire date. The result turned out that 72,458 employees were about to retire in three years. 

![The reitirement with titles unique](https://github.com/ZiwenLyu/Pewlett-Hackard-Analysis/blob/main/unique_titles.png)
![The retirement count](https://github.com/ZiwenLyu/Pewlett-Hackard-Analysis/blob/main/retirement%20count.png)

Then I retrieved the number of retiring employee per title. From the chart we can know that 25,916 Senior Engineers will retire in three years and the company will need a large amount of talents for this position. The second needed position will be senior staff as 24,926 of them will also leave the company. 9,285 engineers, 7,636 staff, 3603 technique leaders, and 1090 assistant engineers will retire.

![The retiring titles](https://github.com/ZiwenLyu/Pewlett-Hackard-Analysis/blob/main/retiring_titles.png)

Also, two department managers will retire so the company should prepare for recruiting candiates for top management.


## Summary
- According to the analysis above, about 72,458 roles will need to be filled as the "silver tsunami" begins to make an impact in three years.
- By retrieving and filtering data by current employees' birth data from 1965-01-01 to 1965-12-31, I found 1,549 qualified, retirement-ready employees in the departments who are eligible to mentor the next generation of Pewlett Hackard employees. Grouping by their titles, we can see that every position will have qualified metors but every mentor will be responsible at least 40-70 new staff. That looks like not enough for new employee training.
![The mentorships](https://github.com/ZiwenLyu/Pewlett-Hackard-Analysis/blob/main/mentorship_eligibilty.png)
![The mentor by title](https://github.com/ZiwenLyu/Pewlett-Hackard-Analysis/blob/main/mentor%20count.png)
