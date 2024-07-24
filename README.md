# Data Exploration Project Using T-SQL

This project involves a detailed data exploration using T-SQL, focusing on a database of medical prescriptions. The implementation includes creating and using the database, defining primary keys, establishing relationships between tables, and performing various queries to extract meaningful insights from the data.

## Features

- **Database Creation and Management**: Set up a database for managing medical prescriptions.
- **Primary Key and Foreign Key Constraints**: Defined primary keys and foreign key constraints to ensure data integrity.
- **Data Exploration Queries**: Implemented multiple queries to analyze the prescription data and extract valuable insights.

## Database Design

The database consists of the following tables:

- **Drugs**: Stores information about drugs, including descriptions and chemical substances.
- **Medical_Practice**: Stores information about medical practices.
- **Prescriptions**: Stores details of prescriptions, including quantities, items, and costs.

## Queries Implemented

1. **Tablets or Capsules**: Retrieves details of all drugs in the form of tablets or capsules.
2. **Total Quantity of Prescriptions**: Returns the total quantity for each prescription, rounded to the nearest integer.
3. **Distinct Chemical Substances**: Returns a list of distinct chemical substances in the Drugs table.
4. **Prescriptions by BNF Chapter**: Returns the number of prescriptions for each BNF chapter, along with the average, minimum, and maximum prescription costs.
5. **Most Expensive Prescription by Practice**: Returns the most expensive prescription prescribed by each practice, only if it is more than £4000.
6. **Chemical Substances with High Prescriptions**: Returns the number of prescriptions and average cost for each chemical substance with more than 100 prescriptions.
7. **High Dosage Drugs in Specific Categories**: Returns details of all drugs above 100mg in specific BNF chapters.
8. **Medical Practices in Bolton with High Prescription Quantity**: Returns all medical practices in Bolton with a prescription quantity above 100.
9. **High Quantity Prescriptions**: Returns the total prescriptions for each BNF code and their corresponding total quantity, only for high volume prescriptions.
10. **Chemical Substances by Practice**: Returns the number of chemical substances associated with each practice name, sorted by frequency.

## Installation and Setup

1. **Clone the Repository**:
    ```sh
    git clone <repository-url>
    cd <repository-directory>
    ```

2. **Set Up the Database**:
    - Use the provided T-SQL script `Analysis of NHS Prescriptions.sql` to create the database and tables.
    - Run the script in your SQL Server Management Studio to set up the database schema and initial data.

## Usage

- Run the provided queries to explore the data and extract insights as described in the sections above.

## Conclusion

This project demonstrates the use of T-SQL for data exploration and analysis in a medical prescriptions database. The queries provided enable detailed insights into prescription patterns, costs, and drug information, helping to uncover valuable information from the data.

For more detailed information, please refer to the project report included in the repository.
