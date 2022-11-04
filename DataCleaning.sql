select *
from NashvilleHousing

--standardize sale date
select SaleDate, CONVERT(date,SaleDate)
from NashvilleHousing

update NashvilleHousing
set SaleDate= CONVERT(date,saledate)

Alter Table NashvilleHousing
add SaleDateConverted Date;

update NashvilleHousing
set SaleDateConverted= CONVERT(date,saledate)

--populate property address data
select *
from NashvilleHousing
-- where PropertyAddress is null
order by ParcelID


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) 
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID and a.[UniqueID ] != b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress= ISNULL(a.propertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID and a.[UniqueID ] != b.[UniqueID ]
where a.PropertyAddress is null

--breaking address into individual columns
select PropertyAddress
from NashvilleHousing

select
SUBSTRING(propertyAddress,1,charindex(',', propertyAddress) -1 ) as Address -- -1REMOVES THE LAST CHARACTER
,SUBSTRING(propertyAddress, CHARINDEX(',', propertyAddress) +1 , LEN(propertyAddress)) as City
from NashvilleHousing

alter table	NashvilleHousing
add PropertySplitAddress nvarchar(255);

update NashvilleHousing
set PropertySplitAddress = SUBSTRING(propertyAddress,1,charindex(',', propertyAddress) -1 )

alter table	NashvilleHousing
add PropertySplitCity nvarchar(255);

update NashvilleHousing
set PropertySplitCity = SUBSTRING(propertyAddress, CHARINDEX(',', propertyAddress) +1 , LEN(propertyAddress))

select *
from NashvilleHousing

--breaking owner address
select OwnerAddress
from NashvilleHousing

select 
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
from NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)


ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

Select *
From PortfolioProject.dbo.NashvilleHousing

-- change Y and N to Yes and No in SoldAsVacant
select distinct soldasvacant, count(soldasvacant)
from NashvilleHousing
group by SoldAsVacant

select SoldAsVacant
	,case
		when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		else SoldAsVacant
	end
from NashvilleHousing
where SoldAsVacant like 'Y' or SoldAsVacant like 'N'

update NashvilleHousing
set SoldAsVacant = case
		when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		else SoldAsVacant
	end

--removing dupes

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 -- PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)
delete
From RowNumCTE
where row_num >1

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 -- PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)

select *
From RowNumCTE
where row_num >1

--deleting unused columns
select*
from NashvilleHousing

alter table nashvillehousing
drop column ownerAddress, PropertyAddress, TaxDistrict