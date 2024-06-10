# Customer Categorization Using Machine Learning

The premise of this project was to seperate and identify the ideal "mall customer" group and their preferences so that businesses could employ strategies that would result in maximum profit for their company. This was done using K-means clustering on demographic and spending data collected for a set of individuls who had visited the mall. 

### Breaking Down the Data

- The "Customer" data set containes 5 columns of data: "CustomerID", "Gender", "Age", "Annnual.Income..k..", "Spending.Score..1.100."

- The goal is to analyze all 5 columns, determine an optimal amount of K-means clusters for the data, and conduct PCA on tha data to form predictions/conclusions.
  
- All columns have integer values, including the "Gender" column (gender values have been converted into a factor with 2 levels).
