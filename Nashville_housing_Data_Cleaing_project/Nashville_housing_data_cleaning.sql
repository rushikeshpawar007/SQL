create database nashville_housing;

use nashville_housing;

CREATE TABLE Nashville_housing (
    
    
	UniqueID int,
	ParcelID int,
	LandUse varchar(225),
	PropertyAddress varchar(225),
	SaleDate DATE not null,
	SalePrice int,
	LegalReference int,
	SoldAsVacant varchar(225),
	OwnerName varchar(225),
	OwnerAddress varchar(225),
	Acreage int,
	TaxDistrict varchar(225),
	LandValue int,
	BuildingValue int,
	TotalValue int,
	YearBuilt int,
	Bedrooms int,
	FullBath int,
	HalfBath int

    );
    
SET GLOBAL local_infile=1;
    
LOAD DATA local INFILE 'C:/Users/Rushikesh/Documents/GitHub/SQL/Nashville_housing_Data_Cleaing_project/Nashville Housing Data for Data Cleaning.csv' 
INTO TABLE nashville_housing 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;    
    
select * from nashville_housing;



