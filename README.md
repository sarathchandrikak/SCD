**🚀 Understanding Slowly Changing Dimensions (SCD) in Data Warehousing**  

In the world of data warehousing, tracking changes to dimensional data over time is *crucial* for accurate historical analysis. That’s where **Slowly Changing Dimensions (SCD)** come in.

📊 SCD refers to how we manage and store changes in dimension tables — like customer profiles, product details, or employee data — where values don’t change often, but *when they do*, they matter.

Here are the **3 most common types of SCD**:

**🔹 SCD Type 1 – Overwrite**  
👉 The old value is replaced with the new one.  
✅ Simple, but you lose history.  
**Use case:** Fixing the aisle if a product moves aisle, we don't need old information.

**🔹 SCD Type 2 – Add New Row**  
👉 Keeps full history by inserting a new record with effective dates.  
✅ Best for tracking changes over time.  
**Use case:** Employee address change/ department change over years, will manage with effective dates.

**🔹 SCD Type 3 – Add New Column**  
👉 Adds columns for old and new values.  
✅ Tracks limited history (e.g., previous value only).  
**Use case:** Storing previous and current product discount to track.

💡 Choosing the right type depends on your **business need for historical accuracy** and data analysis.

🔍 If you're building dimensional models or designing data pipelines — understanding SCD is non-negotiable.


**🚀 Implementation** 

### Schema 
Please refer to schema of sales database
![image](https://github.com/sarathchandrikak/SCD/blob/main/scd_schema.png)

### SQL queries 

Create tables and insert data into the tables of PostgreSQL 
Queries to insert into tables are available https://github.com/sarathchandrikak/SCD/blob/main/schema.sql 

### SCD Implementation

SCD type 1, 2, 3 are implemented on employees, items, discounts table and queries corresponding to that are available https://github.com/sarathchandrikak/SCD/blob/main/queries.sql 
