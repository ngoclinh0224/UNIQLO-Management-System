-- insert dataset 

-- insert table product
USE Uniqlo
BULK INSERT product
FROM 'C:\Users\Quynh\OneDrive\Documents\Study\CSDL FINAL\product.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n'	
	);



-- insert table price
USE Uniqlo
BULK INSERT price
FROM 'C:\Users\Quynh\OneDrive\Documents\Study\CSDL FINAL\price.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n'	
	);



-- insert table category
USE Uniqlo
BULK INSERT category
FROM 'C:\Users\Quynh\OneDrive\Documents\Study\CSDL FINAL\category.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n'	
	);


-- insert table manager
USE Uniqlo
BULK INSERT manager
FROM 'C:\Users\Quynh\OneDrive\Documents\Study\CSDL FINAL\manager.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n'	
	);



-- insert table supplier 
USE Uniqlo
BULK INSERT supplier
FROM 'C:\Users\Quynh\OneDrive\Documents\Study\CSDL FINAL\supplier.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n'	
	);



-- insert table inventory
USE Uniqlo
BULK INSERT inventory
FROM 'C:\Users\Quynh\OneDrive\Documents\Study\CSDL FINAL\inventory.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n'	
	);



-- insert table store 
USE Uniqlo
BULK INSERT store
FROM 'C:\Users\Quynh\OneDrive\Documents\Study\CSDL FINAL\store.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n'	
	);



-- insert table customer
USE Uniqlo
BULK INSERT customer
FROM 'C:\Users\Quynh\OneDrive\Documents\Study\CSDL FINAL\customer.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n'	
	);



-- insert table sales 
USE Uniqlo
BULK INSERT sales
FROM 'C:\Users\Quynh\OneDrive\Documents\Study\CSDL FINAL\sales.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n'	
	);



-- insert table bill
USE Uniqlo
BULK INSERT bill
FROM 'C:\Users\Quynh\OneDrive\Documents\Study\CSDL FINAL\bill.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n'	
	);