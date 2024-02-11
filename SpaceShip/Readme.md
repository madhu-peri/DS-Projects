# Spaceship Titanic

The premise of this project was to predict which hypothetical passengers were transported out of the Spaceship Titanic to an alternate dimension during an accident in space. This was done using passenger records recovered from the remains of the ship.

Data available at: https://www.kaggle.com/competitions/spaceship-titanic/data

### Breaking Down the Data

- The train dataset has a total of 14 columns while the test dataset has 13 columns, the differnece between both datasets being the     presence/absence of the "Transported" column.
- The goal is to use the "Transported" column in the train dataset to train a random forest machine learning model into predicting/creating the "Transported" column when given the test dataset.
- The "Transported" column consists of boolean values.
- The end result displays the "PassengerID" column and the predicted "Transported" column.
- All other columns are used to help train the random forest model 


